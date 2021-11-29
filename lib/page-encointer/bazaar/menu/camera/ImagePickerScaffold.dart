import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../0_main/BazaarMainState.dart';
import 'ImagePickerState.dart';
import 'ImagePreview.dart';

class ImagePickerScaffold extends StatelessWidget {
  final BazaarMainState bazaarMainState;
  final businessFormState;
  final ImagePicker _picker = ImagePicker();

  ImagePickerScaffold(this.bazaarMainState)
      : businessFormState = bazaarMainState.bazaarMyBusinessesState.businessFormState;

  @override
  Widget build(BuildContext context) {
    final imagePickerState = businessFormState.imagePickerState;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add/remove images"),
      ),
      body: Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(imagePickerState),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text(
                        'waiting...',
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return ImagePreview(bazaarMainState);
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image/video error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'You have not yet picked an image. 777',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              )
            : ImagePreview(bazaarMainState),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(
                  imagePickerState,
                  ImageSource.gallery,
                  context: context,
                );
              },
              heroTag: 'image1',
              tooltip: 'Pick Multiple Image from gallery',
              child: const Icon(Icons.photo_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(imagePickerState, ImageSource.camera, context: context);
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  void _onImageButtonPressed(ImagePickerState state, ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
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
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type != RetrieveType.video) {
        imagePickerState.addImage(response.file);
      }
    } else {
      imagePickerState.retrieveDataError = response.exception.code;
    }
  }
}
