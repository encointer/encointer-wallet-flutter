import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return CircleAvatar(
      backgroundColor: Theme.of(context).backgroundColor,
      child: Observer(
        builder: (_) {
          if (store.encointer.community != null && store.encointer.community!.name != null) {
            if (store.encointer.community!.communityIcon != null) {
              return SvgPicture.string(store.encointer.community!.communityIcon!);
            } else {
              return FutureBuilder<String?>(
                future: context.read<AppStore>().encointer.community!.getCommunityIcon(),
                builder: (_, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                    return SvgPicture.string(snapshot.data!);
                  } else {
                    return SvgPicture.asset(fallBackCommunityIcon);
                  }
                },
              );
            }
          } else {
            return const CupertinoActivityIndicator();
          }
        },
      ),
    );
  }
}
