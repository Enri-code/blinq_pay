import 'package:blinq_pay/core/utils/extensions/string.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatusWidget extends StatelessWidget {
  const UserStatusWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.w,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24.w,
            // backgroundColor: Theme.of(context).primaryColorLight,
            child: UserProfileWidget(radius: 23.w, user: user),
          ),
          4.verticalSpace,
          Text(
            user.name.firstName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key, this.radius, required this.user});

  final User user;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: NetworkImage(user.photo),
      backgroundColor: Theme.of(context).cardColor,
      child: Text(
        user.name.initials,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
