import 'package:encointer_wallet/utils/enum.dart';

enum CeremonyPhase { Registering, Assigning, Attesting }

CeremonyPhase ceremonyPhaseFromString(String value) {
  return getEnumFromString(CeremonyPhase.values, value);
}

enum Reputation { Unverified, UnverifiedReputable, VerifiedUnlinked, VerifiedLinked }

Reputation reputationFromString(String value) {
  return getEnumFromString(Reputation.values, value);
}

extension toReputationExtension on Reputation {
  String toValue() {
    return toEnumValue(this);
  }
}

extension toCeremonyPhaseExtension on CeremonyPhase {
  String toValue() {
    return toEnumValue(this);
  }
}
