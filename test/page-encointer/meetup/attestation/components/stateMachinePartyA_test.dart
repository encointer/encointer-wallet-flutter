import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/scanQrCode.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/stateMachinePartyA.dart';
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
    // print(root.encointer.attestations);
    expect(root.encointer.attestations.length, 2);
  });

  testWidgets('stateMachinePartyA test', (WidgetTester tester) async {
    Widget stateMachineA = StateMachinePartyA(
      root,
      otherMeetupRegistryIndex: 1,
    );

    await tester.pumpWidget(makeTestableWidget(child: stateMachineA));

    expect(find.text("Performing attestation with: ${Fmt.address(pubKeys[1])}"), findsOneWidget);
    // unfortunately RoundedButton does not have the key fild, we can only find it by type or by text.
    expect(find.text("Next step: Show your claim"), findsOneWidget);

    // start attestation procedure. Show ClaimA (my Claim)
    await tester.tap(find.text("Next step: Show your claim"));
    await tester.pumpAndSettle();

    await verifyNavigateToQrCodeAndTapConfirmButton(tester);

    expect(find.byType(StateMachinePartyA), findsOneWidget);
    await tester.tap(find.text("Next step: Scan your attestation and other claim"));
    await tester.pumpAndSettle();

    ScanQrCode scanner = await verifyNavigateToScanner(tester);
    await verifyScanResult(tester, scanner, '$attestationHex:$claimHex');

    // show QR code of AttestationB
    expect(find.byType(StateMachinePartyA), findsOneWidget);
    await tester.tap(find.text("Next step: Show other attestation"));
    await tester.pumpAndSettle();

    await verifyNavigateToQrCodeAndTapConfirmButton(tester);

    // verify that we have finished the attestation procedure
    expect(find.byType(StateMachinePartyA), findsOneWidget);
    expect(find.text("Next step: Finish"), findsOneWidget);
  });
}
