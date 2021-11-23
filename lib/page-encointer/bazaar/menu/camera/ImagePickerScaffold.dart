import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../2_my_businesses/BusinessFormState.dart';

import 'ImagePickerState.dart';

class ImagePickerScaffold extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final businessFormState = Provider.of<BusinessFormState>(context);
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
                      return ImagePreview();
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
            : ImagePreview(),
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
      final pickedFiles = await _picker.getImage(
        source: source,
        // maxWidth: maxWidth,
        // maxHeight: maxHeight,
        // imageQuality: quality,
      );
      state.addImage(pickedFiles);
    } catch (e) {
      state.pickImageError = e;
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
                  .map((image) => Stack(
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
                      ))
                  .toList()),
        ],
      ),
    );
  }
}
