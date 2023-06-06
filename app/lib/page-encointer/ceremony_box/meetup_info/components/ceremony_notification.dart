import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/theme.dart';

class CeremonyNotification extends StatelessWidget {
  const CeremonyNotification({
    super.key,
    required this.notificationIconData,
    required this.notification,
  });

  final IconData notificationIconData;
  final String notification;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(notificationIconData, color: AppColors.encointerGrey, size: 18),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            notification,
            style: context.textTheme.headlineMedium!.copyWith(color: AppColors.encointerGrey),
          ),
        ),
      ],
    );
  }
}
