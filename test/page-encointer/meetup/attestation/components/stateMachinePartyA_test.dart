import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/stateMachinePartyA.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestationState.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

import '../../../../store/localStorage_mock.dart';

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
  testWidgets('stateMachinePartyA test', (WidgetTester tester) async {
    AppStore root = globalAppStore;
    root.localStorage = getMockLocalStorage();
    await root.init('_en');

    root.localStorage.addAccount(accNew);
    final accList = await root.localStorage.getAccountList();
    final pubKeys = accList.map((e) => e['pubKey']).toList();
    expect(accList.length, 2);

    root.encointer.attestations = _buildAttestationStateMap(root, pubKeys);
    // print(root.encointer.attestations);
    expect(root.encointer.attestations.length, 2);

    Widget stateMachineA = StateMachinePartyA(
      root,
      otherMeetupRegistryIndex: 1,
    );

    await tester.pumpWidget(makeTestableWidget(child: stateMachineA));

    expect(find.text("Performing attestation with: ${Fmt.address(pubKeys[1])}"), findsOneWidget);
    expect(find.text("Next step: Show your claim"), findsOneWidget);

    // start attestation procedure. Show ClaimA (my Claim)
    await tester.tap(find.text("Next step: Show your claim"));
    await tester.pump();
  });
}
