import 'package:flutter/material.dart';

class PublisherSVGandCommunityIcon extends StatelessWidget {
  const PublisherSVGandCommunityIcon({
    required this.child,
    required this.publisherSVG,
    super.key,
  });

  final String publisherSVG;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(publisherSVG),
      child: Align(alignment: Alignment.bottomRight, child: child),
    );
  }
}
