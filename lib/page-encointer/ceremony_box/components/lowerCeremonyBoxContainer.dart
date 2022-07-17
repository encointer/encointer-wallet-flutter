import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';

class LowerCeremonyBoxContainer extends StatelessWidget {
  LowerCeremonyBoxContainer({
    this.child,
    Key? key,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(15)),
        color: ZurichLion.shade50,
      ),
      child: this.child,
    );
  }
}
