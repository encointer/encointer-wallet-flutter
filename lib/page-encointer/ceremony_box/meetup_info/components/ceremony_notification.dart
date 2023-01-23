import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';

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
        Icon(notificationIconData, color: encointerGrey, size: 18),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            notification,
            style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey),
          ),
        ),
      ],
    );
  }
}
