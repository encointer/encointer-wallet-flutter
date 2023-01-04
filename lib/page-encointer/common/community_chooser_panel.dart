import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/logo/community_icon.dart';
import 'package:encointer_wallet/common/components/rounded_card.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CommunityChooserPanel extends StatefulWidget {
  const CommunityChooserPanel(this.store, {super.key});

  final AppStore store;

  @override
  State<CommunityChooserPanel> createState() => _CommunityChooserPanelState();
}

class _CommunityChooserPanelState extends State<CommunityChooserPanel> {
  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return SizedBox(
      width: double.infinity,
      child: RoundedCard(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            Text(dic.assets.communityChoose),
            Observer(
              builder: (_) => (widget.store.encointer.communities == null)
                  ? const CupertinoActivityIndicator()
                  : (widget.store.encointer.communities!.isEmpty)
                      ? Text(dic.assets.communitiesNotFound)
                      : DropdownButton<CidName>(
                          key: const Key('cid-dropdown'),
                          // todo find out, why adding the hint breaks the integration test walkthrough when choosing community #225
                          // hint: Text(dic.assets.communityChoose),
                          value: (widget.store.encointer.chosenCid == null ||
                                  widget.store.encointer.communities!
                                      .where((cn) => cn.cid == widget.store.encointer.chosenCid)
                                      .isEmpty)
                              ? null
                              : widget.store.encointer.communities!
                                  .where((cn) => cn.cid == widget.store.encointer.chosenCid)
                                  .first,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 32,
                          elevation: 32,
                          onChanged: (newValue) async {
                            await widget.store.encointer.setChosenCid(newValue?.cid);
                            setState(() {});
                          },
                          items: widget.store.encointer.communities!
                              .asMap()
                              .entries
                              .map((entry) => DropdownMenuItem<CidName>(
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
  const CombinedCommunityAndAccountAvatar(
    this.store, {
    super.key,
    this.showCommunityNameAndAccountName = true,
    this.communityAvatarSize = 96,
    this.accountAvatarSize = 34,
  });

  final AppStore store;
  final double communityAvatarSize;
  final double accountAvatarSize;

  final bool showCommunityNameAndAccountName;

  @override
  State<CombinedCommunityAndAccountAvatar> createState() => _CombinedCommunityAndAccountAvatarState();
}

class _CombinedCommunityAndAccountAvatarState extends State<CombinedCommunityAndAccountAvatar> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    child: CommunityAvatar(avatarSize: widget.communityAvatarSize),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: AddressIcon(
                      '',
                      widget.store.account.currentAccount.pubKey,
                      size: widget.accountAvatarSize,
                      tapToCopy: false,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              if (widget.showCommunityNameAndAccountName)
                Text(
                  '${widget.store.encointer.community?.name ?? "..."}\n${Fmt.accountName(context, widget.store.account.currentAccount)}',
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
  const CommunityAvatar({super.key, this.avatarSize = 120});

  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: const CommunityIconObserver(),
    );
  }
}
