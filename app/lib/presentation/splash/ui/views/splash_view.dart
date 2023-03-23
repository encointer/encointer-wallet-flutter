import 'package:encointer_wallet/common/components/logo/encointer_logo.dart';
import 'package:encointer_wallet/presentation/account/ui/views/create_account_entry_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/gen/assets.gen.dart';

import 'package:encointer_wallet/presentation/home/ui/views/home_view.dart';
import 'package:encointer_wallet/presentation/splash/store/splash_view_store.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

const _tag = 'splash_view';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const route = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashViewStore store = SplashViewStore();

  Future<void> _initPage() async {
    Log.d('_initPage', _tag);
    await store.init(context);

    ///account.setFetchAccountData(fetchAccountData);
    if (store.appStore.account.accountListAll.isNotEmpty) {
      await Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute<void>(builder: (context) => const HomeView()), (route) => false);
    } else {
      await Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute<void>(builder: (context) => const CreateAccountEntryView()), (route) => false);
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
              Assets.images.assets.mosaicBackground.image(
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
              ),
              const Center(
                child: EncointerLogo(),
              ),
            ],
          );
        },
      ),
    );
  }
}
