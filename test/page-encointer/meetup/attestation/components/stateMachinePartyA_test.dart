import 'package:flutter_test/flutter_test.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/scanQrCode.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/stateMachinePartyA.dart';
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
  int otherMeetupRegistryIndex = 1;
  StateMachinePartyA stateMachineA;

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

    stateMachineA = StateMachinePartyA(
      root,
      otherMeetupRegistryIndex: otherMeetupRegistryIndex,
    );
  });

  tearDown(() {
    root = null;
    webApi = null;
  });

  testWidgets('stateMachinePartyA test', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: stateMachineA));
    expect(find.text("Performing attestation with: ${Fmt.address(pubKeys[1])}"), findsOneWidget);

    await _showClaimA(tester, root, otherMeetupRegistryIndex);
    await _scanAttestationAClaimB(tester, root, otherMeetupRegistryIndex);
    await _showAttestationB(tester, root, otherMeetupRegistryIndex);

    // verify that we have finished the attestation procedure
    expect(find.byType(StateMachinePartyA), findsOneWidget);
    expect(find.text("Next step: Finish"), findsOneWidget);
  });

  group('goBackOneStep', () {
    testWidgets('stays at none', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineA));
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep, CurrentAttestationStep.none);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep, CurrentAttestationStep.none);
    });

    testWidgets('A2_scanAttAClaimB back to A1_showClaimA', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineA));
      await _showClaimA(tester, root, otherMeetupRegistryIndex);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.A1_showClaimA);
    });
    testWidgets('A3_showAttB back to A2_scanAttAClaimB', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineA));
      await _showClaimA(tester, root, otherMeetupRegistryIndex);
      await _scanAttestationAClaimB(tester, root, otherMeetupRegistryIndex);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.A2_scanAttAClaimB);
    });
    testWidgets('finished back to A3_showAttB', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineA));
      await _showClaimA(tester, root, otherMeetupRegistryIndex);
      await _scanAttestationAClaimB(tester, root, otherMeetupRegistryIndex);
      await _showAttestationB(tester, root, otherMeetupRegistryIndex);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.A3_showAttB);
    });
    testWidgets('finished back to A1_showClaimA', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: stateMachineA));
      await _showClaimA(tester, root, otherMeetupRegistryIndex);
      await _scanAttestationAClaimB(tester, root, otherMeetupRegistryIndex);
      await _showAttestationB(tester, root, otherMeetupRegistryIndex);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.A3_showAttB);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.A2_scanAttAClaimB);
      await goBackOneAttestationStep(tester);
      expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
          CurrentAttestationStep.A1_showClaimA);
    });
  });
}

Future<void> _showClaimA(WidgetTester tester, AppStore root, int otherMeetupRegistryIndex) async {
  expect(find.byType(StateMachinePartyA), findsOneWidget);
  expect(find.text("Next step: Show your claim"), findsOneWidget);
  await tester.tap(find.text("Next step: Show your claim"));
  await tester.pumpAndSettle();
  await navigateToQrCodeAndTapConfirmButton(tester);
  expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep,
      CurrentAttestationStep.A2_scanAttAClaimB);
}

Future<void> _scanAttestationAClaimB(WidgetTester tester, AppStore root, int otherMeetupRegistryIndex) async {
  expect(find.byType(StateMachinePartyA), findsOneWidget);
  expect(find.text("Next step: Scan your attestation and other claim"), findsOneWidget);
  await tester.tap(find.text("Next step: Scan your attestation and other claim"));
  await tester.pumpAndSettle();

  ScanQrCode scanner = await navigateToScanner(tester);
  await mockQrCodeScan(tester, scanner, '$attestationHex:$claimHex');
  expect(
      root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep, CurrentAttestationStep.A3_showAttB);
}

Future<void> _showAttestationB(WidgetTester tester, AppStore root, int otherMeetupRegistryIndex) async {
  expect(find.byType(StateMachinePartyA), findsOneWidget);
  expect(find.text("Next step: Show other attestation"), findsOneWidget);
  await tester.tap(find.text("Next step: Show other attestation"));
  await tester.pumpAndSettle();
  await navigateToQrCodeAndTapConfirmButton(tester);
  expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep, CurrentAttestationStep.finished);
}
