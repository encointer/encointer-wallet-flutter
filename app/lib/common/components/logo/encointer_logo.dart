import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class EncointerLogo extends StatelessWidget {
  const EncointerLogo({super.key, this.height = 210, this.width = 210});

  final double width;
  final double height;

  static const nctrLogo = 'assets/nctr_logo.svg';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Assets.nctrLogo
            .svg(colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), width: width, height: height));
  }
}
