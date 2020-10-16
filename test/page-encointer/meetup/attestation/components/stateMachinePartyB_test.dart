import 'package:flutter_test/flutter_test.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/stateMachinePartyB.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestationState.dart';
import 'package:polka_wallet/utils/format.dart';

import '../../../../mocks/apiEncointer_mock.dart';
import '../../../../mocks/data/mockEncointerData.dart';
import '../../../../mocks/localStorage_mock.dart';
import 'common.dart';

void main() {
  AppStore root;
  List<dynamic> pubKeys;
  int otherMeetupRegistryIndex = 0;
  StateMachinePartyB stateMachineB;

  setUp(() async {
    root = globalAppStore;
    root.localStorage = getMockLocalStorage();
    await root.init('_en');

    webApi = Api(null, root);
    webApi.encointer = getMockApiEncointer();

    pubKeys = [accList[0], accNew].map((e) => e['pubKey']).toList();
    expect(pubKeys.length, 2);

    root.encointer.attestations = buildAttestationStateMap(root, pubKeys);
    expect(root.encointer.attestations.length, 2);

    stateMachineB = StateMachinePartyB(
      root,
      otherMeetupRegistryIndex: otherMeetupRegistryIndex,
    );
  });

  tearDown(() {
    root = null;
    webApi = null;
  });

  testWidgets('StateMachinePartyB happy flow', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: stateMachineB));
    expect(find.text("Performing attestation with: ${Fmt.address(pubKeys[0])}"), findsOneWidget);

    await _scanClaimA(tester, root, otherMeetupRegistryIndex);
    await _showAttestationAClaimB(tester, root, otherMeetupRegistryIndex);
    await _scanAttestationB(tester, root, otherMeetupRegistryIndex);

    // verify that we have finished the attestation procedure
    expect(find.byType(StateMachinePartyB), findsOneWidget);
    expect(find.text("Next step: Finish"), findsOneWidget);
  });

  group('goBackOneStep', () {
    testWidgets('stays at none', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineB));
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep, CurrentAttestationStep.none);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep, CurrentAttestationStep.none);
    });

    testWidgets('B2_showAttAClaimB back to B1_scanClaimA', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineB));
      await _scanClaimA(tester, root, otherMeetupRegistryIndex);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.B1_scanClaimA);
    });
    testWidgets('B3_scanAttB  back to B2_showAttAClaimB', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineB));
      await _scanClaimA(tester, root, otherMeetupRegistryIndex);
      await _showAttestationAClaimB(tester, root, otherMeetupRegistryIndex);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.B2_showAttAClaimB);
    });
    testWidgets('finished back to B3_scanAttB', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineB));
      await _scanClaimA(tester, root, otherMeetupRegistryIndex);
      await _showAttestationAClaimB(tester, root, otherMeetupRegistryIndex);
      await _scanAttestationB(tester, root, otherMeetupRegistryIndex);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.B3_scanAttB);
    });
    testWidgets('finished back to B1_scanClaimA', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineB));
      await _scanClaimA(tester, root, otherMeetupRegistryIndex);
      await _showAttestationAClaimB(tester, root, otherMeetupRegistryIndex);
      await _scanAttestationB(tester, root, otherMeetupRegistryIndex);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.B3_scanAttB);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.B2_showAttAClaimB);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.B1_scanClaimA);
    });
  });
}

Future<void> _scanClaimA(WidgetTester tester, AppStore root, int otherMeetupRegistryIndex) async {
  expect(find.byType(StateMachinePartyB), findsOneWidget);
  expect(find.text("Next step: Scan other claim"), findsOneWidget);

  root.encointer.addOtherAttestation(otherMeetupRegistryIndex, attestationHex);
  root.encointer.updateAttestationStep(otherMeetupRegistryIndex, CurrentAttestationStep.B2_showAttAClaimB);
  await tester.pumpAndSettle();

  expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
      CurrentAttestationStep.B2_showAttAClaimB);
}

Future<void> _showAttestationAClaimB(WidgetTester tester, AppStore root, int otherMeetupRegistryIndex) async {
  expect(find.byType(StateMachinePartyB), findsOneWidget);
  expect(find.text("Next step: Show other attestation and your claim"), findsOneWidget);
  await tester.tap(find.text("Next step: Show other attestation and your claim"));
  await tester.pumpAndSettle();
  await navigateToQrCodeAndTapConfirmButton(tester);
  expect(
      root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep, CurrentAttestationStep.B3_scanAttB);
}

Future<void> _scanAttestationB(WidgetTester tester, AppStore root, int otherMeetupRegistryIndex) async {
  expect(find.byType(StateMachinePartyB), findsOneWidget);
  expect(find.text("Next step: Scan your attestation"), findsOneWidget);

  root.encointer.addYourAttestation(otherMeetupRegistryIndex, attestationHex);
  root.encointer.updateAttestationStep(otherMeetupRegistryIndex, CurrentAttestationStep.finished);
  await tester.pumpAndSettle();

  expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep, CurrentAttestationStep.finished);
}
