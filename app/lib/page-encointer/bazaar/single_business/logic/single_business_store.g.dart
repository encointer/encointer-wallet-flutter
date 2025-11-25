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

  bool _isLikedIsInitialized = false;

  @override
  set isLiked(bool value) {
    _$isLikedAtom.reportWrite(value, _isLikedIsInitialized ? super.isLiked : null, () {
      super.isLiked = value;
      _isLikedIsInitialized = true;
    });
  }

  late final _$isLikedPersonallyAtom = Atom(name: '_SingleBusinessStoreBase.isLikedPersonally', context: context);

  @override
  bool get isLikedPersonally {
    _$isLikedPersonallyAtom.reportRead();
    return super.isLikedPersonally;
  }

  bool _isLikedPersonallyIsInitialized = false;

  @override
  set isLikedPersonally(bool value) {
    _$isLikedPersonallyAtom.reportWrite(value, _isLikedPersonallyIsInitialized ? super.isLikedPersonally : null, () {
      super.isLikedPersonally = value;
      _isLikedPersonallyIsInitialized = true;
    });
  }

  late final _$countLikesAtom = Atom(name: '_SingleBusinessStoreBase.countLikes', context: context);

  @override
  int get countLikes {
    _$countLikesAtom.reportRead();
    return super.countLikes;
  }

  bool _countLikesIsInitialized = false;

  @override
  set countLikes(int value) {
    _$countLikesAtom.reportWrite(value, _countLikesIsInitialized ? super.countLikes : null, () {
      super.countLikes = value;
      _countLikesIsInitialized = true;
    });
  }

  late final _$ipfsProductsAtom = Atom(name: '_SingleBusinessStoreBase.ipfsProducts', context: context);

  @override
  List<IpfsProduct> get ipfsProducts {
    _$ipfsProductsAtom.reportRead();
    return super.ipfsProducts;
  }

  @override
  set ipfsProducts(List<IpfsProduct> value) {
    _$ipfsProductsAtom.reportWrite(value, super.ipfsProducts, () {
      super.ipfsProducts = value;
    });
  }

  late final _$errorAtom = Atom(name: '_SingleBusinessStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
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
ipfsProducts: ${ipfsProducts},
error: ${error}
    ''';
  }
}
