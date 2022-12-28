//! Basic definitions for encointer-qr codes.

const encointerPrefix = 'encointer';
const String qrCodeFieldSeparator = '\n';

abstract class QrCode<QrCodeData extends ToQrFields> {
  QrCode(this.data);

  QrCodeContext? context;

  QrCodeVersion? version;

  QrCodeData data;

  String toQrPayload() {
    final qrFields = [context.toQrField(), version.toVersionNumber(), ...data.toQrFields()];
    return qrFields.join(qrCodeFieldSeparator);
  }
}

// to use abstract class for only one method is not good.
// ignore: one_member_abstracts
abstract class ToQrFields {
  List<String> toQrFields();
}

/// context identifier
enum QrCodeContext {
  /// `encointer-contact` context
  contact,

  /// `encointer-invoice` context
  invoice,

  /// `encointer-voucher` context
  voucher
  // claim, currently unsupported and might not be merged into this. Let's see.
}

enum QrCodeVersion { v1_0, v2_0 }

extension QrCodeContextExt on QrCodeContext? {
  /// Parses `encointer-<context>` into a `QrCodeContext`.
  static QrCodeContext fromQrField(String value) {
    final context = value.split('-').last.toLowerCase();
    return QrCodeContext.values.firstWhere(
      (type) => type.toString().split('.').last.toLowerCase() == context,
      orElse: () {
        throw FormatException(
            'QR scan context [$value] ->  is not supported; supported values are: ${QrCodeContext.values}');
      },
    );
  }

  String toQrField() {
    final variant = toString().split('.').last.toLowerCase();
    return '$encointerPrefix-$variant';
  }
}

extension QrCodeVersionExt on QrCodeVersion? {
  /// Parses a version string from the format `v2.0`.
  static QrCodeVersion fromQrField(String value) {
    return QrCodeVersion.values.firstWhere(
      (type) => type.toVersionNumber().toLowerCase() == value.toLowerCase(),
      orElse: () => throw FormatException('Unsupported QrCode version [$value]'),
    );
  }

  /// Returns the version number in the format 'v2.0'
  String toVersionNumber() {
    final variant = toString().split('.').last;
    return variant.replaceAll('_', '.');
  }
}
