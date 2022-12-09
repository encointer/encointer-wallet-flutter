import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/opening_hours_state.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/camera/image_picker_state.dart';
import 'package:mobx/mobx.dart';

part 'business_form_state.g.dart';

// ignore: library_private_types_in_public_api
class BusinessFormState = _BusinessFormState with _$BusinessFormState;

abstract class _BusinessFormState with Store {
  _BusinessFormState() {
    setupValidators();
  }

  // ************** OBSERVABLES ************************************************
  @observable
  String? name;

  @observable
  String? description;

  // // TODO how to model categories?

  @observable
  String? street;

  /// could be e.g. 7a not just a number hence use String
  @observable
  String? streetAddendum;

  @observable
  String? zipCode;

  @observable
  String? city;

  final openingHours = OpeningHoursState(
    OpeningHoursForDayState(ObservableList<OpeningIntervalState>()),
    OpeningHoursForDayState(ObservableList<OpeningIntervalState>()),
    OpeningHoursForDayState(ObservableList<OpeningIntervalState>()),
    OpeningHoursForDayState(ObservableList<OpeningIntervalState>()),
    OpeningHoursForDayState(ObservableList<OpeningIntervalState>()),
    OpeningHoursForDayState(ObservableList<OpeningIntervalState>()),
    OpeningHoursForDayState(ObservableList<OpeningIntervalState>()),
  );

  final errors = BusinessFormErrorState();
  final imagePickerState = ImagePickerState();

  // ************** REACTIONS **************************************************
  late List<ReactionDisposer> _disposers;

  void setupValidators() {
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => description, validateDescription),
      reaction((_) => street, validateStreet),
      reaction((_) => streetAddendum, validateStreetAddendum),
      reaction((_) => zipCode, validateZipCode),
      reaction((_) => city, validateCity),
    ];
  }

  // ************** ACTIONS ****************************************************
  @action
  void validateName(String? value) {
    return validateIsNotBlank(value, (errorText) => errors.name = errorText);
  }

  @action
  void validateDescription(String? value) {
    return validateIsNotBlank(value, (errorText) => errors.description = errorText);
  }

  @action
  void validateStreet(String? value) {
    return validateIsNotBlank(value, (errorText) => errors.street = errorText);
  }

  @action
  void validateStreetAddendum(String? value) {
    return validateIsNotBlank(value, (errorText) => errors.streetAddendum = errorText);
  }

  @action
  void validateZipCode(String? value) {
    return validateIsNotBlank(value, (errorText) => errors.zipCode = errorText);
  }

  @action
  void validateCity(String? value) {
    return validateIsNotBlank(value, (errorText) => errors.city = errorText);
  }

  // ************** OTHER METHODS **********************************************
  void validateIsNotBlank(String? value, void Function(String?) errorTarget) {
    final errorText = value == null || value.trim().isEmpty ? 'Cannot be blank' : null;
    errorTarget(errorText);
  }

  void dispose() {
    for (final disposer in _disposers) {
      disposer();
    }
  }

  /// if the user leaves everything blank the validators would not be triggered
  /// (only on change of the value),
  /// hence upon tapping submit this method should be called
  void validateAll() {
    validateName(name);
    validateDescription(description);
    validateStreet(street);
    validateStreetAddendum(streetAddendum);
    validateZipCode(zipCode);
    validateCity(city);
  }
}

/// error messages for input fields
// ignore: library_private_types_in_public_api
class BusinessFormErrorState = _BusinessFormErrorState with _$BusinessFormErrorState;

abstract class _BusinessFormErrorState with Store {
  @observable
  String? name;

  @observable
  String? description;

  @observable
  String? street;

  @observable
  String? streetAddendum;

  @observable
  String? zipCode;

  @observable
  String? city;

  // // TODO how to model categories?

  @computed
  bool get hasErrors => name != null; // || email != null || ...
}
