import 'package:flutter/material.dart';

class CustomGridViewCount extends StatelessWidget {
  const CustomGridViewCount({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      children: children,
    );
  }
}
