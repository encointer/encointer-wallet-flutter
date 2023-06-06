import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/store/app.dart';

class CommunityIconObserver extends StatelessWidget {
  const CommunityIconObserver({super.key, double? radius}) : radius = radius ?? 10;

  final double radius;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    return CircleAvatar(
      backgroundColor: context.colorScheme.background,
      radius: radius,
      child: Observer(
        builder: (_) {
          if (store.encointer.community != null && store.encointer.community!.assetsCid != null) {
            if (store.encointer.community!.communityIcon != null) {
              return SvgPicture.string(store.encointer.community!.communityIcon!);
            } else {
              return SvgPicture.asset(fallBackCommunityIcon);
            }
          } else {
            return const CupertinoActivityIndicator();
          }
        },
      ),
    );
  }
}
