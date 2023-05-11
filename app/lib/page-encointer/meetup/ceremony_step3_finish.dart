import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

import 'package:encointer_wallet/common/components/logo/participant_avatar.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_panel.dart';
import 'package:encointer_wallet/page-encointer/meetup/ceremony_progress_bar.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CeremonyStep3Finish extends StatelessWidget {
  const CeremonyStep3Finish(this.store, this.api, {super.key});

  final AppStore store;
  final Api api;

  Future<bool> checkInternetConnection() async {
    try {
      final response = await http.head(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(dic.encointer.keySigningCycle),
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
                    const CommunityAvatar(avatarSize: 96),
                    Center(
                      child: Text(
                        dic.encointer.thankYou,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: zurichLion.shade600),
                      ),
                    ),
                    Center(
                      child: Text(
                        dic.encointer.weHopeToSeeYouAtTheNextGathering,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.black, height: 1.5),
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
              FutureBuilder<bool>(
                  future: checkInternetConnection(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: SubmitButton(
                          // todo: this will be removed because we do it automatically
                          key: const Key('submit-claims'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Iconsax.login_1),
                              const SizedBox(width: 6),
                              Text(
                                dic.encointer.claimsSubmitN.replaceAll(
                                  'N_COUNT',
                                  store.encointer.communityAccount!.scannedAttendeesCount.toString(),
                                ),
                              ),
                            ],
                          ),
                          onPressed: (context) => submitAttestClaims(context, store, api),
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
                                  dic.encointer.finish,
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'You are currently offline. Your claims can be submitted later, on the Home Screen',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                  }),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
