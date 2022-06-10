import 'qrCodeBase.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';

class ContactQrCode implements QrCode<ContactData> {
  ContactQrCode(this.data);

  static const context = QrCodeContext.contact;

  static const version = QrCodeVersion.v1_0;

  ContactData data;
}

class ContactData {
  ContactData(this.account, this.cid, this.label);

  /// ss58 encoded public key of the account address.
  final String account;

  /// Community identifier
  final CommunityIdentifier cid;

  /// Name or other identifier for `account`.
  final String label;
}

class PaymentQrCode implements QrCode<PaymentData> {
  PaymentQrCode(this.data);

  static const context = QrCodeContext.invoice;

  static const version = QrCodeVersion.v1_0;

  PaymentData data;
}

class PaymentData {
  PaymentData(this.account, this.cid, this.amount, this.label);

  /// ss58 encoded public key of the account address.
  final String account;

  /// Community identifier.
  final CommunityIdentifier cid;

  /// Optional payment amount for the invoice.
  final num amount;

  /// Name or other identifier for `account`.
  final String label;
}

class VoucherQrCode implements QrCode<VoucherData> {
  VoucherQrCode(this.data);

  static const context = QrCodeContext.invoice;

  static const version = QrCodeVersion.v1_0;

  VoucherData data;
}

class VoucherData {
  VoucherData(this.voucherUri, this.cid, this.network, this.issuer);

  /// Uri seed of the voucher account, e.g. //adf456.
  final String voucherUri;

  /// Community identifier.
  final CommunityIdentifier cid;

  /// Network, e.g: nctr-k, nctr-r.
  final String network;

  /// Name of issuer.
  final String issuer;
}
