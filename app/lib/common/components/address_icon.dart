import 'package:encointer_wallet/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class AddressIcon extends StatelessWidget {
  const AddressIcon(
    this.address,
    this.pubKey, {
    super.key,
    this.size = 96,
    this.tapToCopy = true,
  });

  final String address;
  final String pubKey;
  final double size;
  final bool tapToCopy;

  @override
  Widget build(BuildContext context) {
    final rawSvg = Jdenticon.toSvg(pubKey,
        colorSaturation: 0.78,
        grayscaleSaturation: 0.48,
        colorLightnessMinValue: 0.33,
        colorLightnessMaxValue: 0.66,
        grayscaleLightnessMinValue: 0.44,
        grayscaleLightnessMaxValue: 0.44,
        backColor: '#d4edf8ff',
        hues: [199]);
    return GestureDetector(
      onTap: tapToCopy ? () => UI.copyAndNotify(context, address) : null,
      child: SizedBox(
        width: size,
        height: size,
        child: ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(48), // Image radius
            child: SvgPicture.string(
              rawSvg,
              fit: BoxFit.fill,
              height: size,
              width: size,
            ),
          ),
        ),
      ),
    );
  }
}
