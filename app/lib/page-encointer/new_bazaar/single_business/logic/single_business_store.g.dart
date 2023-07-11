// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_business_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SingleBusinessStore on _SingleBusinessStoreBase, Store {
  late final _$isLikedAtom = Atom(name: '_SingleBusinessStoreBase.isLiked', context: context);

  @override
  bool get isLiked {
    _$isLikedAtom.reportRead();
    return super.isLiked;
  }

  @override
  set isLiked(bool value) {
    _$isLikedAtom.reportWrite(value, super.isLiked, () {
      super.isLiked = value;
    });
  }

  late final _$isLikedPersonallyAtom = Atom(name: '_SingleBusinessStoreBase.isLikedPersonally', context: context);

  @override
  bool get isLikedPersonally {
    _$isLikedPersonallyAtom.reportRead();
    return super.isLikedPersonally;
  }

  @override
  set isLikedPersonally(bool value) {
    _$isLikedPersonallyAtom.reportWrite(value, super.isLikedPersonally, () {
      super.isLikedPersonally = value;
    });
  }

  late final _$countLikesAtom = Atom(name: '_SingleBusinessStoreBase.countLikes', context: context);

  @override
  int get countLikes {
    _$countLikesAtom.reportRead();
    return super.countLikes;
  }

  @override
  set countLikes(int value) {
    _$countLikesAtom.reportWrite(value, super.countLikes, () {
      super.countLikes = value;
    });
  }

  late final _$singleBusinessAtom = Atom(name: '_SingleBusinessStoreBase.singleBusiness', context: context);

  @override
  SingleBusiness? get singleBusiness {
    _$singleBusinessAtom.reportRead();
    return super.singleBusiness;
  }

  @override
  set singleBusiness(SingleBusiness? value) {
    _$singleBusinessAtom.reportWrite(value, super.singleBusiness, () {
      super.singleBusiness = value;
    });
  }

  late final _$fetchStatusAtom = Atom(name: '_SingleBusinessStoreBase.fetchStatus', context: context);

  @override
  FetchStatus get fetchStatus {
    _$fetchStatusAtom.reportRead();
    return super.fetchStatus;
  }

  @override
  set fetchStatus(FetchStatus value) {
    _$fetchStatusAtom.reportWrite(value, super.fetchStatus, () {
      super.fetchStatus = value;
    });
  }

  late final _$getSingleBusinessAsyncAction =
      AsyncAction('_SingleBusinessStoreBase.getSingleBusiness', context: context);

  @override
  Future<void> getSingleBusiness() {
    return _$getSingleBusinessAsyncAction.run(() => super.getSingleBusiness());
  }

  late final _$_SingleBusinessStoreBaseActionController =
      ActionController(name: '_SingleBusinessStoreBase', context: context);

  @override
  void toggleLikes() {
    final _$actionInfo =
        _$_SingleBusinessStoreBaseActionController.startAction(name: '_SingleBusinessStoreBase.toggleLikes');
    try {
      return super.toggleLikes();
    } finally {
      _$_SingleBusinessStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleOwnLikes() {
    final _$actionInfo =
        _$_SingleBusinessStoreBaseActionController.startAction(name: '_SingleBusinessStoreBase.toggleOwnLikes');
    try {
      return super.toggleOwnLikes();
    } finally {
      _$_SingleBusinessStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLiked: ${isLiked},
isLikedPersonally: ${isLikedPersonally},
countLikes: ${countLikes},
singleBusiness: ${singleBusiness},
fetchStatus: ${fetchStatus}
    ''';
  }
}
