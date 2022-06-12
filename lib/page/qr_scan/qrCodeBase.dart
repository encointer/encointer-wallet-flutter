
//! Basic definitions for encointer-qr codes.

const ENCOINTER_PREFIX = 'encointer';

abstract class QrCode<QrCodeData> {
  QrCodeContext context;

  QrCodeVersion version;

  QrCodeData data;
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

enum QrCodeVersion { v1_0 }

extension QrCodeContextExt on QrCodeContext {
  /// Parses `encointer-<context>` into a `QrCodeContext`.
  static QrCodeContext fromQrField(String value) {
    var context = value.toString().split("-").last.toLowerCase();
    return QrCodeContext.values.firstWhere(
      (type) => type.toString().split(".").last.toLowerCase() == context,
      orElse: () {
        throw FormatException(
            'QR scan context [$value] ->  is not supported; supported values are: ${QrCodeContext.values}');
      },
    );
  }

  String toQrField() {
    var variant = this.toString().split(".").last.toLowerCase();
    return "$ENCOINTER_PREFIX-$variant";
  }
}

extension QrCodeVersionExt on QrCodeVersion {
  /// Parses a version string from the format `v1.0`.
  static QrCodeVersion fromQrField(String value) {
    return QrCodeVersion.values.firstWhere(
      (type) => type.toVersionNumber().toLowerCase() == value.toLowerCase(),
      orElse: () => throw FormatException('Unsupported QrCode version [$value]'),
    );
  }

  /// Returns the version number in the format 'v1.0'
  String toVersionNumber() {
    return this.toString().split(".").last.replaceAll("_", ".");
  }
}
