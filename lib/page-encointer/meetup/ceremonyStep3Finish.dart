
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'ceremonyProgressBar.dart';

class CeremonyStep3Finish extends StatelessWidget {
  const CeremonyStep3Finish({
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
            key: Key('close-encointer-ceremony-step3'),
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
                    // CommunityAvatar(
                    //   store: store,
                    //   avatarIcon: webApi.ipfs.getCommunityIcon(store.encointer.community?.assetsCid),
                    //   avatarSize: widget.communityAvatarSize,
                    // ),
                    Center(
                      child: Text(
                        'Thank you',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: ZurichLion.shade600,
                        ),
                      ),),
                    Center(
                      child: Text(
                          'The next meetup will take place on:',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Colors.black, height: 1.5)),
                    ),
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
