// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointer.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EncointerStore on _EncointerStore, Store {
  final _$currentPhaseAtom = Atom(name: '_EncointerStore.currentPhase');

  @override
  CeremonyPhase get currentPhase {
    _$currentPhaseAtom.reportRead();
    return super.currentPhase;
  }

  @override
  set currentPhase(CeremonyPhase value) {
    _$currentPhaseAtom.reportWrite(value, super.currentPhase, () {
      super.currentPhase = value;
    });
  }

  final _$currentCeremonyIndexAtom =
      Atom(name: '_EncointerStore.currentCeremonyIndex');

  @override
  int get currentCeremonyIndex {
    _$currentCeremonyIndexAtom.reportRead();
    return super.currentCeremonyIndex;
  }

  @override
  set currentCeremonyIndex(int value) {
    _$currentCeremonyIndexAtom.reportWrite(value, super.currentCeremonyIndex,
        () {
      super.currentCeremonyIndex = value;
    });
  }

  final _$nextMeetupTimeAtom = Atom(name: '_EncointerStore.nextMeetupTime');

  @override
  int get nextMeetupTime {
    _$nextMeetupTimeAtom.reportRead();
    return super.nextMeetupTime;
  }

  @override
  set nextMeetupTime(int value) {
    _$nextMeetupTimeAtom.reportWrite(value, super.nextMeetupTime, () {
      super.nextMeetupTime = value;
    });
  }

  final _$meetupIndexAtom = Atom(name: '_EncointerStore.meetupIndex');

  @override
  int get meetupIndex {
    _$meetupIndexAtom.reportRead();
    return super.meetupIndex;
  }

  @override
  set meetupIndex(int value) {
    _$meetupIndexAtom.reportWrite(value, super.meetupIndex, () {
      super.meetupIndex = value;
    });
  }

  final _$myMeetupRegistryIndexAtom =
      Atom(name: '_EncointerStore.myMeetupRegistryIndex');

  @override
  int get myMeetupRegistryIndex {
    _$myMeetupRegistryIndexAtom.reportRead();
    return super.myMeetupRegistryIndex;
  }

  @override
  set myMeetupRegistryIndex(int value) {
    _$myMeetupRegistryIndexAtom.reportWrite(value, super.myMeetupRegistryIndex,
        () {
      super.myMeetupRegistryIndex = value;
    });
  }

  final _$nextMeetupLocationAtom =
      Atom(name: '_EncointerStore.nextMeetupLocation');

  @override
  Location get nextMeetupLocation {
    _$nextMeetupLocationAtom.reportRead();
    return super.nextMeetupLocation;
  }

  @override
  set nextMeetupLocation(Location value) {
    _$nextMeetupLocationAtom.reportWrite(value, super.nextMeetupLocation, () {
      super.nextMeetupLocation = value;
    });
  }

  final _$participantIndexAtom = Atom(name: '_EncointerStore.participantIndex');

  @override
  int get participantIndex {
    _$participantIndexAtom.reportRead();
    return super.participantIndex;
  }

  @override
  set participantIndex(int value) {
    _$participantIndexAtom.reportWrite(value, super.participantIndex, () {
      super.participantIndex = value;
    });
  }

  final _$participantCountAtom = Atom(name: '_EncointerStore.participantCount');

  @override
  int get participantCount {
    _$participantCountAtom.reportRead();
    return super.participantCount;
  }

  @override
  set participantCount(int value) {
    _$participantCountAtom.reportWrite(value, super.participantCount, () {
      super.participantCount = value;
    });
  }

  final _$timeStampAtom = Atom(name: '_EncointerStore.timeStamp');

  @override
  int get timeStamp {
    _$timeStampAtom.reportRead();
    return super.timeStamp;
  }

  @override
  set timeStamp(int value) {
    _$timeStampAtom.reportWrite(value, super.timeStamp, () {
      super.timeStamp = value;
    });
  }

  final _$balanceEntriesAtom = Atom(name: '_EncointerStore.balanceEntries');

  @override
  Map<String, BalanceEntry> get balanceEntries {
    _$balanceEntriesAtom.reportRead();
    return super.balanceEntries;
  }

  @override
  set balanceEntries(Map<String, BalanceEntry> value) {
    _$balanceEntriesAtom.reportWrite(value, super.balanceEntries, () {
      super.balanceEntries = value;
    });
  }

  final _$currencyIdentifiersAtom =
      Atom(name: '_EncointerStore.currencyIdentifiers');

  @override
  List<dynamic> get currencyIdentifiers {
    _$currencyIdentifiersAtom.reportRead();
    return super.currencyIdentifiers;
  }

  @override
  set currencyIdentifiers(List<dynamic> value) {
    _$currencyIdentifiersAtom.reportWrite(value, super.currencyIdentifiers, () {
      super.currencyIdentifiers = value;
    });
  }

  final _$chosenCidAtom = Atom(name: '_EncointerStore.chosenCid');

  @override
  String get chosenCid {
    _$chosenCidAtom.reportRead();
    return super.chosenCid;
  }

  @override
  set chosenCid(String value) {
    _$chosenCidAtom.reportWrite(value, super.chosenCid, () {
      super.chosenCid = value;
    });
  }

  final _$attestationsAtom = Atom(name: '_EncointerStore.attestations');

  @override
  Map<int, AttestationState> get attestations {
    _$attestationsAtom.reportRead();
    return super.attestations;
  }

  @override
  set attestations(Map<int, AttestationState> value) {
    _$attestationsAtom.reportWrite(value, super.attestations, () {
      super.attestations = value;
    });
  }

  final _$txsTransferAtom = Atom(name: '_EncointerStore.txsTransfer');

  @override
  ObservableList<TransferData> get txsTransfer {
    _$txsTransferAtom.reportRead();
    return super.txsTransfer;
  }

  @override
  set txsTransfer(ObservableList<TransferData> value) {
    _$txsTransferAtom.reportWrite(value, super.txsTransfer, () {
      super.txsTransfer = value;
    });
  }

  final _$setTransferTxsAsyncAction =
      AsyncAction('_EncointerStore.setTransferTxs');

  @override
  Future<void> setTransferTxs(List<dynamic> list,
      {bool reset = false, dynamic needCache = true}) {
    return _$setTransferTxsAsyncAction.run(
        () => super.setTransferTxs(list, reset: reset, needCache: needCache));
  }

  final _$_cacheTxsAsyncAction = AsyncAction('_EncointerStore._cacheTxs');

  @override
  Future<void> _cacheTxs(List<dynamic> list, String cacheKey) {
    return _$_cacheTxsAsyncAction.run(() => super._cacheTxs(list, cacheKey));
  }

  final _$loadCacheAsyncAction = AsyncAction('_EncointerStore.loadCache');

  @override
  Future<void> loadCache() {
    return _$loadCacheAsyncAction.run(() => super.loadCache());
  }

  final _$_EncointerStoreActionController =
      ActionController(name: '_EncointerStore');

  @override
  void setCurrentPhase(CeremonyPhase phase) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setCurrentPhase');
    try {
      return super.setCurrentPhase(phase);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentCeremonyIndex(dynamic index) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setCurrentCeremonyIndex');
    try {
      return super.setCurrentCeremonyIndex(index);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNextMeetupLocation(Location location) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setNextMeetupLocation');
    try {
      return super.setNextMeetupLocation(location);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNextMeetupTime(int time) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setNextMeetupTime');
    try {
      return super.setNextMeetupTime(time);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeetupIndex(int index) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setMeetupIndex');
    try {
      return super.setMeetupIndex(index);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMyMeetupRegistryIndex(int index) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setMyMeetupRegistryIndex');
    try {
      return super.setMyMeetupRegistryIndex(index);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrencyIdentifiers(dynamic cids) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setCurrencyIdentifiers');
    try {
      return super.setCurrencyIdentifiers(cids);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChosenCid(dynamic cid) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setChosenCid');
    try {
      return super.setChosenCid(cid);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAttestation(dynamic idx, dynamic att) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.addAttestation');
    try {
      return super.addAttestation(idx, att);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeAttestations() {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.purgeAttestations');
    try {
      return super.purgeAttestations();
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addBalanceEntry(dynamic cid, dynamic balanceEntry) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.addBalanceEntry');
    try {
      return super.addBalanceEntry(cid, balanceEntry);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setParticipantIndex(int pIndex) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setParticipantIndex');
    try {
      return super.setParticipantIndex(pIndex);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setParticipantCount(int pCount) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setParticipantCount');
    try {
      return super.setParticipantCount(pCount);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTimestamp(int time) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setTimestamp');
    try {
      return super.setTimestamp(time);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPhase: ${currentPhase},
currentCeremonyIndex: ${currentCeremonyIndex},
nextMeetupTime: ${nextMeetupTime},
meetupIndex: ${meetupIndex},
myMeetupRegistryIndex: ${myMeetupRegistryIndex},
nextMeetupLocation: ${nextMeetupLocation},
participantIndex: ${participantIndex},
participantCount: ${participantCount},
timeStamp: ${timeStamp},
balanceEntries: ${balanceEntries},
currencyIdentifiers: ${currencyIdentifiers},
chosenCid: ${chosenCid},
attestations: ${attestations},
txsTransfer: ${txsTransfer}
    ''';
  }
}
