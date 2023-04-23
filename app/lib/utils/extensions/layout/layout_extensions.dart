import 'package:flutter/material.dart';

extension LayoutExtention on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.width > 730;
  bool get isDesktop => MediaQuery.of(this).size.width > 1200;
  bool get isMobile => !isTablet && !isDesktop;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
