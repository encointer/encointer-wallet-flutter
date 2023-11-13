/// Moments day [ms/d]
///
/// https://github.com/encointer/encointer-parachain/blob/b9d21b5caaa640e505264dbad52ef8023ef98f63/polkadot-parachains/encointer-runtime/src/lib.rs#L468
const momentsPerDay = 86400000;

const momentsPerDegree = momentsPerDay / 360;

int meetupTime(double longitude, double attestingStart, double meetupTimeOffset, double oneDay) {
  final timePerDegree = oneDay / 360;
  // The meetups start at high sun at 180 degrees and during one day the meetup locations travel
  // along the globe until the very last meetup happens at high sun at -180 degrees.
  // So we scale the range 180...-180 to 0...360.
  final lon = (longitude - 180).abs();
  final lonTime = lon * timePerDegree;

  return (attestingStart + lonTime + meetupTimeOffset).round();
}
