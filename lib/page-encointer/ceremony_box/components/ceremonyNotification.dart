import 'package:flutter/material.dart';
import 'package:encointer_wallet/common/theme.dart';

class CeremonyNotification extends StatelessWidget {
  const CeremonyNotification({
    Key key,
    @required this.notificationIconData,
    @required this.notification,
  }) : super(key: key);

  final IconData notificationIconData;
  final String notification;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(notificationIconData, color: encointerGrey, size: 18),
        SizedBox(width: 12),
        Flexible(
          child: Text(
            notification,
            style: Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey),
          ),
        ),
      ],
    );
  }
}
