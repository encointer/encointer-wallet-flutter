/// Manages the cryptographic keys on the end device
library ew_keyring;

export 'package:polkadart_keyring/polkadart_keyring.dart' show Sr25519KeyPair;

export 'src/address_extension.dart' show AddressExtension;
export 'src/address_utils.dart' show Address, AddressUtils;
export 'src/keyring.dart' show EncointerKeyring, testKeyring;
export 'src/keyring_account.dart' show KeyringAccount, KeyringAccountData;
export 'src/keyring_utils.dart' show KeyringUtils;
export 'src/validate_keys.dart' show ValidateKeys, getSeedTypeFromString, isValidSeed;
