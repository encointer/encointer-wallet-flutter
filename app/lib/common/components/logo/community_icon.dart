import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:encointer_wallet/theme/theme.dart';

class CommunityCircleAvatar extends StatelessWidget {
  const CommunityCircleAvatar(this.icon, {super.key, double? radius}) : radius = radius ?? 10;

  final SvgPicture icon;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorScheme.surface,
      radius: radius,
      child: icon,
    );
  }
}
