import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:encointer_wallet/common/components/jump_to_browser_link.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class AboutPage extends StatelessWidget {
  static const String route = '/profile/about';

  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text(dic.profile.about),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(48),
              child: Image.asset('assets/images/public/logo_about.png'),
            ),
            Text(
              dic.profile.aboutBrief,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 8),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (_, AsyncSnapshot<PackageInfo> snapshot) {
                Log.d('$snapshot', 'AboutPage');
                if (snapshot.hasData) {
                  return Text('${dic.profile.aboutVersion}: v${snapshot.data!.version}+${snapshot.data!.buildNumber}');
                } else {
                  return const CupertinoActivityIndicator();
                }
              },
            ),
            const SizedBox(height: 16),
            JumpToBrowserLink('https://encointer.org'),
          ],
        ),
      ),
    );
  }
}
