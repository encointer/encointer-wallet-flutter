import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/business_form_state.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/camera/image_picker_state.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/camera/image_preview.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

class ImagePickerScaffold extends StatelessWidget {
  ImagePickerScaffold({super.key});

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final businessFormState = Provider.of<BusinessFormState>(context);
    final imagePickerState = businessFormState.imagePickerState;

    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context)!.translationsForLocale().bazaar.imagesAddRemove),
      ),
      body: Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(imagePickerState),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Text(
                        I18n.of(context)!.translationsForLocale().bazaar.waiting,
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return const ImagePreview();
                    //Here I'll need your help
                    case ConnectionState.active:
                      return Text(
                        I18n.of(context)!.translationsForLocale().bazaar.imageNotPicked,
                        textAlign: TextAlign.center,
                      );
                  }
                },
              )
            : const ImagePreview(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(
                  imagePickerState,
                  ImageSource.gallery,
                  context: context,
                );
              },
              heroTag: 'image1',
              tooltip: I18n.of(context)!.translationsForLocale().bazaar.imagesMultiplePick,
              child: const Icon(Icons.photo_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(imagePickerState, ImageSource.camera, context: context);
              },
              heroTag: 'image2',
              tooltip: I18n.of(context)!.translationsForLocale().bazaar.photoTake,
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onImageButtonPressed(ImagePickerState state, ImageSource source, {BuildContext? context}) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        // maxWidth: maxWidth,
        // maxHeight: maxHeight,
        // imageQuality: quality,
      );
      state.addImage(pickedFile);
    } catch (e) {
      state.pickImageError = e.toString();
    }
  }

  Future<void> retrieveLostData(ImagePickerState imagePickerState) async {
    final response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type != RetrieveType.video) {
        imagePickerState.addImage(response.file);
      }
    } else {
      imagePickerState.retrieveDataError = response.exception!.code;
    }
  }
}
