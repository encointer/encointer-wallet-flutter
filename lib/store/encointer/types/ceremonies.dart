import 'package:encointer_wallet/utils/enum.dart';

enum CeremonyPhase { REGISTERING, ASSIGNING, ATTESTING }

CeremonyPhase ceremonyPhaseFromString(String value) {
  return getEnumFromString(CeremonyPhase.values, value);
}

String toEnumValue(CeremonyPhase phase) {
  return toValue(phase);
}
