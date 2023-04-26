import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/utils/mixins/post_frame_mixin.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/material.dart';

class FaqWidget extends StatefulWidget {
  const FaqWidget({Key? key}) : super(key: key);
  static const String route = '/profile/faq';

  @override
  _FaqWidgetState createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> with PostFrameMixin {
  late Translations _dic;

  @override
  void didChangeDependencies() {
    _dic = I18n.of(context)!.translationsForLocale();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_dic.profile.faqLong),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 24),
          ListTile(
            title: Text(_dic.profile.backUpAndRestoreYourAccount, style: Theme.of(context).textTheme.titleSmall),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _launchWeb(AppUrls.backUpAndRestoreYourAccount),
          ),
          ListTile(
            title: Text(_dic.profile.inviteEndorseYourAccounts, style: Theme.of(context).textTheme.titleSmall),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _launchWeb(AppUrls.inviteEndorseYourAccounts),
          ),
          ListTile(
            title: Text(_dic.profile.ceremonyInstructions, style: Theme.of(context).textTheme.titleSmall),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _launchWeb(AppUrls.ceremonyInstructions),
          ),
          ListTile(
            title: Text(_dic.profile.completingAttestation, style: Theme.of(context).textTheme.titleSmall),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _launchWeb(AppUrls.completingAttestation),
          ),
        ],
      ),
    );
  }

  Future<void> _launchWeb(String url) async {
    await AppLaunch.launchURL(url);
  }
}
