class NewAccountResult {
  const NewAccountResult(this.operationResult, {this.newAccountData});

  final NewAccountResultType operationResult;
  final Map<String, dynamic>? newAccountData;

  Map<String, dynamic> get duplicateAccountData {
    assert(newAccountData != null, 'Error: You need to assign a value to `newAccountData` before accessing it.');
    return newAccountData!;
  }
}

enum NewAccountResultType { ok, error, duplicateAccount, emptyPassword }
