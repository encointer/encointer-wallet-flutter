// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_picker_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImagePickerState on _ImagePickerState, Store {
  late final _$imagesAtom = Atom(name: '_ImagePickerState.images', context: context);

  @override
  ObservableList<XFile?> get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(ObservableList<XFile?> value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  late final _$pickImageErrorAtom = Atom(name: '_ImagePickerState.pickImageError', context: context);

  @override
  String? get pickImageError {
    _$pickImageErrorAtom.reportRead();
    return super.pickImageError;
  }

  @override
  set pickImageError(String? value) {
    _$pickImageErrorAtom.reportWrite(value, super.pickImageError, () {
      super.pickImageError = value;
    });
  }

  late final _$retrieveDataErrorAtom = Atom(name: '_ImagePickerState.retrieveDataError', context: context);

  @override
  String? get retrieveDataError {
    _$retrieveDataErrorAtom.reportRead();
    return super.retrieveDataError;
  }

  @override
  set retrieveDataError(String? value) {
    _$retrieveDataErrorAtom.reportWrite(value, super.retrieveDataError, () {
      super.retrieveDataError = value;
    });
  }

  late final _$_ImagePickerStateActionController = ActionController(name: '_ImagePickerState', context: context);

  @override
  void addImage(XFile? image) {
    final _$actionInfo = _$_ImagePickerStateActionController.startAction(name: '_ImagePickerState.addImage');
    try {
      return super.addImage(image);
    } finally {
      _$_ImagePickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeImage(XFile? toDelete) {
    final _$actionInfo = _$_ImagePickerStateActionController.startAction(name: '_ImagePickerState.removeImage');
    try {
      return super.removeImage(toDelete);
    } finally {
      _$_ImagePickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
images: ${images},
pickImageError: ${pickImageError},
retrieveDataError: ${retrieveDataError}
    ''';
  }
}
