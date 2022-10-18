import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'image_picker_state.g.dart';

// ignore: library_private_types_in_public_api
class ImagePickerState = _ImagePickerState with _$ImagePickerState;

abstract class _ImagePickerState with Store {
  @observable
  ObservableList<XFile?> images = ObservableList<XFile?>();

  @observable
  String? pickImageError;

  @observable
  String? retrieveDataError;

  @action
  void addImage(XFile? image) {
    images.add(image);
  }

  @action
  void removeImage(XFile? toDelete) {
    images.remove(toDelete);
  }
}
