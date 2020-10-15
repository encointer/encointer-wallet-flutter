import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/scanQrCode.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/stateMachinePartyB.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestationState.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

import '../../../../mocks/apiEncointer_mock.dart';
import '../../../../mocks/data/mockEncointerData.dart';
import '../../../../mocks/localStorage_mock.dart';
import 'common.dart';

Widget makeTestableWidget({Widget child}) {
  return MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(const Locale('en', '')),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        body: child,
      ),
    ),
  );
}

Map<int, AttestationState> _buildAttestationStateMap(AppStore store, List<dynamic> pubKeys) {
  final map = Map<int, AttestationState>();
  pubKeys.asMap().forEach((i, key) => !(key == store.account.currentAddress)
          ? map.putIfAbsent(i, () => AttestationState(key))
          : store.encointer.myMeetupRegistryIndex = i // track our index as it defines if we must show our qr-code first
      );

  print("My index in meetup registry is " + store.encointer.myMeetupRegistryIndex.toString());
  return map;
}

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

    root.localStorage.addAccount(accNew);
    final accList = await root.localStorage.getAccountList();
    pubKeys = accList.map((e) => e['pubKey']).toList();
    expect(accList.length, 2);

    root.encointer.attestations = _buildAttestationStateMap(root, pubKeys);
    expect(root.encointer.attestations.length, 2);

    stateMachineB = StateMachinePartyB(
      root,
      otherMeetupRegistryIndex: otherMeetupRegistryIndex,
    );
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

    testWidgets('stays at B1_scanClaimA', (WidgetTester tester) async {
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
  await tester.tap(find.text("Next step: Scan other claim"));
  await tester.pumpAndSettle();
  ScanQrCode scanner = await navigateToScanner(tester);
  await mockQrCodeScan(tester, scanner, claimHex);
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
  await tester.tap(find.text("Next step: Scan your attestation"));
  await tester.pumpAndSettle();

  ScanQrCode scanner = await navigateToScanner(tester);
  await mockQrCodeScan(tester, scanner, attestation.toString(), activityIndicatorShown: false);
  expect(root.encointer.attestations[otherMeetupRegistryIndex].currentAttestationStep, CurrentAttestationStep.finished);
}
