import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/logo/community_icon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:encointer_wallet/extras/utils/format.dart';

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
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: encointerGrey, height: 1.5),
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
