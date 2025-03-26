// ignore_for_file: library_private_types_in_public_api

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStoreBase with _$ConnectivityStore;

abstract class _ConnectivityStoreBase with Store {
  _ConnectivityStoreBase(this.connectivity);

  final Connectivity connectivity;

  @observable
  List<ConnectivityResult> connectionState = [ConnectivityResult.none];

  @computed
  bool get isConnectedToNetwork => connectionState.any((cs) =>
      cs == ConnectivityResult.wifi ||
      cs == ConnectivityResult.mobile ||
      cs == ConnectivityResult.ethernet ||
      cs == ConnectivityResult.vpn);

  @action
  void listen() {
    connectivity.onConnectivityChanged.listen((event) {
      connectionState = event;
    });
  }
}
