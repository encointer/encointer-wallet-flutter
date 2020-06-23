
enum CeremonyPhase {
  REGISTERING,
  ASSIGNING,
  ATTESTING
}

class Location {
  Location(this.lon, this.lat);
  final double lon;
  final double lat;
}

T getEnumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value,
      orElse: () => null);
}