enum TransferState {
  notStarted,
  submitting,
  finished,
  failed,
}

extension TransferStateExtension on TransferState {
  bool isFinishedOrFailed() {
    return this == TransferState.finished || this == TransferState.failed;
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
