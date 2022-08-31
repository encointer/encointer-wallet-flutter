import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';

class LowerCeremonyBoxContainer extends StatelessWidget {
  LowerCeremonyBoxContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(15)),
        color: ZurichLion.shade50,
      ),
      child: child,
    );
  }
}
