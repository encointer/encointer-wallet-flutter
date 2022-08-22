import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/ui.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class AddressIcon extends StatelessWidget {
  AddressIcon(
    this.address,
    this.pubKey, {
    this.size = 96,
    this.tapToCopy = true,
  });
  final String address;
  final String pubKey;
  final double size;
  final bool tapToCopy;

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
      child: SizedBox(
        width: size,
        height: size,
        child: ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(48), // Image radius
            child: SvgPicture.string(
              rawSvg,
              fit: BoxFit.fill,
              height: size,
              width: size,
            ),
          ),
        ),
      ),
      onTap: tapToCopy ? () => UI.copyAndNotify(context, address) : null,
    );
  }
}

class AddressIconWithLabel extends StatelessWidget {
  AddressIconWithLabel(
    this.address,
    this.pubKey, {
    this.size = 96,
    this.tapToCopy = true,
    this.labelStyle,
  });

  final String address;
  final String pubKey;
  final double size;
  final bool tapToCopy;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final style = labelStyle ?? Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey, height: 1.5);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AddressIcon(
          address,
          pubKey,
          size: size,
        ),
        Text(
          Fmt.address(address)!,
          style: style,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
