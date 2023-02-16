import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ParticipantAvatar extends StatelessWidget {
  const ParticipantAvatar({
    required this.index,
    this.isActive = false,
    super.key,
  });

  final int index;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: isActive ? Colors.green : Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          'assets/avatars/participant$index.svg',
          colorFilter: isActive ? const ColorFilter.srgbToLinearGamma() : const ColorFilter.linearToSrgbGamma(),
        ),
      ),
    );
  }
}

class MeetupAvatar extends StatelessWidget {
  const MeetupAvatar({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: CircleAvatar(
        radius: 27,
        backgroundColor: Colors.white,
        child: SvgPicture.asset(
          'assets/avatars/participant$index.svg',
          width: 40,
        ),
      ),
    );
  }
}
