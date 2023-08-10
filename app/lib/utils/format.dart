import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:base58check/base58.dart';
import 'package:base58check/base58check.dart';
import 'package:convert/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:pointycastle/digests/blake2b.dart';

class Fmt {
  static String passwordToEncryptKey(String password) {
    final passHex = hex.encode(utf8.encode(password));
    if (passHex.length > 32) {
      return passHex.substring(0, 32);
    }
    return passHex.padRight(32, '0');
  }

  static String? address(String? addr, {int pad = 6}) {
    if (addr == null || addr.length < pad) {
      return addr;
    }
    return '${addr.substring(0, pad)}...${addr.substring(addr.length - pad)}';
  }

  static String dateTime(DateTime time) {
    return DateFormat('yyyy-MM-dd hh:mm').format(time);
  }

  static String hhmmss(int seconds) {
    final d = Duration(seconds: seconds);
    return d.toString().split('.').first.padLeft(8, '0');
  }

  /// number transform 1:
  /// from raw <String> of Api data to <BigInt>
  static BigInt balanceInt(String raw) {
    if (raw.isEmpty) {
      return BigInt.zero;
    }
    if (raw.contains(',') || raw.contains('.')) {
      return BigInt.from(NumberFormat(',##0.000').parse(raw));
    } else {
      return BigInt.parse(raw);
    }
  }

  /// number transform 2:
  /// from <BigInt> to <double>
  static double bigIntToDouble(BigInt value, int? decimals) {
    return value / BigInt.from(pow(10, decimals!));
  }

  /// number transform 3:
  /// from <double> to <String> in token format of ",##0.000"
  static String doubleFormat(
    double? value, {
    int? length = 3,
    int round = 0,
  }) {
    if (value == null) {
      return '~';
    }
    value.toStringAsFixed(3);
    final f = NumberFormat(",##0${length! > 0 ? '.' : ''}${'#' * length}", 'en_US');
    return f.format(value);
  }

  /// number transform 3a:
  /// from <String> to <String> in token format of ",##0.000"
  static String numberFormat(
    String? value, {
    int length = 3,
    int round = 0,
  }) {
    if (value == null) {
      return '~';
    }

    return doubleFormat(double.parse(value), length: length);
  }

  /// combined number transform 1-3:
  /// from raw <String> to <String> in token format of ",##0.000"
  static String balance(
    String? raw,
    int? decimals, {
    int? length = 3,
  }) {
    if (raw == null || raw.isEmpty) {
      return '~';
    }
    return doubleFormat(bigIntToDouble(balanceInt(raw), decimals), length: length);
  }

  /// combined number transform 1-2:
  /// from raw <String> to <double>
  static double balanceDouble(String raw, int decimals) {
    return bigIntToDouble(balanceInt(raw), decimals);
  }

  /// combined number transform 2-3:
  /// from <BigInt> to <String> in token format of ",##0.000"
  static String token(
    BigInt value,
    int? decimals, {
    int? length = 3,
  }) {
    return doubleFormat(bigIntToDouble(value, decimals), length: length);
  }

  /// number transform 4:
  /// from <String of double> to <BigInt>
  static BigInt tokenInt(String value, int decimals) {
    var v = 0;
    try {
      if (value.contains(',') || value.contains('.')) {
        v = NumberFormat(",##0.${"0" * decimals}").parse(value) as int;
      } else {
        v = double.parse(value) as int;
      }
    } catch (e, s) {
      Log.e('Fmt.tokenInt() error: $e', 'Fmt', s);
    }
    return BigInt.from(v * pow(10, decimals));
  }

  /// number transform 5:
  /// from <BigInt> to <String> in price format of ",##0.00"
  /// ceil number of last decimal
  static String priceCeil(
    double value, {
    int lengthFixed = 2,
    int? lengthMax,
  }) {
    final x = pow(10, lengthMax ?? lengthFixed) as int;
    final price = (value * x).ceilToDouble() / x;
    final tailDecimals = lengthMax == null ? '' : '#' * (lengthMax - lengthFixed);
    return NumberFormat(",##0${lengthFixed > 0 ? '.' : ''}${"0" * lengthFixed}$tailDecimals", 'en_US').format(price);
  }

