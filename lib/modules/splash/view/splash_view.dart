import 'package:encointer_wallet/mocks/substrate_api/core/mock_dart_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/page/account/create_account_entry_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const route = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final String mosaicBackground = 'assets/nctr_mosaic_background.svg';
  final String nctrLogo = 'assets/nctr_logo.svg';

  Future<void> _initPage() async {
    final store = context.watch<AppStore>();
    await store.init(Localizations.localeOf(context).toString());

    final js = await DefaultAssetBundle.of(context).loadString('lib/js_service_encointer/dist/main.js');
    webApi = store.config.isNormal()
        ? Api.create(context.read<AppStore>(), JSApi(), SubstrateDartApi(), js)
        : MockApi(context.read<AppStore>(), MockJSApi(), MockSubstrateDartApi(), js, withUi: true);

    await webApi.init().timeout(
          const Duration(seconds: 20),
          onTimeout: () => Log.d('webApi.init() has run into a timeout. We might be offline.'),
        );

    // must be set after api is initialized.
    if (store.config.isNormal()) {
      store.dataUpdate.setupUpdateReaction(() async {
        await store.encointer.updateState();
      });
    }

    store.setApiReady(true);

    if (store.account.accountListAll.length > 0) {
      await Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute(builder: (context) => EncointerHomePage()), (route) => false);
    } else {
      await Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute(builder: (context) => CreateAccountEntryPage()), (route) => false);
    }
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

Future<Api> initWebApi(BuildContext context) async {
  final js = await DefaultAssetBundle.of(context).loadString('lib/js_service_encointer/dist/main.js');

  return (context.read<AppStore>().config == StoreConfig.Test
      ? MockApi(context.read<AppStore>(), MockJSApi(), MockSubstrateDartApi(), js, withUi: true)
      : Api.create(context.read<AppStore>(), JSApi(), SubstrateDartApi(), js))
    ..init().timeout(
      const Duration(seconds: 20),
      onTimeout: () => Log.d('webApi.init() has run into a timeout. We might be offline.'),
    );
}
