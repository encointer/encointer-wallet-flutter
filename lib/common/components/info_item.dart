import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({super.key, required this.title, this.content, this.crossAxisAlignment});

  final String title;
  final String? content;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            content ?? '-',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          )
        ],
      ),
    );
  }
}
