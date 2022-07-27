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
  Future<void> Function()? _updateFn;

  /// Stores the reaction. Call `_disposer()` to remove the reaction.
  ///
  /// **Caveat:** This is not disposed upon `hot-restart`. Hence, if we change the reaction that is assigned to the
  /// [_disposer], we need to rebuild the app to have a clean state.
  ReactionDisposer? _disposer;

  final Duration refreshPeriod;

  @observable
  DateTime lastUpdate = DateTime.fromMicrosecondsSinceEpoch(0);

  /// Time that is updated every second.
  @observable
  ObservableStream<DateTime> _time = Stream.periodic(Duration(seconds: 1)).map((_) {
    _log("updating time: ${DateTime.now()}");
    return DateTime.now();
  }).asObservable();

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

  /// In order to prevent multiple simultaneous update calls.
  @observable
  bool updating = false;

  @action
  void setLastUpdate(DateTime dateTime) {
    lastUpdate = dateTime;
  }

  void setupUpdateReaction(Future<void> Function() updateFn) {
    _updateFn = updateFn;

    if (_disposer != null) {
      _disposer!();
    }

    _disposer = reaction((_) => now, (_) {
      if (needsRefresh) {
        _log("Reaction triggered...");
        executeUpdate();
      } else {
        // Only enable for debugging purposes, otherwise it spams every second.
        _log("Reaction triggered, but no state-update needed.");
      }
    });
  }

  bool _lastUpdateIsLongerAgoThan(Duration duration) {
    return lastUpdate.millisecondsSinceEpoch + duration.inMilliseconds < now.millisecondsSinceEpoch;
  }

  void disposeReaction() {
    if (_disposer != null) {
      _disposer!();
    }
  }

  /// Execute the update and set the timestamp.
  @action
  Future<void> executeUpdate() async {
    if (_updateFn != null && !updating) {
      _log("update reaction running...");

      updating = true;

      try {
        _log("running `updateFn");
        // Todo: why does update function not return!!!!!
        // Even worse, it seems to brick the reaction, such that it is not triggered anymore.
        await _updateFn!().timeout(Duration(seconds: 15));
        // The below works.
        // await Future.delayed(Duration(seconds: 3));
        _log("`updateFn finished");
        lastUpdate = DateTime.now();
      } catch (e) {
        _log("Error while executing `updateFn`: ${e.toString()}");
      }

      updating = false;

      _log("update reaction finished");
    }
  }
}

void _log(String msg) {
  print("[DataUpdateStore] $msg");
}
