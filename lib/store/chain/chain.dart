import 'package:encointer_wallet/store/app.dart';
import 'package:mobx/mobx.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';


part 'chain.g.dart';

class ChainStore extends _ChainStore with _$ChainStore {
  ChainStore(AppStore store) : super(store);
}

abstract class _ChainStore with Store {
  _ChainStore(this.rootStore);

  final AppStore rootStore;

  @observable
  Header latestHead;

  void setLatestHead(Header latest) {
    latestHead = latest;
  }
}