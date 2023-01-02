import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';

/// handle for sliding up panel, for it look good
class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          key: const Key('drag-handle-panel'),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: zurichLion.shade50,
            borderRadius: const BorderRadius.all(Radius.circular(2)),
          ),
        ),
      ],
    );
  }
}
