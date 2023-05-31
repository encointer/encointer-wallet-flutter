// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnnouncementStore on _AnnouncementStoreBase, Store {
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
  Future<void> getCommunityAnnouncements(String? cid) {
    return _$getCommunityAnnouncementsAsyncAction.run(() => super.getCommunityAnnouncements(cid));
  }

  late final _$getGlobalAnnouncementsAsyncAction =
      AsyncAction('_AnnouncementStoreBase.getGlobalAnnouncements', context: context);

  @override
  Future<void> getGlobalAnnouncements() {
    return _$getGlobalAnnouncementsAsyncAction.run(() => super.getGlobalAnnouncements());
  }

  @override
  String toString() {
    return '''
error: ${error},
failureType: ${failureType},
fetchStatus: ${fetchStatus}
    ''';
  }
}
