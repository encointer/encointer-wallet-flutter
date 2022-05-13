import 'package:encointer_wallet/utils/UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class AddressIcon extends StatelessWidget {
  AddressIcon(
    this.address,
    this.pubKey, {
    this.size,
    this.tapToCopy = true,
    this.addressToCopy,
  });
  final String address;
  final String pubKey;
  final double size;
  final bool tapToCopy;
  final String addressToCopy;

  @override
  Widget build(BuildContext context) {
    String rawSvg = Jdenticon.toSvg(pubKey,
        colorSaturation: 0.78,
        grayscaleSaturation: 0.48,
        colorLightnessMinValue: 0.33,
        colorLightnessMaxValue: 0.66,
        grayscaleLightnessMinValue: 0.44,
        grayscaleLightnessMaxValue: 0.44,
        backColor: '#d4edf8ff',
        hues: [199]);
    return GestureDetector(
      child: Container(
        width: size ?? 96,
        height: size ?? 96,
        child: ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: SvgPicture.string(
              rawSvg,
              fit: BoxFit.fill,
              height: size ?? 96,
              width: size ?? 96,
            ),
          ),
        ),
      ),
      onTap: tapToCopy ? () => UI.copyAndNotify(context, addressToCopy ?? address) : null,
    );
  }
}
