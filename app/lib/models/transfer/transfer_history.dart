import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:encointer_wallet/utils/extensions/double/double_extension.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/utils/format.dart';

part 'transfer_history.g.dart';

/// A class representing an Encointer transaction.
@JsonSerializable()
class Transaction {
  const Transaction({
    required this.blockNumber,
    required this.timestamp,
    required this.counterParty,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  /// The block number in which the transaction was made.
  final String blockNumber;

  /// The timestamp of the transaction, in milliseconds.
  final String timestamp;

  /// The address of the counterparty.
  final String counterParty;

  /// The amount of the transaction.
  @ShortenedDouble()
  final double amount;

  /// Determines the type of this [Transaction] based on its amount.
  /// Returns [TransactionType.outgoing] for negative amounts, and [TransactionType.incoming] for positive amounts.
  TransactionType get type => amount < 0 ? TransactionType.outgoing : TransactionType.incoming;

  /// Returns the date and time of the transaction as a [DateTime] object.
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));

  /// Returns the name of the [counterparty] in the transaction by checking against the provided [contacts] list.
  /// Returns null if no matching contact is found.
  String? getNameFromContacts(List<AccountData> contacts) {
    for (final contact in contacts) {
      // Contact address might be with default prefix 42, or with Kusama prefix 2.
      // So better to work with the universal pubKey.
      if (contact.pubKey == Fmt.ss58Decode(counterParty).pubKey) return contact.name;
    }
    return null;
  }

  /// If the value of [counterParty] is 'ISSUANCE', the income has been distributed by the community.
  /// If the income is provided by the community, the [name] should be displayed as
  /// `{CommunityName} Community` and the [address] as `income issuance`.
  bool get isIssuance => counterParty == 'ISSUANCE';
}

/// An enumeration of the transaction types.
enum TransactionType {
  outgoing,
  incoming;

  String getText(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      TransactionType.outgoing => l10n.sent,
      TransactionType.incoming => l10n.received,
    };
  }
}

class ShortenedDouble implements JsonConverter<double, num> {
  const ShortenedDouble();

  @override
  double fromJson(num val) {
    if (val is int) {
      return val.toDouble();
    } else {
      return (val as double).shortenBigNumber(val, 4);
    }
  }

  @override
  num toJson(num val) => val;
}
