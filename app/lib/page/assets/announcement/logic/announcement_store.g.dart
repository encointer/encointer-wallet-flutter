// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnnouncementStore on _AnnouncementStoreBase, Store {
  late final _$announcementsGlobalAtom = Atom(name: '_AnnouncementStoreBase.announcementsGlobal', context: context);

  @override
  List<Announcement> get announcementsGlobal {
    _$announcementsGlobalAtom.reportRead();
    return super.announcementsGlobal;
  }

  @override
  set announcementsGlobal(List<Announcement> value) {
    _$announcementsGlobalAtom.reportWrite(value, super.announcementsGlobal, () {
      super.announcementsGlobal = value;
    });
  }

  late final _$announcementsCommunnityAtom =
      Atom(name: '_AnnouncementStoreBase.announcementsCommunnity', context: context);

  @override
  List<Announcement> get announcementsCommunnity {
    _$announcementsCommunnityAtom.reportRead();
    return super.announcementsCommunnity;
  }

  @override
  set announcementsCommunnity(List<Announcement> value) {
    _$announcementsCommunnityAtom.reportWrite(value, super.announcementsCommunnity, () {
      super.announcementsCommunnity = value;
    });
  }

  late final _$announcementsAtom = Atom(name: '_AnnouncementStoreBase.announcements', context: context);

  @override
  List<Announcement> get announcements {
    _$announcementsAtom.reportRead();
    return super.announcements;
  }

  @override
  set announcements(List<Announcement> value) {
    _$announcementsAtom.reportWrite(value, super.announcements, () {
      super.announcements = value;
    });
  }

  late final _$errorAtom = Atom(name: '_AnnouncementStoreBase.error', context: context);

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

  late final _$failureTypeAtom = Atom(name: '_AnnouncementStoreBase.failureType', context: context);

  @override
  FailureType? get failureType {
    _$failureTypeAtom.reportRead();
    return super.failureType;
  }

  @override
  set failureType(FailureType? value) {
    _$failureTypeAtom.reportWrite(value, super.failureType, () {
      super.failureType = value;
    });
  }

  late final _$fetchStatusAtom = Atom(name: '_AnnouncementStoreBase.fetchStatus', context: context);

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

  late final _$getCommunityAnnouncementsAsyncAction =
      AsyncAction('_AnnouncementStoreBase.getCommunityAnnouncements', context: context);

  @override
  Future<void> getCommunityAnnouncements(String? cid, {bool devMode = false, required String langCode}) {
    return _$getCommunityAnnouncementsAsyncAction
        .run(() => super.getCommunityAnnouncements(cid, devMode: devMode, langCode: langCode));
  }

  late final _$getGlobalAnnouncementsAsyncAction =
      AsyncAction('_AnnouncementStoreBase.getGlobalAnnouncements', context: context);

  @override
  Future<void> getGlobalAnnouncements({bool devMode = false}) {
    return _$getGlobalAnnouncementsAsyncAction.run(() => super.getGlobalAnnouncements(devMode: devMode));
  }

  @override
  String toString() {
    return '''
announcementsGlobal: ${announcementsGlobal},
announcementsCommunnity: ${announcementsCommunnity},
announcements: ${announcements},
error: ${error},
failureType: ${failureType},
fetchStatus: ${fetchStatus}
    ''';
  }
}
