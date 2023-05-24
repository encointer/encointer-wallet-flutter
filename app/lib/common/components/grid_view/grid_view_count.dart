import 'package:flutter/material.dart';

class CustomGridViewCount extends StatelessWidget {
  const CustomGridViewCount({
    super.key,
    required this.children,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.childAspectRatio = 1,
  });

  final List<Widget> children;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      children: children,
    );
  }
}
