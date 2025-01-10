import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/theme.dart';

/// handle for sliding up panel, for it look good
class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          key: const Key(EWTestKeys.dragHandlePanel),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(2)),
          ),
        ),
      ],
    );
  }
}