  /// number transform 6:
  /// from <BigInt> to <String> in price format of ",##0.00"
  /// floor number of last decimal
  static String priceFloor(
    double value, {
    int lengthFixed = 2,
    int? lengthMax,
  }) {
    final x = pow(10, lengthMax ?? lengthFixed) as int;
    final price = (value * x).floorToDouble() / x;
    final tailDecimals = lengthMax == null ? '' : '#' * (lengthMax - lengthFixed);
    return NumberFormat(",##0${lengthFixed > 0 ? '.' : ''}${"0" * lengthFixed}$tailDecimals", 'en_US').format(price);
  }

  /// number transform 7:
  /// from number to <String> in price format of ",##0.###%"
  static String ratio(dynamic number, {bool needSymbol = true}) {
    final f = NumberFormat(",##0.###${needSymbol ? '%' : ''}");
    return f.format(number ?? 0);
  }

  static String priceCeilBigInt(
    BigInt value,
    int decimals, {
    int lengthFixed = 2,
    int? lengthMax,
  }) {
    return priceCeil(Fmt.bigIntToDouble(value, decimals), lengthFixed: lengthFixed, lengthMax: lengthMax);
  }

  static String priceFloorBigInt(
    BigInt value,
    int decimals, {
    int lengthFixed = 2,
    int? lengthMax,
  }) {
    return priceFloor(Fmt.bigIntToDouble(value, decimals), lengthFixed: lengthFixed, lengthMax: lengthMax);
  }

  static bool isAddress(String txt) {
    final reg = RegExp(r'^[A-z\d]{47,48}$');
    return reg.hasMatch(txt);
  }

  static bool isHexString(String hex) {
    final reg = RegExp(r'^[a-f0-9]+$');
    return reg.hasMatch(hex);
  }

  static bool checkPassword(String pass) {
    final reg = RegExp(r'^([0-9]){4,20}$');
    return reg.hasMatch(pass);
  }

  static String accountName(BuildContext context, AccountData acc) {
    return '${acc.name}${(acc.observation ?? false) ? ' (${context.l10n.observe})' : ''}';
  }

  /// The hexToBytes function converts a hexadecimal string to a byte array.
  /// It takes a hexadecimal string as input and returns a Uint8List type array as output.
  /// ```dart
  /// print(hexToBytes1('#ffffff')); // [255, 255, 255, 255]
  /// ```
  static List<int> hexToBytes(String hexString) {
    // The function first removes any spaces and "0x" prefixes from the input string,
    // then converts the input string to lowercase.
    var hex = hexString.replaceAll(' ', '').replaceAll('0x', '').toLowerCase();

    // If the input string contains an odd number of characters, it adds a "0" to the beginning.
    if (hex.length % 2 != 0) hex = '0$hex';

    // Convert hex string to bytes
    final bytes = <int>[];
    for (var i = 0; i < hexString.length; i += 2) {
      final hexByte = hexString.substring(i, i + 2);
      bytes.add(int.parse(hexByte, radix: 16));
    }

    return bytes;
  }

  static String bytesToHex(List<int> bytes) {
    return '0x${hex.encode(bytes)}';
  }

  static String? accountDisplayNameString(String? address, Map<dynamic, dynamic>? accInfo) {
    var display = Fmt.address(address);
    if (accInfo != null) {
      if ((accInfo['identity'] as Map<String, dynamic>)['display'] != null) {
        display = (accInfo['identity'] as Map<String, dynamic>)['display'] as String?;
        if ((accInfo['identity'] as Map<String, dynamic>)['displayParent'] != null) {
          display = '${(accInfo['identity'] as Map<String, dynamic>)['displayParent']}/$display';
        }
      } else if (accInfo['accountIndex'] != null) {
        display = accInfo['accountIndex'] as String?;
      }
      display = display!.toUpperCase();
    }
    return display;
  }

