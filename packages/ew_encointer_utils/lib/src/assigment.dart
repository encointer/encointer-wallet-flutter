/// Moments day [ms/d]
///
/// https://github.com/encointer/encointer-parachain/blob/b9d21b5caaa640e505264dbad52ef8023ef98f63/polkadot-parachains/encointer-runtime/src/lib.rs#L468
///
/// Fixme: is it better to get this value from the chain?
const momentsPerDay = 86400000;

const momentsPerDegree = momentsPerDay / 360;

int meetupTime(double longitude, int attestingStart, int meetupTimeOffset, int oneDay) {
  final timePerDegree = oneDay.toDouble() / 360;
  // The meetups start at high sun at 180 degrees and during one day the meetup locations travel
  // along the globe until the very last meetup happens at high sun at -180 degrees.
  // So we scale the range 180...-180 to 0...360.
  final lon = (longitude - 180).abs();
  final lonTime = lon * timePerDegree;

  return (attestingStart + lonTime + meetupTimeOffset).round();
}

int assignmentFn(int participantIndex, AssignmentParams params, int assignmentCount) {

  // invalid params
  if (params.m == 0 || assignmentCount == 0) return 0;

  final r1 = participantIndex * params.s1;
  final r2 = r1 + params.s2;
  final r3 = r2.remainder(params.m);
  final endResult = r3.remainder(assignmentCount);

  return endResult;
}

class AssignmentParams {
  const AssignmentParams({
    required this.m,
    required this.s1,
    required this.s2,
  });

  final int m;
  final int s1;
  final int s2;
}
