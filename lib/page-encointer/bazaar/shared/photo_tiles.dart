import 'package:flutter/material.dart';

import 'package:encointer_wallet/utils/translations/index.dart';

class PhotoTiles extends StatelessWidget {
  const PhotoTiles({
    Key? key,
  }) : super(key: key);

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
            title: Text(I18n.of(context)!.translationsForLocale().bazaar.photoAdd),
          ),
        ),
      ],
    );
  }
}
