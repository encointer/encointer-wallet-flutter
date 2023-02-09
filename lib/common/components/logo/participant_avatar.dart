import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ParticipantAvatar extends StatelessWidget {
  const ParticipantAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.amber,
      child: SvgPicture.asset(
        'assets/avatars/bear.svg',
        // 'assets/nctr_logo.svg',
        // color: Colors.amber,
        // colorFilter: ColorFilter.mode(Colors.cyan, BlendMode.src),
      ),
    );
  }
}
