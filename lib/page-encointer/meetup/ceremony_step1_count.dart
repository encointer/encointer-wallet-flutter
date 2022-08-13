import 'package:encointer_wallet/common/components/encointerTextFormField.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_step2_scan2.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/codecApi.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'ceremony_progress_bar.dart';

class CeremonyStep1Count extends StatelessWidget {
  CeremonyStep1Count(
    this.store,
    this.api, {
    Key? key,
  }) : super(key: key);

  final AppStore store;
  final Api api;

  final TextEditingController _attendeesCountController =
      TextEditingController();

  Future<void> _pushStep2ScanPage(BuildContext context, int count) async {
    if (store.settings.cachedPin.isEmpty) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          final Translations dic = I18n.of(context)!.translationsForLocale();
          return showPasswordInputDialog(
              context,
              store.account.currentAccount,
              Text(dic.home.unlockAccount.replaceAll('CURRENT_ACCOUNT_NAME',
                  store.account.currentAccount.name.toString())), (password) {
            store.settings.setPin(password);
          });
        },
      );
    }

    if (store.settings.cachedPin.isNotEmpty) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (BuildContext context) => CeremonyStep2Scan(
            store,
            api,
            claim: webApi.encointer
                .signClaimOfAttendance(count, store.settings.cachedPin)
                .then((claim) => webApi.codec
                    .encodeToBytes(ClaimOfAttendanceJSRegistryName, claim)),
            confirmedParticipantsCount: count,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(dic.encointer.encointerCeremony),
        leading: Container(),
        actions: [
          IconButton(
            key: Key('close-encointer-ceremony-step1'),
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 24, 30, 24),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CeremonyProgressBar(progress: 1),
                    SizedBox(height: 48),
                    Center(
                      child: Text(
                        dic.encointer.count,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: ZurichLion.shade600),
                      ),
                    ),
                    Center(
                      child: Text(
                        dic.encointer.howManyParticipantsShowedUp,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.black, height: 2),
                      ),
                    ),
                    SizedBox(height: 48),
                    EncointerTextFormField(
                      labelText: dic.encointer.numberOfAttendees,
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: encointerBlack),
                      controller: _attendeesCountController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textFormFieldKey: Key('attendees-count'),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                key: Key('ceremony-step-1-next'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.arrow_right_2),
                    SizedBox(width: 12),
                    Text(
                      dic.encointer.next,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: ZurichLion.shade50),
                    ),
                  ],
                ),
                onPressed: () =>
                    _attendeesCountController.text.trim().isNotEmpty
                        ? _pushStep2ScanPage(context,
                            int.parse(_attendeesCountController.text.trim()))
                        : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
