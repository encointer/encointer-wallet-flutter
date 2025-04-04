import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/common/components/logo/participant_avatar.dart';
import 'package:encointer_wallet/store/connectivity/connectivity_store.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_panel.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_progress_bar.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:provider/provider.dart';

class CeremonyStep3Finish extends StatelessWidget {
  const CeremonyStep3Finish(this.store, this.api, {super.key});

  final AppStore store;
  final Api api;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connectivityStore = context.watch<ConnectivityStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(l10n.keySigningCycle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const CeremonyProgressBar(progress: 3),
                    const SizedBox(height: 48),
                    CommunityAvatar(
                      store.encointer.communityIconOrDefault,
                      avatarSize: 96,
                    ),
                    Center(
                      child: Text(
                        l10n.thankYou,
                        style: context.titleLarge,
                      ),
                    ),
                    Center(
                      child: Text(
                        l10n.weHopeToSeeYouAtTheNextGathering,
                        textAlign: TextAlign.center,
                        style: context.headlineSmall.copyWith(color: AppColors.encointerBlack, height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        store.encointer.communityAccount!.meetup!.registry.length,
                        (index) {
                          if (store.encointer.communityAccount!.attendees!
                              .contains(store.encointer.communityAccount!.meetup!.registry[index])) {
                            return ParticipantAvatar(index: index, isActive: true);
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Observer(builder: (_) {
                  if (connectivityStore.isConnectedToNetwork) {
                    return SubmitButton(
                      // todo: this will be removed because we do it automatically
                      key: const Key(EWTestKeys.submitClaims),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.login_1),
                          const SizedBox(width: 6),
                          Text(l10n.claimsSubmitN(store.encointer.communityAccount!.scannedAttendeesCount)),
                        ],
                      ),
                      onPressed: (context) => submitAttestAttendees(
                        context,
                        store,
                        api,
                        store.account.getKeyringAccount(store.account.currentAccountPubKey!),
                        store.encointer.chosenCid!,
                        txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
                        onError: (dispatchError) {
                          final message = getLocalizedTxErrorMessage(l10n, dispatchError);
                          showTxErrorDialog(context, message, false);
                        },
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        ElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Iconsax.arrow_right_2),
                              const SizedBox(width: 12, height: 60),
                              Text(
                                l10n.finish,
                                style: context.bodySmall,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.offlineMessage,
                          style: context.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }
                }),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
