import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';
import 'package:mobx/mobx.dart';

part 'chain.g.dart';

class ChainStore extends _ChainStore with _$ChainStore {
  ChainStore(super.store);
}

abstract class _ChainStore with Store {
  _ChainStore(this.rootStore);

  final AppStore rootStore;

  final String latestHeaderKey = 'chain_latest_header';

  @observable
  Header? latestHeader;

  @observable
  String? latestHashHex;

  @computed
  List<int>? get latestHash => latestHashHex?.replaceFirst('0x', '').codeUnits;

  @action
  void setLatestHeaderHash(String latestHash) {
    latestHashHex = latestHash;
  }

  @action
  void setLatestHeader(Header latest) {
    latestHeader = latest;
    rootStore.cacheObject(latestHeaderKey, latest);
  }

  @computed
  int? get latestHeaderNumber => latestHeader?.number;

  Future<void> loadCache() async {
    final h = await rootStore.loadObject(latestHeaderKey);
    if (h != null) {
      latestHeader = Header.fromJson(h as Map<String, dynamic>);
    }
  }
}
