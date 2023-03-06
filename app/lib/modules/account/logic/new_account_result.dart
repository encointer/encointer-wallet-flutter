class NewAccountResult {
  const NewAccountResult(this.operationResult, {this.newAccountData});

  final NewAccountResultType operationResult;
  final Map<String, dynamic>? newAccountData;
}

enum NewAccountResultType { ok, error, duplicateAccount, emptyPassword }
