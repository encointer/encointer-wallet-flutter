import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:encointer_wallet/common/stores/chain/types/header.dart';
import 'package:mobx/mobx.dart';

part 'chain_store.g.dart';

const _tag = 'chain_store';

class ChainStore extends _ChainStore with _$ChainStore {
  ChainStore();
}

abstract class _ChainStore with Store {
  _ChainStore() : rootStore = sl.get<AppStore>();

  final AppStore rootStore;

  final String latestHeaderKey = 'chain_latest_header';

  @observable
  Header? latestHeader;

  @action
  void setLatestHeader(Header latest) {
    Log.d('setLatestHeader', _tag);
    latestHeader = latest;
    rootStore.cacheObject(latestHeaderKey, latest);
  }

  @computed
  int? get latestHeaderNumber => latestHeader?.number;

  Future<void> loadCache() async {
    Log.d('loadCache', _tag);
    final h = await rootStore.loadObject(latestHeaderKey);
    if (h != null) {
      latestHeader = Header.fromJson(h as Map<String, dynamic>);
    }
  }
}
