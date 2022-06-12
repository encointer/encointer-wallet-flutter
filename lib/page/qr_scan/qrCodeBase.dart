//! Basic definitions for encointer-qr codes.

const ENCOINTER_PREFIX = 'encointer';
const String QR_CODE_FIELD_SEPARATOR = '\n';

abstract class QrCode<QrCodeData extends ToQrFields> {
  QrCode(this.data);
  QrCodeContext context;

  QrCodeVersion version;

  QrCodeData data;

  String toQrPayload() {
    final qrFields = [context.toQrField(), version.toVersionNumber()];
    qrFields.addAll(data.toQrFields());
    return qrFields.join(QR_CODE_FIELD_SEPARATOR);
  }
}

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
    final variant = this.toString().split(".").last;
    return variant.replaceAll("_", ".");
  }
}
