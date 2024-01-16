import 'package:ew_keyring/ew_keyring.dart';

class NewAccountResult {
  const NewAccountResult(this.operationResult, {this.newAccount});

  final NewAccountResultType operationResult;
  final KeyringAccount? newAccount;

  KeyringAccount get duplicateAccountData {
    assert(newAccount != null, 'Error: You need to assign a value to `newAccountData` before accessing it.');
    return newAccount!;
  }
}

enum NewAccountResultType { ok, error, duplicateAccount, emptyPassword }
