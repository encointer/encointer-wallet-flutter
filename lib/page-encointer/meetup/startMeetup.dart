import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremonyStep1Count.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/codecApi.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ceremonyStep2Scan2.dart';

Future<void> startMeetup(BuildContext context, AppStore store) async {
  var count = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CeremonyStep1Count()));
  // count is `null` if back button pressed in `ConfirmAttendeesDialog`

  if (store.settings.cachedPin.isEmpty) {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        final Translations dic = I18n.of(context).translationsForLocale();
        return showPasswordInputDialog(
            context,
            store.account.currentAccount,
            Text(dic.home.unlockAccount
                .replaceAll('CURRENT_ACCOUNT_NAME', store.account.currentAccount.name.toString())), (password) {
          store.settings.setPin(password);
        });
      },
    );
  }

  if (count != null && store.settings.cachedPin.isNotEmpty) {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => CeremonyStep2Scan(
          store,
          claim: webApi.encointer
              .signClaimOfAttendance(count, store.settings.cachedPin)
              .then((claim) => webApi.codec.encodeToBytes(ClaimOfAttendanceJSRegistryName, claim)),
          confirmedParticipantsCount: count,
        ),
      ),
    );
  }
}
