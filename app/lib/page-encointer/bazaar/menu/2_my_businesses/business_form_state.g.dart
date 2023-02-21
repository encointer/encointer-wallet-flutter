// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_form_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BusinessFormState on _BusinessFormState, Store {
  late final _$nameAtom = Atom(name: '_BusinessFormState.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$descriptionAtom = Atom(name: '_BusinessFormState.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$streetAtom = Atom(name: '_BusinessFormState.street', context: context);

  @override
  String? get street {
    _$streetAtom.reportRead();
    return super.street;
  }

  @override
  set street(String? value) {
    _$streetAtom.reportWrite(value, super.street, () {
      super.street = value;
    });
  }

  late final _$streetAddendumAtom = Atom(name: '_BusinessFormState.streetAddendum', context: context);

  @override
  String? get streetAddendum {
    _$streetAddendumAtom.reportRead();
    return super.streetAddendum;
  }

  @override
  set streetAddendum(String? value) {
    _$streetAddendumAtom.reportWrite(value, super.streetAddendum, () {
      super.streetAddendum = value;
    });
  }

  late final _$zipCodeAtom = Atom(name: '_BusinessFormState.zipCode', context: context);

  @override
  String? get zipCode {
    _$zipCodeAtom.reportRead();
    return super.zipCode;
  }

  @override
  set zipCode(String? value) {
    _$zipCodeAtom.reportWrite(value, super.zipCode, () {
      super.zipCode = value;
    });
  }

  late final _$cityAtom = Atom(name: '_BusinessFormState.city', context: context);

  @override
  String? get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(String? value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  late final _$_BusinessFormStateActionController = ActionController(name: '_BusinessFormState', context: context);

  @override
  void validateName(String? value) {
    final _$actionInfo = _$_BusinessFormStateActionController.startAction(name: '_BusinessFormState.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$_BusinessFormStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateDescription(String? value) {
    final _$actionInfo =
        _$_BusinessFormStateActionController.startAction(name: '_BusinessFormState.validateDescription');
    try {
      return super.validateDescription(value);
    } finally {
      _$_BusinessFormStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateStreet(String? value) {
    final _$actionInfo = _$_BusinessFormStateActionController.startAction(name: '_BusinessFormState.validateStreet');
    try {
      return super.validateStreet(value);
    } finally {
      _$_BusinessFormStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateStreetAddendum(String? value) {
    final _$actionInfo =
        _$_BusinessFormStateActionController.startAction(name: '_BusinessFormState.validateStreetAddendum');
    try {
      return super.validateStreetAddendum(value);
    } finally {
      _$_BusinessFormStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateZipCode(String? value) {
    final _$actionInfo = _$_BusinessFormStateActionController.startAction(name: '_BusinessFormState.validateZipCode');
    try {
      return super.validateZipCode(value);
    } finally {
      _$_BusinessFormStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCity(String? value) {
    final _$actionInfo = _$_BusinessFormStateActionController.startAction(name: '_BusinessFormState.validateCity');
    try {
      return super.validateCity(value);
    } finally {
      _$_BusinessFormStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
description: ${description},
street: ${street},
streetAddendum: ${streetAddendum},
zipCode: ${zipCode},
city: ${city}
    ''';
  }
}

mixin _$BusinessFormErrorState on _BusinessFormErrorState, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors, name: '_BusinessFormErrorState.hasErrors')).value;

  late final _$nameAtom = Atom(name: '_BusinessFormErrorState.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$descriptionAtom = Atom(name: '_BusinessFormErrorState.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$streetAtom = Atom(name: '_BusinessFormErrorState.street', context: context);

  @override
  String? get street {
    _$streetAtom.reportRead();
    return super.street;
  }

  @override
  set street(String? value) {
    _$streetAtom.reportWrite(value, super.street, () {
      super.street = value;
    });
  }

  late final _$streetAddendumAtom = Atom(name: '_BusinessFormErrorState.streetAddendum', context: context);

  @override
  String? get streetAddendum {
    _$streetAddendumAtom.reportRead();
    return super.streetAddendum;
  }

  @override
  set streetAddendum(String? value) {
    _$streetAddendumAtom.reportWrite(value, super.streetAddendum, () {
      super.streetAddendum = value;
    });
  }

  late final _$zipCodeAtom = Atom(name: '_BusinessFormErrorState.zipCode', context: context);

  @override
  String? get zipCode {
    _$zipCodeAtom.reportRead();
    return super.zipCode;
  }

  @override
  set zipCode(String? value) {
    _$zipCodeAtom.reportWrite(value, super.zipCode, () {
      super.zipCode = value;
    });
  }

  late final _$cityAtom = Atom(name: '_BusinessFormErrorState.city', context: context);

  @override
  String? get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(String? value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
description: ${description},
street: ${street},
streetAddendum: ${streetAddendum},
zipCode: ${zipCode},
city: ${city},
hasErrors: ${hasErrors}
    ''';
  }
}
