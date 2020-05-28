import 'package:mobx/mobx.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/store/encointer/types/encointerTypes.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/assets/types/transferData.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/localStorage.dart';

part 'encointer.g.dart';

class EncointerStore extends _EncointerStore with _$EncointerStore {
  EncointerStore(AppStore store) : super(store);
}

abstract class _EncointerStore with Store {
  _EncointerStore(this.rootStore);

  final AppStore rootStore;
  final String cacheTxsTransferKey = 'transfer_txs';

  @observable
  CeremonyPhase currentPhase = CeremonyPhase.REGISTERING;

  @observable
  ObservableList<TransferData> txsTransfer = ObservableList<TransferData>();

  @action
  void setCurrentPhase(CeremonyPhase phase) {
    currentPhase = phase;
  }

  @action
  Future<void> setTransferTxs(List list,
      {bool reset = false, needCache = true}) async {
    List transfers = list.map((i) {
      return {
        "block_timestamp": i['time'],
        "hash": i['hash'],
        "success": true,
        "from": rootStore.account.currentAddress,
        "to": i['params'][0],
        "token": i['params'][1],
        "amount": Fmt.balance(i['params'][2], decimals: encointer_token_decimals),
      };
    }).toList();
    if (reset) {
      txsTransfer = ObservableList.of(transfers
          .map((i) => TransferData.fromJson(Map<String, dynamic>.from(i))));
    } else {
      txsTransfer.addAll(transfers
          .map((i) => TransferData.fromJson(Map<String, dynamic>.from(i))));
    }

    if (needCache && txsTransfer.length > 0) {
      _cacheTxs(transfers, cacheTxsTransferKey);
    }
  }

  @action
  Future<void> _cacheTxs(List list, String cacheKey) async {
    String pubKey = rootStore.account.currentAccount.pubKey;
    List cached = await LocalStorage.getAccountCache(pubKey, cacheKey);
    if (cached != null) {
      cached.addAll(list);
    } else {
      cached = list;
    }
    LocalStorage.setAccountCache(pubKey, cacheKey, cached);
  }


  @action
  Future<void> loadCache() async {
  }

}
