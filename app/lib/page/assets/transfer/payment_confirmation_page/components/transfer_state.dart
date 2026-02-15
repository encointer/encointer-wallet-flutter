enum TransferState {
  notStarted,
  submitting,
  finished,
  failed,
  offlineQrReady,
}

extension TransferStateExtension on TransferState {
  bool isFinishedOrFailed() {
    return this == TransferState.finished || this == TransferState.failed || this == TransferState.offlineQrReady;
  }

  bool notStarted() {
    return this == TransferState.notStarted;
  }

  bool isSubmitting() {
    return this == TransferState.submitting;
  }

  bool isFinished() {
    return this == TransferState.finished;
  }

  bool isFailed() {
    return this == TransferState.failed;
  }
}
