class AccountAdvanceOptionParams {
  AccountAdvanceOptionParams({this.type, this.path, this.error});
  static const String encryptTypeSR = 'sr25519';
  static const String encryptTypeED = 'ed25519';
  String? type = encryptTypeSR;
  String? path = '';
  bool? error = false;
}
