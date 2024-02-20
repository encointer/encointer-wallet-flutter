import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_store.dart';

class CommunityIconObserver extends StatelessWidget {
  const CommunityIconObserver(this.communityStore, {super.key, double? radius}) : radius = radius ?? 10;

  final CommunityStore communityStore;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorScheme.background,
      radius: radius,
      child: Observer(
        builder: (_) {
          if (communityStore.communityIcon != null) {
            return SvgPicture.string(communityStore.communityIcon!);
          } else {
            return SvgPicture.asset(fallBackCommunityIcon);
          }
        },
      ),
    );
  }
}
