import 'package:flutter/material.dart';
import 'package:encointer_wallet/common/components/logo/community_icon.dart';

class PublisherSVGandCommunityIcon extends StatelessWidget {
  const PublisherSVGandCommunityIcon(this.publisherSVG, {super.key});

  final String publisherSVG;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(publisherSVG),
      child: const Align(
        alignment: Alignment.bottomRight,
        child: CommunityIconObserver(radius: 8),
      ),
    );
  }
}
