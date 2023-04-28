import 'dart:convert';

import 'package:encointer_wallet/config/prod_community.dart';
import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

part 'announcement_store.g.dart';

// ignore: library_private_types_in_public_api
class AnnouncementStore = _AnnouncementStoreBase with _$AnnouncementStore;

abstract class _AnnouncementStoreBase with Store {
  @observable
  List<Announcement>? announcementsGlobal;
  @observable
  List<Announcement>? announcementsCommunnity;

  @action
  Future<void> getAnnouncementCommunnity(String? cid) async {
    final community = Community.fromCid(cid);
    final uri = Uri.parse('https://eldar2021.github.io/encointer/announcements/${community.name}/announcements.json');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      announcementsCommunnity = data.map((e) => Announcement.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch announcements');
    }
  }

  @action
  Future<void> getAnnouncementGlobal() async {
    final uri = Uri.parse('https://eldar2021.github.io/encointer/announcements/global/announcements.json');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      announcementsGlobal = data.map((e) => Announcement.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch announcements');
    }
  }
}
