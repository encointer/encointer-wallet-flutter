import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'dataUpdate.g.dart';

/// Store that fires when a certain time has expired since an update.
///
///
class DataUpdateStore extends _DataUpdateStore with _$DataUpdateStore {
  DataUpdateStore({
    refreshPeriod = const Duration(seconds: 30),
  }) : super(refreshPeriod);
}

abstract class _DataUpdateStore with Store {
  _DataUpdateStore(this.refreshPeriod);

  /// The update function to be executed when the state expired.
  Future<void> Function()? updateFn;

  // Not sure yet, if we need to dispose this one.
  ReactionDisposer? _disposer;

  final Duration refreshPeriod;

  @observable
  DateTime lastUpdate = DateTime.fromMicrosecondsSinceEpoch(0);

  /// Time that is updated every second.
  @observable
  ObservableStream<DateTime> _time = Stream.periodic(Duration(seconds: 1)).map((_) => DateTime.now()).asObservable();

  @computed
  DateTime get now => _time.value ?? DateTime.now();

  /// The data is expired.
  ///
  /// This is intended to be used on the UI layer to prevent actions before we fetched the data.
  ///
  /// This should only be needed after app startup or when the app resumes from the background because `needsRefresh`
  /// should trigger updates before `expired` becomes true in the normal case.
  @computed
  bool get expired => _lastUpdateIsLongerAgoThan(refreshPeriod + Duration(seconds: 30));

  /// The data is needs a refresh.
  ///
  /// This is intended to be tracked internally such that the `setUpdateReaction` gets fired before `expired` is true.
  @computed
  bool get needsRefresh => _lastUpdateIsLongerAgoThan(refreshPeriod);

  @action
  void setLastUpdate(DateTime dateTime) {
    lastUpdate = dateTime;
  }

  void setupUpdateReaction(Future<void> Function() updateFn) {
    _disposer = reaction((_) => now, (_) async {
      if (needsRefresh) {
        debugPrint("update reaction running...");
        await updateFn();
        lastUpdate = DateTime.now();
        debugPrint("update reaction finished");
      }
    });
  }

  bool _lastUpdateIsLongerAgoThan(Duration duration) {
    return lastUpdate.millisecondsSinceEpoch + duration.inMilliseconds < now.millisecondsSinceEpoch;
  }
}
