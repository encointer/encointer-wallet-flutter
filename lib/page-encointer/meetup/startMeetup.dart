import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/material.dart';

import 'confirmAttendeesDialog.dart';
import 'qrCode.dart';

Future<void> startMeetup(BuildContext context, AppStore store) async {
  var amount = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmAttendeesDialog()));
  var claim = await webApi.encointer.signClaimOfAttendance(amount, store.account.cachedPin);
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => ClaimQrCode(
        store,
        title: 'My Claim of Attendance',
        claim: claim,
      ),
    ),
  );
}