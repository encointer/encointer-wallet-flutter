import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/material.dart';

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
        const SizedBox(
          width: 16,
        ),
        Container(
          height: 150,
          width: 150,
          color: Colors.grey,
          child: ListTile(
            leading: const Icon(Icons.add_a_photo),
            title: Text(context.l10n.photoAdd),
          ),
        ),
      ],
    );
  }
}
