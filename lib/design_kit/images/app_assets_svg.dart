import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssetsSvg {
  AppAssetsSvg._();

  static Widget nctrMosaicBackground({
    double? width,
    double? height,
    Color? color,
    WidgetBuilder? placeholderBuilder,
    BoxFit fit = BoxFit.contain,
  }) {
    return _icon(
      'nctr_mosaic_background',
      width: width,
      height: height,
      color: color,
      placeholderBuilder: placeholderBuilder,
    );
  }

  static Widget nctrLogo({
    double? width,
    double? height,
    Color? color,
    WidgetBuilder? placeholderBuilder,
    BoxFit fit = BoxFit.contain,
  }) {
    return _icon(
      'nctr_logo',
      width: width,
      height: height,
      color: color,
      placeholderBuilder: placeholderBuilder,
    );
  }

  static Widget _icon(
    String name, {
    double? width,
    double? height,
    Color? color,
    WidgetBuilder? placeholderBuilder,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      'assets/$name.svg',
      width: width,
      height: height,
      color: color,
      placeholderBuilder: placeholderBuilder,
      fit: fit,
    );
  }
}
