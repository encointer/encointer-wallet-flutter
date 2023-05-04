import 'package:encointer_wallet/config/prod_community.dart';
import 'package:encointer_wallet/data/common_services/models/network/api_response.dart';
import 'package:encointer_wallet/data/common_services/network/api_services.dart';
import 'package:encointer_wallet/data/remote/announcements/announcements_api_services.dart';

class AnnouncementsApi implements AnnouncementsApiServices {
  late final ApiServices _apiServices;
  AnnouncementsApi({required ApiServices apiServices}) : _apiServices = apiServices;

  @override
  Future<ApiResponse> getAnnouncementCommunnity({String? cid}) async {
    final community = Community.fromCid(cid);
    return _apiServices.get(endpoint: '${community.name}/announcements.json');
  }

  @override
  Future<ApiResponse> getAnnouncementGlobal() async {
    return _apiServices.get(endpoint: 'global/announcements.json');
  }
}