  static String tokenView(String? token) {
    final tokenView = token ?? '';
    return tokenView;
  }

  /// Formats fixed point number with the amount of fractional digits given by [fixedPointFraction].
  static String degree(String degree, {int fixedPointFraction = 64, int fractionDisplay = 3}) {
    return (double.tryParse(degree) ?? 0.0).toStringAsFixed(fractionDisplay);
  }

  static const base58Codec = Base58Codec(Base58CheckCodec.BITCOIN_ALPHABET);

  /// Convert a pubKey into an SS58-address.
  ///
  /// Based on the rust version: https://github.com/paritytech/substrate/blob/48e7cb147cb9a27125fd2e82edbcf4d0ed5927c4/primitives/core/src/crypto.rs#L324
  ///
  /// Note: This only supports prefixes < 64, bigger prefixes require
  /// special handling.
  static String ss58Encode(String pubKey, {int prefix = 42}) {
    if (prefix >= 64) throw Exception('prefixes >= 64 are currently not supported');

    final body = Uint8List.fromList([prefix, ...Fmt.hexToBytes(pubKey)]);
    final hash = blake2WithSs58Pre(body);

    final complete = List<int>.from([...body, hash[0], hash[1]]);
    return base58Codec.encode(complete);
  }

  /// General pubKey length used in substrate and Encointer.
  static const pubKeyLen = 32;

  /// Length of the checksum in an SS58-address.
  static const checkSumLen = 2;

  /// If the SS58-address has a prefix < 64 the prefix length is 1 else it is 2.
  ///
  /// All Encointer networks use the prefix 2 or 42, so we can only implement a subset of the
  /// SS58-codec.
  static const prefixLenForPrefixesSmallerThan64 = 1;

  /// Convert an SS58-address into a pubKey.
  ///
  /// Based on the rust version: https://github.com/paritytech/substrate/blob/48e7cb147cb9a27125fd2e82edbcf4d0ed5927c4/primitives/core/src/crypto.rs#L269
  ///
  /// Note: This only supports prefixes < 64, bigger prefixes require
  /// special handling.
  static Ss58DecodeResult ss58Decode(String address) {
    const prefixLen = prefixLenForPrefixesSmallerThan64;

    final data = base58Codec.decode(address);
    final prefix = data[0];

    if (prefix >= 64) throw Exception('prefixes >= 64 are currently not supported');
    if (data.length != prefixLen + pubKeyLen + checkSumLen) throw Exception('Bad address length ${data.length}');

    final hash = blake2WithSs58Pre(Uint8List.fromList(data.sublist(0, pubKeyLen + prefixLen)));
    final checksum = hash.sublist(0, checkSumLen);
    final checksumData = data.sublist(pubKeyLen + prefixLen, pubKeyLen + prefixLen + checkSumLen);
    if (!listEquals(checksumData, checksum)) throw Exception('Invalid checksum: $checksumData != $checksum');

    return Ss58DecodeResult(bytesToHex(data.sublist(prefixLen, prefixLen + pubKeyLen)), prefix);
  }

  static final ss58Prefix = 'SS58PRE'.codeUnits;

  /// Corresponds to the `ss58hash`: https://github.com/paritytech/substrate/blob/48e7cb147cb9a27125fd2e82edbcf4d0ed5927c4/primitives/core/src/crypto.rs#L374
  static Uint8List blake2WithSs58Pre(Uint8List data) {
    final ss58Pre = Uint8List.fromList(ss58Prefix);

    final blake2 = Blake2bDigest()
      ..init()
      ..update(ss58Pre, 0, ss58Pre.length)
      ..update(data, 0, data.length);

    final hash = Uint8List(blake2.digestSize);
    blake2.doFinal(hash, 0);

    return hash;
  }
}

class Ss58DecodeResult {
  const Ss58DecodeResult(this.pubKey, this.prefix);

  /// The pubKey corresponding to the input address.
  final String pubKey;

  /// The prefix of the input address.
  final int prefix;
}
