import 'package:mobx/mobx.dart';

part 'data_update.g.dart';

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
  // ignore: prefer_final_fields
  ObservableStream<DateTime> _time = Stream.periodic(const Duration(seconds: 1)).map((_) {
    // _log("updating time: ${DateTime.now()}");
    return DateTime.now();
  }).asObservable();

  @computed
  DateTime get now => _time.value ?? DateTime.now();

  /// If the data has been invalidated.
  ///
  /// This is intended to be set from the outside due to certain actions that invalidate the data.
  @observable
  bool invalidated = false;

  /// The data is expired.
  ///
  /// This is intended to be used on the UI layer to prevent actions before we fetched the data.
  ///
  /// This should only be needed after app startup or when the app resumes from the background because `needsRefresh`
  /// should trigger updates before `expired` becomes true in the normal case.
  @computed
  bool get expired => _lastUpdateIsLongerAgoThan(refreshPeriod + const Duration(seconds: 30)) | invalidated;

  /// The data is needs a refresh.
  ///
  /// This is intended to be tracked internally such that the `setUpdateReaction` gets fired before `expired` is true.
  @computed
  bool get needsRefresh => _lastUpdateIsLongerAgoThan(refreshPeriod) | invalidated;

  /// In order to prevent multiple simultaneous update calls.
  Future<void>? _updateFuture;

  @action
  void setLastUpdate(DateTime dateTime) {
    lastUpdate = dateTime;
  }

  @action
  setInvalidated() {
    invalidated = true;
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
        // _log("Reaction triggered, but no state-update needed.");
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
    if (_updateFn == null) {
      _log("No `updateFn` set, returning...");
      return;
    }

    if (_updateFuture != null) {
      _log("already updating, awaiting the previously set future.");
      await _updateFuture!;
      return;
    }

    _updateFuture = _updateFn!().timeout(const Duration(seconds: 15)).then((value) {
      // Data is valid and up-to-date again
      invalidated = false;
      lastUpdate = DateTime.now();
    }).catchError((e) {
      _log("Error while executing `updateFn`: ${e.toString()}");
    }).whenComplete(() {
      _updateFuture = null;
      _log("update reaction finished");
    });

    await _updateFuture!;
  }
}

void _log(String msg) {
  print("[DataUpdateStore] $msg");
}
