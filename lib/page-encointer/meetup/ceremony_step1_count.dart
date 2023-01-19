import 'package:ew_translations/translation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_progress_bar.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_step2_scan2.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';

class CeremonyStep1Count extends StatelessWidget {
  CeremonyStep1Count(this.store, this.api, {super.key});

  final AppStore store;
  final Api api;

  final TextEditingController _attendeesCountController = TextEditingController();

  Future<void> _pushStep2ScanPage(BuildContext context, int count) async {
    store.encointer.communityAccount!.setParticipantCountVote(count);
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => CeremonyStep2Scan(
          store,
          api,
          claimantAddress: store.account.currentAddress,
          confirmedParticipantsCount: count,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(dic.encointer.keySigningCycle),
        leading: Container(),
        actions: [
          IconButton(
            key: const Key('close-encointer-ceremony-step1'),
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const CeremonyProgressBar(progress: 1),
                    const SizedBox(height: 48),
                    Center(
                      child: Text(
                        dic.encointer.count,
                        style: Theme.of(context).textTheme.headline2!.copyWith(color: zurichLion.shade600),
                      ),
                    ),
                    Center(
                      child: Text(
                        dic.encointer.howManyParticipantsShowedUp,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black, height: 2),
                      ),
                    ),
                    const SizedBox(height: 48),
                    EncointerTextFormField(
                      labelText: dic.encointer.numberOfAttendees,
                      textStyle: Theme.of(context).textTheme.headline1!.copyWith(color: encointerBlack),
                      controller: _attendeesCountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textFormFieldKey: const Key('attendees-count'),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                key: const Key('ceremony-step-1-next'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.arrow_right_2),
                    const SizedBox(width: 12),
                    Text(
                      dic.encointer.next,
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: zurichLion.shade50),
                    ),
                  ],
                ),
                onPressed: () => _attendeesCountController.text.trim().isNotEmpty
                    ? _pushStep2ScanPage(context, int.parse(_attendeesCountController.text.trim()))
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
