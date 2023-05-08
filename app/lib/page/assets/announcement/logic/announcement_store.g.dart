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

  late final _$loadingAtom = Atom(name: '_AnnouncementStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$getLeuAnnouncementsAsyncAction =
      AsyncAction('_AnnouncementStoreBase.getLeuAnnouncements', context: context);

  @override
  Future<void> getLeuAnnouncements(String? cid) {
    return _$getLeuAnnouncementsAsyncAction.run(() => super.getLeuAnnouncements(cid));
  }

  late final _$getGlobalAnnouncementsAsyncAction =
      AsyncAction('_AnnouncementStoreBase.getGlobalAnnouncements', context: context);

  @override
  Future<void> getGlobalAnnouncements() {
    return _$getGlobalAnnouncementsAsyncAction.run(() => super.getGlobalAnnouncements());
  }

  late final _$_AnnouncementStoreBaseActionController =
      ActionController(name: '_AnnouncementStoreBase', context: context);

  @override
  void _init() {
    final _$actionInfo = _$_AnnouncementStoreBaseActionController.startAction(name: '_AnnouncementStoreBase._init');
    try {
      return super._init();
    } finally {
      _$_AnnouncementStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAnnouncementsEmpty() {
    final _$actionInfo =
        _$_AnnouncementStoreBaseActionController.startAction(name: '_AnnouncementStoreBase.setAnnouncementsEmpty');
    try {
      return super.setAnnouncementsEmpty();
    } finally {
      _$_AnnouncementStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo =
        _$_AnnouncementStoreBaseActionController.startAction(name: '_AnnouncementStoreBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$_AnnouncementStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
announcementsGlobal: ${announcementsGlobal},
announcementsCommunnity: ${announcementsCommunnity},
error: ${error},
failureType: ${failureType},
loading: ${loading}
    ''';
  }
}
