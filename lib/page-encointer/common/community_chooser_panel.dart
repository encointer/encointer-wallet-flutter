import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/rounded_card.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunityChooserPanel extends StatefulWidget {
  CommunityChooserPanel(this.store, {Key? key}) : super(key: key);

  final AppStore store;

  @override
  State<CommunityChooserPanel> createState() => _CommunityChooserPanelState(store);
}

class _CommunityChooserPanelState extends State<CommunityChooserPanel> {
  _CommunityChooserPanelState(this.store);

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    return SizedBox(
      width: double.infinity,
      child: RoundedCard(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            Text(dic.assets.communityChoose),
            Observer(
              builder: (_) => (store.encointer.communities == null)
                  ? const CupertinoActivityIndicator()
                  : (store.encointer.communities!.isEmpty)
                      ? Text(dic.assets.communitiesNotFound)
                      : DropdownButton<dynamic>(
                          key: const Key('cid-dropdown'),
                          // todo find out, why adding the hint breaks the integration test walkthrough when choosing community #225
                          // hint: Text(dic.assets.communityChoose),
                          value: (store.encointer.chosenCid == null ||
                                  store.encointer.communities!
                                      .where((cn) => cn.cid == store.encointer.chosenCid)
                                      .isEmpty)
                              ? null
                              : store.encointer.communities!.where((cn) => cn.cid == store.encointer.chosenCid).first,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 32,
                          elevation: 32,
                          onChanged: (newValue) async {
                            await store.encointer.setChosenCid(newValue.cid);
                            setState(() {});
                          },
                          items: store.encointer.communities!
                              .asMap()
                              .entries
                              .map((entry) => DropdownMenuItem<dynamic>(
                                    key: Key('cid-${entry.key}'),
                                    value: entry.value,
                                    child: Text(entry.value.name),
                                  ))
                              .toList(),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

/// the CombinedCommunityAndAccountAvatar should be wrapped in an InkWell to provide the callback on a click
class CombinedCommunityAndAccountAvatar extends StatefulWidget {
  const CombinedCommunityAndAccountAvatar(this.store,
      {Key? key,
      this.showCommunityNameAndAccountName = true,
      this.communityAvatarSize = 96,
      this.accountAvatarSize = 34})
      : super(key: key);

  final AppStore store;
  final double communityAvatarSize;
  final double accountAvatarSize;

  final bool showCommunityNameAndAccountName;

  @override
  State<CombinedCommunityAndAccountAvatar> createState() => _CombinedCommunityAndAccountAvatarState(store);
}

class _CombinedCommunityAndAccountAvatarState extends State<CombinedCommunityAndAccountAvatar> {
  final AppStore store;

  _CombinedCommunityAndAccountAvatarState(this.store);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Observer(
          builder: (_) => Column(
            children: [
              Stack(
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.communityAvatarSize),
                    ),
                    child: CommunityAvatar(
                      store: store,
                      avatarIcon: webApi.ipfs.getCommunityIcon(store.encointer.community?.assetsCid),
                      avatarSize: widget.communityAvatarSize,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: AddressIcon(
                      '',
                      store.account.currentAccount.pubKey,
                      size: widget.accountAvatarSize,
                      tapToCopy: false,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              if (widget.showCommunityNameAndAccountName)
                Text(
                  '${store.encointer.community?.name ?? "..."}\n${Fmt.accountName(context, store.account.currentAccount)}',
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey, height: 1.5),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class CommunityAvatar extends StatelessWidget {
  const CommunityAvatar({
    Key? key,
    required this.store,
    required this.avatarIcon,
    this.avatarSize = 120,
  }) : super(key: key);

  final AppStore store;
  final double avatarSize;
  final Future<SvgPicture> avatarIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: FutureBuilder<SvgPicture>(
        future: avatarIcon,
        builder: (_, AsyncSnapshot<SvgPicture> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const CupertinoActivityIndicator();
          }
        },
      ),
    );
  }
}
