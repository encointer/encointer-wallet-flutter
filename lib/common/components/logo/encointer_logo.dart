import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EncointerLogo extends StatelessWidget {
  const EncointerLogo({super.key});

  static const nctrLogo = 'assets/nctr_logo.svg';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        nctrLogo,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 210,
        height: 210,
      ),
    );
  }
}
