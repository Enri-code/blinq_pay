import 'package:blinq_pay/core/theme/app_theme.dart';
import 'package:blinq_pay/core/utils/extensions/string.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatusWidget extends StatelessWidget {
  const UserStatusWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54.w,
      child: Column(
        children: [
          CircleAvatar(
            radius: 26.h,
            child: UserProfileWidget(radius: 25.h, user: user),
          ),
          4.verticalSpace,
          Text(
            user.name.firstName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.sp,
          ),
        ],
      ),
    );
  }
}
