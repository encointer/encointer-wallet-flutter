import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:encointer_wallet/common/components/jump_to_browser_link.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String route = '/profile/about';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.about),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(48),
              child: Assets.images.public.logoAbout.image(),
            ),
            Text(
              l10n.aboutBrief,
              style: context.headlineSmall,
            ),
            const SizedBox(height: 8),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (_, AsyncSnapshot<PackageInfo> snapshot) {
                Log.d('$snapshot', 'AboutPage');
                if (snapshot.hasData) {
                  return Text('${l10n.aboutVersion}: v${snapshot.data!.version}+${snapshot.data!.buildNumber}');
                } else {
                  return const CupertinoActivityIndicator();
                }
              },
            ),
            const SizedBox(height: 16),
            const JumpToBrowserLink('https://encointer.org'),
          ],
        ),
      ),
    );
  }
}
