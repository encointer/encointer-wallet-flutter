import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';

class CeremonyProgressBar extends StatelessWidget {
  final int progress;

  const CeremonyProgressBar({
    @required this.progress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: progress >= 1 ? GradientBar() : LightShadedBar(),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: progress >= 2 ? GradientBar() : LightShadedBar(),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: progress >= 3 ? GradientBar() : LightShadedBar(),
        ),
      ],
    );
  }
}

class LightShadedBar extends StatelessWidget {
  const LightShadedBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ZurichLion.shade50,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: SizedBox(
        height: 5,
      ),
    );
  }
}

class GradientBar extends StatelessWidget {
  const GradientBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        gradient: primaryGradient,
      ),
      child: SizedBox(
        height: 5,
      ),
    );
  }
}
