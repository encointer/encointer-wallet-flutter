// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnnouncementStore on _AnnouncementStoreBase, Store {
  late final _$announcementsGlobalAtom = Atom(name: '_AnnouncementStoreBase.announcementsGlobal', context: context);

  @override
  List<Announcement>? get announcementsGlobal {
    _$announcementsGlobalAtom.reportRead();
    return super.announcementsGlobal;
  }

  @override
  set announcementsGlobal(List<Announcement>? value) {
    _$announcementsGlobalAtom.reportWrite(value, super.announcementsGlobal, () {
      super.announcementsGlobal = value;
    });
  }

  late final _$announcementsCommunnityAtom =
      Atom(name: '_AnnouncementStoreBase.announcementsCommunnity', context: context);

  @override
  List<Announcement>? get announcementsCommunnity {
    _$announcementsCommunnityAtom.reportRead();
    return super.announcementsCommunnity;
  }

  @override
  set announcementsCommunnity(List<Announcement>? value) {
    _$announcementsCommunnityAtom.reportWrite(value, super.announcementsCommunnity, () {
      super.announcementsCommunnity = value;
    });
  }

  late final _$getAnnouncementCommunnityAsyncAction =
      AsyncAction('_AnnouncementStoreBase.getAnnouncementCommunnity', context: context);

  @override
  Future<void> getAnnouncementCommunnity(String? cid) {
    return _$getAnnouncementCommunnityAsyncAction.run(() => super.getAnnouncementCommunnity(cid));
  }

  late final _$getAnnouncementGlobalAsyncAction =
      AsyncAction('_AnnouncementStoreBase.getAnnouncementGlobal', context: context);

  @override
  Future<void> getAnnouncementGlobal() {
    return _$getAnnouncementGlobalAsyncAction.run(() => super.getAnnouncementGlobal());
  }

  @override
  String toString() {
    return '''
announcementsGlobal: ${announcementsGlobal},
announcementsCommunnity: ${announcementsCommunnity}
    ''';
  }
}
