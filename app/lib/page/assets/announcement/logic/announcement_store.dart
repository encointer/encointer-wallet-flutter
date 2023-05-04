import 'package:encointer_wallet/data/common_services/models/network/api_response.dart';
import 'package:encointer_wallet/data/common_services/network/api_services.dart';
import 'package:encointer_wallet/data/remote/announcements/announcements_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import 'package:encointer_wallet/models/announcement/announcement.dart';

part 'announcement_store.g.dart';

const _logTarget = 'announcement_store';

class AnnouncementConsts {
  static const baseUrl = 'https://eldar2021.github.io/encointer/announcements/';
}

// ignore: library_private_types_in_public_api
class AnnouncementStore = _AnnouncementStoreBase with _$AnnouncementStore;

abstract class _AnnouncementStoreBase with Store {
  late final AnnouncementsApi _announcementsApi;

  @observable
  List<Announcement>? announcementsGlobal;

  @observable
  List<Announcement>? announcementsCommunnity;

  @observable
  String? error;

  @action
  void init() {
    Log.d('init', _logTarget);

    _announcementsApi = AnnouncementsApi(
      apiServices: ApiServices(
        baseUrl: AnnouncementConsts.baseUrl,
        client: http.Client(),
      ),
    );
  }

  @action
  Future<void> getAnnouncementCommunnity(String? cid) async {
    Log.d('getAnnouncementCommunnity: cid = $cid', _logTarget);
    final response = await _announcementsApi.getAnnouncementCommunnity(cid: cid);

    if (response is Success) {
      final data = response.data as List;
      announcementsCommunnity = data.map((e) => Announcement.fromJson(e as Map<String, dynamic>)).toList();
    } else if (response is Failure) {
      error = response.error;
    } else {
      error = 'Something went wrong, please try again!';
    }
  }

  @action
  Future<void> getAnnouncementGlobal() async {
    Log.d('getAnnouncementGlobal', _logTarget);
    final response = await _announcementsApi.getAnnouncementGlobal();

    if (response is Success) {
      final data = response.data as List;
      announcementsGlobal = data.map((e) => Announcement.fromJson(e as Map<String, dynamic>)).toList();
    } else if (response is Failure) {
      error = response.error;
    } else {
      error = 'Something went wrong, please try again!';
    }
  }
}
