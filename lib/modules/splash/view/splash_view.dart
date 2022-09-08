import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/page/account/create_account_entry_page.dart';
import 'package:encointer_wallet/store/app.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const route = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final String mosaicBackground = 'assets/nctr_mosaic_background.svg';
  final String nctrLogo = 'assets/nctr_logo.svg';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initPage();
    });
  }

  Future<void> _initPage() async {
    await context.read<AppStore>().init(Localizations.localeOf(context).toString());
    context.read<AppStore>().setApiReady(true);

    await context.read<AppStore>().dataUpdate.setupUpdateReaction(() async {
      if (mounted) await context.read<AppStore>().encointer.updateState();
    });

    if (context.read<AppStore>().account.accountListAll.length > 0) {
      Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute(builder: (context) => EncointerHomePage()), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute(builder: (context) => CreateAccountEntryPage()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
      ),
    );
  }
}
