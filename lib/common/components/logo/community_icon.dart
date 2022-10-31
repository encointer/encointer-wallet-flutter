import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/store/app.dart';

class CommunityIconObserver extends StatelessWidget {
  const CommunityIconObserver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    return Observer(
      builder: (_) {
        if (store.communityIcon != null) {
          return SvgPicture.string(store.communityIcon!);
        } else {
          return FutureBuilder<String?>(
            // future: store.getCommunityIcon(),
            future: context.read<AppStore>().getCommunityIcon(),
            builder: (_, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoActivityIndicator();
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return SvgPicture.string(snapshot.data!);
                } else {
                  return SvgPicture.asset(fall_back_community_icon);
                }
              } else {
                return SvgPicture.asset(fall_back_community_icon);
              }
            },
          );
        }
      },
    );
  }
}
