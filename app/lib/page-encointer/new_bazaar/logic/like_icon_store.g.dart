// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_icon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LikeIconStore on _LikeIconStoreBase, Store {
  late final _$isLikedAtom = Atom(name: '_LikeIconStoreBase.isLiked', context: context);

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

  late final _$isLikedPersonallyAtom = Atom(name: '_LikeIconStoreBase.isLikedPersonally', context: context);

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

  late final _$countLikesAtom = Atom(name: '_LikeIconStoreBase.countLikes', context: context);

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

  late final _$_LikeIconStoreBaseActionController = ActionController(name: '_LikeIconStoreBase', context: context);

  @override
  void toggleLikes() {
    final _$actionInfo = _$_LikeIconStoreBaseActionController.startAction(name: '_LikeIconStoreBase.toggleLikes');
    try {
      return super.toggleLikes();
    } finally {
      _$_LikeIconStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleOwnLikes() {
    final _$actionInfo = _$_LikeIconStoreBaseActionController.startAction(name: '_LikeIconStoreBase.toggleOwnLikes');
    try {
      return super.toggleOwnLikes();
    } finally {
      _$_LikeIconStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLiked: ${isLiked},
isLikedPersonally: ${isLikedPersonally},
countLikes: ${countLikes}
    ''';
  }
}
