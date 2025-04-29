import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page-encointer/democracy/helpers.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/helpers.dart';
import 'package:ew_polkadart/encointer_types.dart' as et;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('enactmentQueueCheckWorks', () {
    test('returns true if same local proposal exists', () {
      final cid = CommunityIdentifier.fromFmtString('sqm1v79dF6b');
      const actionId = ProposalActionIdentifier.spendNative;
      final queue = <ProposalActionIdWithScope>[ProposalActionIdWithScope(actionId, cid)];

      expect(hasSameProposalForSameScope(queue, actionId, cid), true);
    });

    test('returns true if same global proposal exists', () {
      const actionId = ProposalActionIdentifier.spendNative;
      final queue = <ProposalActionIdWithScope>[ProposalActionIdWithScope(actionId, null)];

      expect(hasSameProposalForSameScope(queue, actionId, null), true);
    });

    test('returns false for different global proposal', () {
      const actionId = ProposalActionIdentifier.spendNative;
      const actionId2 = ProposalActionIdentifier.petition;
      final queue = <ProposalActionIdWithScope>[ProposalActionIdWithScope(actionId, null)];

      expect(hasSameProposalForSameScope(queue, actionId2, null), false);
    });

    test('returns false for different proposal, but same community', () {
      const actionId = ProposalActionIdentifier.spendNative;
      const actionId2 = ProposalActionIdentifier.petition;
      final cid = CommunityIdentifier.fromFmtString('sqm1v79dF6b');
      final queue = <ProposalActionIdWithScope>[ProposalActionIdWithScope(actionId, cid)];

      expect(hasSameProposalForSameScope(queue, actionId2, cid), false);
    });

    test('returns false for the same proposal id, but different community', () {
      final cid = CommunityIdentifier.fromFmtString('sqm1v79dF6b');
      final cid2 = CommunityIdentifier.fromFmtString('u0qj944rhWE');
      const actionId = ProposalActionIdentifier.spendNative;
      final queue = <ProposalActionIdWithScope>[ProposalActionIdWithScope(actionId, cid)];

      expect(hasSameProposalForSameScope(queue, actionId, cid2), false);
    });

    test('returns false for same proposal id but it is global', () {
      final cid = CommunityIdentifier.fromFmtString('sqm1v79dF6b');
      const actionId = ProposalActionIdentifier.petition;
      final queue = <ProposalActionIdWithScope>[ProposalActionIdWithScope(actionId, cid)];

      expect(hasSameProposalForSameScope(queue, actionId, null), false);
    });

    test('returns false for same proposal id but it is local', () {
      final cid = CommunityIdentifier.fromFmtString('sqm1v79dF6b');
      const actionId = ProposalActionIdentifier.petition;
      final queue = <ProposalActionIdWithScope>[ProposalActionIdWithScope(actionId, null)];

      expect(hasSameProposalForSameScope(queue, actionId, cid), false);
    });
  });

  group('isPassingWorks', () {
    test('returns false if minTurnout is not reached', () {
      // Taken from bug report: https://github.com/encointer/encointer-wallet-flutter/issues/1797

      final tally = et.Tally(turnout: BigInt.from(6), ayes: BigInt.from(6));
      final electorateSize = BigInt.from(129);
      final minTurnout = BigInt.from(50);

      expect(isPassing(tally, electorateSize, minTurnout), false);
    });

    test('returns true if turnout threshold is exactly reached', () {
      final tally = et.Tally(turnout: BigInt.from(1), ayes: BigInt.from(1));
      final electorateSize = BigInt.from(2);
      final minTurnout = BigInt.from(50);

      expect(isPassing(tally, electorateSize, minTurnout), true);
    });

    test('returns false for 100% nays', () {
      final tally = et.Tally(turnout: BigInt.from(1), ayes: BigInt.from(0));
      final electorateSize = BigInt.from(2);
      final minTurnout = BigInt.from(50);

      expect(isPassing(tally, electorateSize, minTurnout), false);
    });
  });

  group('minTurnoutReachedWorks', () {
    test('returns false if minTurnout is not reached', () {
      final tally = et.Tally(turnout: BigInt.from(6), ayes: BigInt.from(6));
      final electorateSize = BigInt.from(129);
      final minTurnout = BigInt.from(50);

      expect(minTurnoutReached(tally, electorateSize, minTurnout), false);
    });

    test('returns true if turnout threshold is exactly reached', () {
      final tally = et.Tally(turnout: BigInt.from(1), ayes: BigInt.from(1));
      final electorateSize = BigInt.from(2);
      final minTurnout = BigInt.from(50);

      expect(minTurnoutReached(tally, electorateSize, minTurnout), true);
    });

    test('returns true for max turnout', () {
      final tally = et.Tally(turnout: BigInt.from(2), ayes: BigInt.from(2));
      final electorateSize = BigInt.from(2);
      final minTurnout = BigInt.from(50);

      expect(minTurnoutReached(tally, electorateSize, minTurnout), true);
    });
  });
}
