import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:blinq_pay/features/users/presentation/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTileWidget extends StatelessWidget {
  const UserTileWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserProfileWidget(user: user, radius: 20.r),
        8.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              '@${user.username}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
