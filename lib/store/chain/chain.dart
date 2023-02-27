import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';
import 'package:mobx/mobx.dart';

part 'chain.g.dart';

const _tag = 'chain_store';

class ChainStore extends _ChainStore with _$ChainStore {}

abstract class _ChainStore with Store {
  _ChainStore() : rootStore = sl<AppStore>();

  final AppStore rootStore;

  final String latestHeaderKey = 'chain_latest_header';

  @observable
  Header? latestHeader;

  @action
  void setLatestHeader(Header latest) {
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
