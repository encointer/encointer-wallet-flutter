import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';

part 'contacts_page_store.g.dart';

const _targetLogger = 'ContactsPageStore';

// ignore: library_private_types_in_public_api
class ContactsPageStore = _ContactsPageStore with _$ContactsPageStore;

abstract class _ContactsPageStore with Store {
  _ContactsPageStore(this.appStore);

  @observable
  late AppStore appStore;

  @observable
  bool isLoading = true;

  @observable
  ObservableList<AccountData> contactList = ObservableList<AccountData>();

  @action
  Future<void> init() async {
    contactList = appStore.settings.contactList;
    await _getContactsReputation();
    await _getParticipantType();
    isLoading = false;
  }

  @action
  Future<void> _getContactsReputation() async {
    if (contactList.isNotEmpty) {
      await Future.forEach(contactList, (AccountData contact) async {
        final address = Fmt.ss58Encode(contact.pubKey, prefix: appStore.settings.endpoint.ss58!);
        final reputation = await webApi.encointer.getContactsReputation(address);
        Log.d('_getContactsReputation: reputation = $reputation', _targetLogger);

        contact.reputation = reputation;
        Log.d('_getContactsReputation: contact.reputation = ${contact.reputation}', _targetLogger);
      });
    }
  }

  @action
  Future<void> _getParticipantType() async {
    await Future.forEach(contactList, (AccountData contact) async {
      final data = await webApi.encointer.getAggregatedAccountData(
        appStore.encointer.chosenCid!,
        contact.pubKey,
      );
      Log.d('_getParticipantType: data = $data', _targetLogger);
      final registrationType = data.personal?.participantType;
      Log.d('_getParticipantType: registrationType = $registrationType', _targetLogger);
    });
  }
}
