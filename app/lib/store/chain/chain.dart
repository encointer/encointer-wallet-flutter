import 'package:mobx/mobx.dart';
import 'package:convert/convert.dart' show hex;


import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';
import 'package:ew_polkadart/ew_polkadart.dart';

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
  BlockHash? get latestHash {
    if (latestHashHex != null) return BlockHash.fromList(hex.decode(latestHashHex!.replaceFirst('0x', '')));

    return null;
  }

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
