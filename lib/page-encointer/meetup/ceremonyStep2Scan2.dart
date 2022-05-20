import 'dart:convert';
import 'dart:typed_data';

import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/meetup/scanClaimQrCode.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'ceremonyProgressBar.dart';
import 'ceremonyStep3Finish.dart';

class CeremonyStep2Scan extends StatelessWidget {
  const CeremonyStep2Scan(
    this.store, {
    @required this.claim,
    @required this.confirmedParticipantsCount,
    Key key,
  }) : super(key: key);

  final AppStore store;
  final Future<Uint8List> claim;
  final int confirmedParticipantsCount;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(dic.encointer.encointerCeremony),
        leading: Container(),
        actions: [
          IconButton(
            key: Key('close-encointer-ceremony-step2'),
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 24, 30, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CeremonyProgressBar(progress: 2),
                    SizedBox(height: 48),
                    Center(
                      child: Text(
                        'Scan',
                        style: Theme.of(context).textTheme.headline2.copyWith(color: ZurichLion.shade600),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Every attendee must scan everyone else and be scanned by everyone else.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black, height: 1.25),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: 395,
                      height: 395,
                      child: FutureBuilder<Uint8List>(
                        future: claim,
                        builder: (_, AsyncSnapshot<Uint8List> snapshot) {
                          if (snapshot.hasData) {
                            return QrImage(
                              data: base64.encode(snapshot.data),
                              errorCorrectionLevel: QrErrorCorrectLevel.L,
                            );
                          } else {
                            return CupertinoActivityIndicator();
                          }
                        },
                      ),
                    ),
                    // TODO show the QR Code to be scanned
                  ],
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.arrow_right_2),
                    SizedBox(width: 12, height: 60),
                    Text(dic.encointer.closeMeetup, style: Theme.of(context).textTheme.headline3),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CeremonyStep3Finish(store)));
                },
              ),
              SizedBox(height: 12),
              PrimaryButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.scan_barcode),
                    SizedBox(width: 12),
                    Text(
                      dic.encointer.scanOthers,
                      style: Theme.of(context).textTheme.headline3.copyWith(color: ZurichLion.shade50),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ScanClaimQrCode(store, confirmedParticipantsCount),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
