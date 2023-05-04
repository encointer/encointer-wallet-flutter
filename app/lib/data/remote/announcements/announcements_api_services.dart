import 'package:encointer_wallet/data/common_services/models/network/api_response.dart';

abstract class AnnouncementsApiServices {
  Future<ApiResponse> getAnnouncementCommunnity({String? cid});
  Future<ApiResponse> getAnnouncementGlobal();
}
