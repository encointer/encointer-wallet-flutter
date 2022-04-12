import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/roundedCard.dart';
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
  CommunityChooserPanel(this.store);

  final AppStore store;

  @override
  _CommunityChooserPanelState createState() => _CommunityChooserPanelState(store);
}

class _CommunityChooserPanelState extends State<CommunityChooserPanel> {
  _CommunityChooserPanelState(this.store);

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    return Container(
      width: double.infinity,
      child: RoundedCard(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            Text(dic.assets.communityChoose),
            Observer(
              builder: (_) => (store.encointer.communities == null)
                  ? CupertinoActivityIndicator()
                  : (store.encointer.communities.isEmpty)
                      ? Text(dic.assets.communitiesNotFound)
                      : DropdownButton<dynamic>(
                          key: Key('cid-dropdown'),
                          // todo find out, why adding the hint breaks the integration test walkthrough when choosing community #225
                          // hint: Text(dic.assets.communityChoose),
                          value: (store.encointer.chosenCid == null ||
                                  store.encointer.communities
                                      .where((cn) => cn.cid == store.encointer.chosenCid)
                                      .isEmpty)
                              ? null
                              : store.encointer.communities.where((cn) => cn.cid == store.encointer.chosenCid).first,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 32,
                          elevation: 32,
                          onChanged: (newValue) {
                            setState(() {
                              store.encointer.setChosenCid(newValue.cid);
                            });
                          },
                          items: store.encointer.communities
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
      {Key key,
      this.showCommunityNameAndAccountName = true,
      this.communityAvatarSize = 96,
      this.accountAvatarSize = 34})
      : super(key: key);

  final AppStore store;
  final double communityAvatarSize;
  final double accountAvatarSize;

  final bool showCommunityNameAndAccountName;

  @override
  _CombinedCommunityAndAccountAvatarState createState() => _CombinedCommunityAndAccountAvatarState(store);
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 2, 2),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widget.communityAvatarSize),
                      ),
                      child: CommunityAvatar(
                        store: store,
                        avatarIcon: webApi.ipfs.getCommunityIcon(store.encointer.communityIconsCid),
                        avatarSize: widget.communityAvatarSize,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: AddressIcon(
                      '',
                      size: widget.accountAvatarSize,
                      pubKey: store.account.currentAccount.pubKey,
                      tapToCopy: false,
                    ),
                  )
                ],
              ),
              SizedBox(height: 4),
              if (widget.showCommunityNameAndAccountName)
                Text(
                  '${store.encointer.communityName}\n${Fmt.accountName(context, store.account.currentAccount)}',
                  style: Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey, height: 1.5),
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
    Key key,
    @required this.store,
    @required this.avatarIcon,
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
            return snapshot.data;
          } else {
            return CupertinoActivityIndicator();
          }
        },
      ),
    );
  }
}
