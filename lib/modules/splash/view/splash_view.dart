import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/page/account/create_account_entry_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initPage();
    });
  }

  Future<void> _initPage() async {
    await context.read<AppStore>().init(Localizations.localeOf(context).toString());
    await context.read<Api>().init().timeout(
          const Duration(seconds: 20),
          onTimeout: () => Log.p("webApi.init() has run into a timeout. We might be offline.", 'lib/app.dart'),
        );

    webApi = context.read<Api>();
    // Log.p('Initializing app state', 'lib/app.dart');
    // Log.p('sys locale: ${Localizations.localeOf(context)}', 'lib/app.dart');
    context.read<AppStore>().dataUpdate.setupUpdateReaction(() async {
      await context.read<AppStore>().encointer.updateState();
    });
    context.read<AppStore>().setApiReady(true);
    final v = context.read<AppStore>().account.accountListAll.length;
    Log.p('$v', 'splash');
    if (v > 0) {
      Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute(builder: (context) => EncointerHomePage()), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute(builder: (context) => CreateAccountEntryPage()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(radius: 30, color: ZurichLion),
      ),
    );
  }
}
