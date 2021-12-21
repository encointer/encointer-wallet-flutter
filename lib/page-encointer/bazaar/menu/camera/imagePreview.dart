import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/businessFormState.dart';

class ImagePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final businessFormState = Provider.of<BusinessFormState>(context);
    final imagePickerState = businessFormState.imagePickerState;

    return Observer(
      builder: (_) => ListView(
        children: [
          if (imagePickerState.retrieveDataError != null) Text(imagePickerState.retrieveDataError),
          if (imagePickerState.pickImageError != null)
            Text(
              'Pick image error: ${imagePickerState.pickImageError}',
              textAlign: TextAlign.center,
            ),
          if (imagePickerState.images.isEmpty)
            Text(
              'You have not picked an image, yet!',
              textAlign: TextAlign.center,
            ),
          Text("You added ${imagePickerState.images.length} images"),
          Column(
            children: imagePickerState.images
                .map(
                  (image) => Stack(
                    children: [
                      Container(
                        height: 200,
                        child: kIsWeb ? Image.network(image.path) : Image.file(File(image.path)),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => imagePickerState.removeImage(image),
                      )
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
