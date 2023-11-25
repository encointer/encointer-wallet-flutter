import 'package:ew_polkadart/encointer_types.dart';

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

int computeMeetupIndex(
  int participantIndex,
  ParticipantType participantType,
  Assignment assignment,
  AssignmentCount assignmentCount,
  int meetupCount,
) {
  if (meetupCount == 0) return 0;
  if (participantIndex == 0) return 0;

  final pIndex = participantIndex - 1;

  int mIndexFn(int pIndex, AssignmentParams params) => meetupIndex(pIndex, params, meetupCount);

  switch (participantType) {
    case ParticipantType.bootstrapper:
      if (pIndex < assignmentCount.bootstrappers) return mIndexFn(pIndex, assignment.bootstrappersReputables);
    case ParticipantType.reputable:
      if (pIndex < assignmentCount.reputables) {
        return mIndexFn(pIndex + assignmentCount.bootstrappers, assignment.bootstrappersReputables);
      }
    case ParticipantType.endorsee:
      if (pIndex < assignmentCount.endorsees) return mIndexFn(pIndex, assignment.endorsees);
    case ParticipantType.newbie:
      if (pIndex < assignmentCount.newbies) return mIndexFn(pIndex, assignment.newbies);
  }

  return 0;
}

/// Gets the meetup index.
///
/// Throws an exception if params.m or assignmentCount is 0.
int meetupIndex(int participantIndex, AssignmentParams params, int assignmentCount) {
  return assignmentFn(participantIndex, params, assignmentCount) + 1;
}

int assignmentFn(int participantIndex, AssignmentParams params, int assignmentCount) {
  // invalid params
  if (params.m == 0 || assignmentCount == 0) {
    throw Exception('[assignmentFn] invalid meetup params. params.m or assignmentCount was 0.');
  }

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

class Assignment {
  const Assignment({
    required this.bootstrappersReputables,
    required this.endorsees,
    required this.newbies,
    required this.locations,
  });

  final AssignmentParams bootstrappersReputables;
  final AssignmentParams endorsees;
  final AssignmentParams newbies;
  final AssignmentParams locations;
}

class AssignmentCount {
  const AssignmentCount({
    required this.bootstrappers,
    required this.reputables,
    required this.endorsees,
    required this.newbies,
  });

  final int bootstrappers;
  final int reputables;
  final int endorsees;
  final int newbies;
}
