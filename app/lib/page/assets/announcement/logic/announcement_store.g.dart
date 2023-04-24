// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnnouncementStore on _AnnouncementStoreBase, Store {
  late final _$announcementsAtom = Atom(name: '_AnnouncementStoreBase.announcements', context: context);

  @override
  List<Announcement>? get announcements {
    _$announcementsAtom.reportRead();
    return super.announcements;
  }

  @override
  set announcements(List<Announcement>? value) {
    _$announcementsAtom.reportWrite(value, super.announcements, () {
      super.announcements = value;
    });
  }

  late final _$getAnnouncementAsyncAction = AsyncAction('_AnnouncementStoreBase.getAnnouncement', context: context);

  @override
  Future<void> getAnnouncement() {
    return _$getAnnouncementAsyncAction.run(() => super.getAnnouncement());
  }

  @override
  String toString() {
    return '''
announcements: ${announcements}
    ''';
  }
}
