enum BiometricAuthState {
  enabled,
  deviceNotSupported,
  disabled;

  factory BiometricAuthState.fromString(String value) {
    return switch (value) {
      'enabled' => BiometricAuthState.enabled,
      'deviceNotSupported' => BiometricAuthState.deviceNotSupported,
      'disabled' => BiometricAuthState.disabled,
      _ => throw Exception(),
    };
  }

  String get name {
    return switch (this) {
      BiometricAuthState.enabled => 'enabled',
      BiometricAuthState.deviceNotSupported => 'deviceNotSupported',
      BiometricAuthState.disabled => 'disabled',
    };
  }

  bool get isEnabled => this == BiometricAuthState.enabled;
}
