
import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:iconsax/iconsax.dart';

import 'ceremonyProgressBar.dart';
class CeremonyStep2Scan extends StatelessWidget {
  const CeremonyStep2Scan({
    Key key,
  }) : super(key: key);

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
          padding: EdgeInsets.fromLTRB(30, 24, 30, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CeremonyProgressBar(progress: 2),
                    SizedBox(
                      height: 48,
                    ),
                    Center(
                        child: Text(
                          'Scan',
                          style: Theme.of(context).textTheme.headline2.copyWith(
                            color: ZurichLion.shade600,
                          ),
                        ),),
                    Center(
                      child: Text(
                          'Every attendee must scan everyone else and be scanned by everyone else.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Colors.black, height: 1.5),),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Placeholder(
                      fallbackHeight: 250,
                    ),
                    // TODO show the QR Code to be scanned
                  ],
                ),
              ),
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.arrow_right_2),
                    SizedBox(width: 12),
                    Text(
                      dic.encointer.closeMeetup,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                        color: ZurichLion.shade50,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                onPressed: null, //TODO
              ),
              PrimaryButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.scan_barcode),
                    SizedBox(width: 12),
                    Text(
                      dic.encointer.scanOthers,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                        color: ZurichLion.shade50,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  // TODO
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}