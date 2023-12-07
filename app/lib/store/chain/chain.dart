import 'dart:typed_data';

import 'package:convert/convert.dart' show hex;
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';

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

  /// Computed value ready to be served into polkadart's methods.
  ///
  /// Example:
  /// ```dart
  /// await encointerKusama.query.encointerScheduler
  ///   .currentPhase(at: at ?? store.chain.latestHash);
  /// ```
  /// The above will:
  /// 1. Use the provided `at` argument if not null.
  /// 2. Use the `store.chain.latestHash`.
  /// 3. If `store.chain.latestHash` is null, it will return the value corresponding
  /// to the latest finalized head.
  ///
  /// Note: we can't use the type alias `BlockHash` here due to a mobx bug:
  /// https://github.com/mobxjs/mobx.dart/issues/968
  @computed
  Uint8List? get latestHash {
    if (latestHashHex != null) {
      return Uint8List.fromList(hex.decode(latestHashHex!.replaceFirst('0x', '')));
    } else {
      return null;
    }
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
