// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_card_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnnouncementCardStore on _AnnouncementCardStoreBase, Store {
  late final _$isFavoriteAtom = Atom(name: '_AnnouncementCardStoreBase.isFavorite', context: context);

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  late final _$countFavoriteAtom = Atom(name: '_AnnouncementCardStoreBase.countFavorite', context: context);

  @override
  int get countFavorite {
    _$countFavoriteAtom.reportRead();
    return super.countFavorite;
  }

  @override
  set countFavorite(int value) {
    _$countFavoriteAtom.reportWrite(value, super.countFavorite, () {
      super.countFavorite = value;
    });
  }

  late final _$_AnnouncementCardStoreBaseActionController =
      ActionController(name: '_AnnouncementCardStoreBase', context: context);

  @override
  void toggleFavorite() {
    final _$actionInfo =
        _$_AnnouncementCardStoreBaseActionController.startAction(name: '_AnnouncementCardStoreBase.toggleFavorite');
    try {
      return super.toggleFavorite();
    } finally {
      _$_AnnouncementCardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFavorite: ${isFavorite},
countFavorite: ${countFavorite}
    ''';
  }
}
