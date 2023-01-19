import 'package:flutter/material.dart';
import 'package:translation/translation.dart';

class PhotoTiles extends StatelessWidget {
  const PhotoTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 150,
          width: 150,
          color: Colors.green,
        ),
        const SizedBox(width: 16),
        Container(
          height: 150,
          width: 150,
          color: Colors.grey,
          child: ListTile(
            leading: const Icon(Icons.add_a_photo),
            title: Text(context.dic.bazaar.photoAdd),
          ),
        ),
      ],
    );
  }
}
