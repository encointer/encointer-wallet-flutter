import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'image_picker_state.g.dart';

class ImagePickerState = _ImagePickerState with _$ImagePickerState;

abstract class _ImagePickerState with Store {
  @observable
  ObservableList<PickedFile?> images = ObservableList<PickedFile?>();

  @observable
  String? pickImageError;

  @observable
  String? retrieveDataError;

  @action
  void addImage(PickedFile? image) {
    images.add(image);
  }

  @action
  void removeImage(PickedFile? toDelete) {
    images.remove(toDelete);
  }
}
