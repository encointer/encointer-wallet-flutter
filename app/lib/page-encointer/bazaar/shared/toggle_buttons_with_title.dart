import 'package:flutter/material.dart';

class ToggleButtonsWithTitle extends StatelessWidget {
  ToggleButtonsWithTitle(
    this.title,
    this.items,
    this.onPressed, {
    super.key,
  }) : isSelected = List.filled(items.length, false);

  final List<String> items;
  final List<bool> isSelected;
  final void Function(int)? onPressed;
  final String title;
  final allSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 60,
        child: ListView(scrollDirection: Axis.horizontal, children: [
          ToggleButtons(
            onPressed: (int index) => onPressed!(index),
            isSelected: isSelected,
            children: items
                .map(
                  (cat) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Text(cat),
                  ),
                )
                .toList(),
          ),
        ]),
      ),
    ]);
  }
}
