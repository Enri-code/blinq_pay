import 'package:blinq_pay/core/theme/app_theme.dart';
import 'package:blinq_pay/core/utils/extensions/string.dart';
import 'package:blinq_pay/features/users/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key, this.radius, required this.user});

  final User user;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 20.r,
      foregroundImage: NetworkImage(user.photo),
      backgroundColor: Theme.of(context).cardColor,
      onForegroundImageError: (exception, stackTrace) {},
      child: Text(
        user.name.initials,
        style: Theme.of(context).textTheme.bodyLarge?.sp.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
