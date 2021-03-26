import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/mocks/data/mockEncointerData.dart';


abstract class PrepareStorage {
  static void setupStorageUnregisteredParticipant(AppStore store) {
    store.encointer.setParticipantIndex(0);
    store.encointer.setMeetupTime(claim['timestamp']);
  }
}