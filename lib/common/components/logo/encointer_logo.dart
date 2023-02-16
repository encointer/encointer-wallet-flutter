import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EncointerLogo extends StatelessWidget {
  const EncointerLogo({super.key, this.height = 210, this.width = 210});

  final double width;
  final double height;

  static const nctrLogo = 'assets/nctr_logo.svg';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        nctrLogo,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: width,
        height: height,
      ),
    );
  }
}
