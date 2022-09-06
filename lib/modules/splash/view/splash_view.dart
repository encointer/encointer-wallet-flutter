import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/mocks/substrate_api/core/mock_dart_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/page/account/create_account_entry_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/app.dart';

class SplashView extends StatefulWidget {
  const SplashView(this.testMode, this.changeLang, {Key? key}) : super(key: key);
  final bool testMode;
  final Function(BuildContext context, String code) changeLang;

  static const route = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final String mosaicBackground = 'assets/nctr_mosaic_background.svg';
  final String nctrLogo = 'assets/nctr_logo.svg';

  void navigate() {
    if (context.read<AppStore>().account.accountListAll.length > 0) {
      Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute(builder: (context) => EncointerHomePage()), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute(builder: (context) => CreateAccountEntryPage()), (route) => false);
    }
  }

  Future<int> _initPage() async {
    final _store = context.watch<AppStore>();

    await _store.init(Localizations.localeOf(context).toString());

    final js = await DefaultAssetBundle.of(context).loadString('lib/js_service_encointer/dist/main.js');

    webApi = widget.testMode
        ? MockApi(context.read<AppStore>(), MockJSApi(), MockSubstrateDartApi(), js, withUi: true)
        : Api.create(context.read<AppStore>(), JSApi(), SubstrateDartApi(), js);

    await webApi.init().timeout(
          const Duration(seconds: 20),
          onTimeout: () => print('webApi.init() has run into a timeout. We might be offline.'),
        );
        
    _store.dataUpdate.setupUpdateReaction(() async {
      await _store.encointer.updateState();
    });

    widget.changeLang(context, _store.settings.localeCode);

    _store.setApiReady(true);
    navigate();
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initPage(),
        builder: (context, s) {
          return Stack(
            children: [
              SvgPicture.asset(
                mosaicBackground,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                child: SvgPicture.asset(
                  nctrLogo,
                  color: Colors.white,
                  width: 210,
                  height: 210,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
