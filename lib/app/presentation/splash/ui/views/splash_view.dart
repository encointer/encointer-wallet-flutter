import 'package:encointer_wallet/app/presentation/home/ui/views/home_view.dart';
import 'package:encointer_wallet/app/presentation/splash/store/splash_view_store.dart';
import 'package:encointer_wallet/design_kit/colors/app_colors_config.dart';
import 'package:encointer_wallet/design_kit/images/app_assets_svg.dart';
import 'package:encointer_wallet/page/account/create_account_entry_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _tag = 'splash_view';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const route = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashViewStore store = SplashViewStore(sl.get<AppStore>());

  Future<void> _initPage() async {
    Log.d('_initPage', _tag);
    await store.init(context);

    ///account.setFetchAccountData(fetchAccountData);
    if (store.appStore.account.accountListAll.isNotEmpty) {
      await Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute<void>(builder: (context) => const HomeView()), (route) => false);
    } else {
      await Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute<void>(builder: (context) => const CreateAccountEntryPage()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('splashview'),
      body: FutureBuilder(
        future: _initPage(),
        builder: (context, s) {
          return Stack(
            children: [
              AppAssetsSvg.nctrMosaicBackground(
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                child: AppAssetsSvg.nctrLogo(
                  color: appColors.white,
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
