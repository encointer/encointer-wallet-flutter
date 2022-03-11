import 'package:encointer_wallet/utils/enum.dart';

enum CeremonyPhase { REGISTERING, ASSIGNING, ATTESTING }

// this becomes possible if dart min SDK > 2.6
// extension FromStringExtension on CeremonyPhase {
//
//   CeremonyPhase fromString(String value) {
//     return ceremonyPhaseFromString(value);
//   }
// }

CeremonyPhase ceremonyPhaseFromString(String value) {
  return getEnumFromString(CeremonyPhase.values, value);
}

String toEnumValue(CeremonyPhase phase) {
  return toValue(phase);
}
