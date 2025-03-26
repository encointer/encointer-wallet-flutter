import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/helpers.dart';
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
}
