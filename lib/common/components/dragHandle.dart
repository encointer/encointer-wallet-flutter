import 'package:flutter/material.dart';
import '../theme.dart';

/// handle for sliding up panel, for it look good
class DragHandle extends StatelessWidget {
  const DragHandle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(color: ZurichLion.shade50, borderRadius: BorderRadius.all(Radius.circular(2))),
        ),
      ],
    );
  }
}
