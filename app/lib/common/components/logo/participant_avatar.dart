import 'package:flutter/material.dart';

import 'package:encointer_wallet/gen/assets.gen.dart';

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
      radius: 20,
      backgroundColor: isActive ? Colors.green : Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Assets.avatars.values[index].svg(
          colorFilter: isActive ? const ColorFilter.srgbToLinearGamma() : const ColorFilter.linearToSrgbGamma(),
        ),
      ),
    );
  }
}

class UserMeetupAvatar extends StatelessWidget {
  const UserMeetupAvatar({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Assets.avatars.values[index].svg(width: 70),
    );
  }
}
