import 'package:encointer_wallet/app/presentation/splash/store/splash_view_store.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/page/account/create_account_entry_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const route = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final String mosaicBackground = 'assets/nctr_mosaic_background.svg';
  final String nctrLogo = 'assets/nctr_logo.svg';

  Future<void> _initPage() async {
    final store = context.watch<SplashViewStore>();
    await store.init(context, sysLocaleCode: Localizations.localeOf(context).toString());

    if (store.appStore.account.accountListAll.isNotEmpty) {
      await Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute<void>(builder: (context) => const EncointerHomePage()), (route) => false);
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
