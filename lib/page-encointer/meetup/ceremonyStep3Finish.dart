import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserPanel.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'ceremonyProgressBar.dart';

class CeremonyStep3Finish extends StatelessWidget {
  const CeremonyStep3Finish(
    this.store, {
    Key key,
  }) : super(key: key);

  final AppStore store;

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
          padding: EdgeInsets.fromLTRB(30, 24, 30, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CeremonyProgressBar(progress: 3),
                    SizedBox(height: 48),
                    CommunityAvatar(
                      store: store,
                      avatarIcon: webApi.ipfs.getCommunityIcon(store.encointer.community?.assetsCid),
                      avatarSize: 96,
                    ),
                    Center(
                      child: Text(
                        dic.encointer.thankYou,
                        style: Theme.of(context).textTheme.headline2.copyWith(color: ZurichLion.shade600),
                      ),
                    ),
                    Center(
                      child: Text(
                        dic.encointer.weHopeToSeeYouAtTheNextMeetup,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.arrow_right_2),
                    SizedBox(width: 12, height: 60),
                    Text(
                      dic.encointer.finish,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: PrimaryButton(
                  // todo: this will be removed because we do it automatically
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.login_1),
                      SizedBox(width: 6),
                      Text(
                          '${dic.encointer.claimsSubmitN.replaceAll('N_COUNT', store.encointer.communityAccount.scannedClaimsCount.toString())}'),
                    ],
                  ),
                  onPressed: () => submitAttestClaims(context, store),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
