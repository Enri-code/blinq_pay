import 'package:blinq_pay/core/utils/extensions/data_state.dart';
import 'package:blinq_pay/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:blinq_pay/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  @override
  void initState() {
    if (context.read<UsersBloc>().state is! FoundUsersState) {
      context.read<UsersBloc>().add(GetUsersEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          return CustomScrollView(
            cacheExtent: 1000,
            physics: state.dataState.isLoading
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            slivers: [const _AppBarWidget(), const _ScrollBodyWidget()],
          );
        },
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      actions: [ThemeSwitch()],
      bottom: PreferredSize(
        preferredSize: Size(1.sw, 86.h),
        child: SizedBox(
          height: 82.h,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onChanged: (value) {},
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollBodyWidget extends StatelessWidget {
  const _ScrollBodyWidget();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      sliver: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state.dataState.isError) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  state.dataState.error?.message ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }
          if (state is NoUsersState) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'No users found',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }
          if (state is FoundUsersState) {
            return SliverList.separated(
              itemCount: state.data.data.length + 1,
              itemBuilder: (context, index) {
                if (index == state.data.data.length) {
                  return const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final user = state.data.data[index];
                return UserTileWidget(user: user);
              },
              separatorBuilder: (context, index) => 16.verticalSpace,
            );
          }

          return SliverFillRemaining(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final user = User(
                    userId: '',
                    username: 'username',
                    name: 'User Name',
                    bio: '',
                    photo: '',
                  );
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: UserTileWidget(user: user),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
