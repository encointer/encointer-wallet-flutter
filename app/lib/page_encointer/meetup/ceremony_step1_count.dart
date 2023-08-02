import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/page_encointer/meetup/ceremony_progress_bar.dart';
import 'package:encointer_wallet/page_encointer/meetup/ceremony_step2_scan2.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class CeremonyStep1Count extends StatelessWidget {
  CeremonyStep1Count(this.store, this.api, {super.key});

  final AppStore store;
  final Api api;

  final TextEditingController _attendeesCountController = TextEditingController();

  Future<void> _pushStep2ScanPage(BuildContext context, int count) async {
    store.encointer.communityAccount!.setParticipantCountVote(count);
    await Navigator.of(context).push(
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
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.keySigningCycle),
        leading: Container(),
        actions: [
          IconButton(
            key: const Key(EWTestKeys.closeEncointerCeremonyStep1),
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
                        l10n.count,
                        style: context.titleLarge.copyWith(color: context.colorScheme.primary),
                      ),
                    ),
                    Center(
                      child: Text(
                        l10n.howManyParticipantsShowedUp,
                        textAlign: TextAlign.center,
                        style: context.titleLarge.copyWith(height: 2),
                      ),
                    ),
                    const SizedBox(height: 48),
                    EncointerTextFormField(
                      labelText: l10n.numberOfAttendees,
                      textStyle: context.displayLarge.copyWith(color: AppColors.encointerBlack),
                      controller: _attendeesCountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textFormFieldKey: const Key(EWTestKeys.attendeesCount),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                key: const Key(EWTestKeys.ceremonyStep1Next),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.arrow_right_2),
                    const SizedBox(width: 12),
                    Text(l10n.next),
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
