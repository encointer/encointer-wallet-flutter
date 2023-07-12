import 'dart:io';

import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/business_form_state.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final businessFormState = Provider.of<BusinessFormState>(context);
    final imagePickerState = businessFormState.imagePickerState;

    return Observer(
      builder: (_) => ListView(
        children: [
          if (imagePickerState.retrieveDataError != null) Text(imagePickerState.retrieveDataError!),
          if (imagePickerState.pickImageError != null)
            Text(
              'Pick image error: ${imagePickerState.pickImageError}',
              textAlign: TextAlign.center,
            ),
          if (imagePickerState.images.isEmpty)
            Text(
              context.l10n.imageNotPicked,
              textAlign: TextAlign.center,
            ),
          Text('${imagePickerState.images.length} ${context.l10n.imagesAdded}'),
          Column(
            children: imagePickerState.images
                .map(
                  (image) => Stack(
                    children: [
                      SizedBox(
                        height: 200,
                        child: kIsWeb ? Image.network(image!.path) : Image.file(File(image!.path)),
                      ),
                      IconButton(
                        icon: const Icon(
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
