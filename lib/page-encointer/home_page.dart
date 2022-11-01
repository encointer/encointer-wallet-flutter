import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaar_main.dart';
import 'package:encointer_wallet/page/assets/index.dart';
import 'package:encointer_wallet/page/profile/contacts/contacts_page.dart';
import 'package:encointer_wallet/page/profile/index.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_page.dart';
import 'package:encointer_wallet/service/background_service/background_service.dart';
import 'package:encointer_wallet/service/deep_link/deep_link.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/store/app.dart';

class EncointerHomePage extends StatefulWidget {
  const EncointerHomePage({Key? key}) : super(key: key);

  static const String route = '/home';

  @override
  State<EncointerHomePage> createState() => _EncointerHomePageState();
}

class _EncointerHomePageState extends State<EncointerHomePage> {
  final PageController _pageController = PageController();

  NotificationPlugin? _notificationPlugin;

  late List<TabData> _tabList;
  int _tabIndex = 0;

  @override
  void initState() {
    if (_notificationPlugin == null) {
      _notificationPlugin = NotificationPlugin();
      _notificationPlugin!.init(context);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initialDeepLinks(context);
      if (Platform.isAndroid) {
        // meetup notification only for android system
        Log.d('Initializing Workmanager callback...', 'home_page');
        await Workmanager().initialize(callbackDispatcher);
        await Workmanager().registerPeriodicTask(
          'background-service',
          'pull-notification',
          // Find a window where the app is in background because of #819.
          initialDelay: const Duration(hours: 8),
          frequency: const Duration(hours: 12),
          inputData: {'langCode': Localizations.localeOf(context).languageCode},
          existingWorkPolicy: ExistingWorkPolicy.replace,
        );
      }
    });
    super.initState();
  }

  List<BottomNavigationBarItem> _navBarItems(int activeItem) {
    return _tabList
        .map(
          (i) => BottomNavigationBarItem(
            icon: _tabList[activeItem] == i
                ? ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => primaryGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(
                        i.iconData,
                        key: Key(i.key.toString()),
                      ),
                      Container(
                        height: 4,
                        width: 16,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0),
                          ),
                        ),
                      )
                    ]),
                  )
                : Icon(
                    i.iconData,
                    key: Key(i.key.toString()),
                    color: i.key == TabKey.Scan ? ZurichLion.shade900 : encointerGrey,
                  ),
            label: '',
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final _store = context.watch<AppStore>();
    _tabList = <TabData>[
      TabData(
        TabKey.Wallet,
        Iconsax.home_2,
      ),
      if (context.select<AppStore, bool>((store) => store.settings.enableBazaar))
        TabData(
          TabKey.Bazaar,
          Iconsax.shop,
        ), // dart collection if
      TabData(
        TabKey.Scan,
        Iconsax.scan_barcode,
      ),
      TabData(
        TabKey.Contacts,
        Iconsax.profile_2user,
      ),
      TabData(
        TabKey.Profile,
        Iconsax.profile_circle,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Assets(_store),
          if (context.select<AppStore, bool>((store) => store.settings.enableBazaar)) BazaarMain(),
          ScanPage(),
          ContactsPage(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        iconSize: 22.0,
        onTap: (index) async {
          if (_tabList[index].key == TabKey.Scan) {
            // Push `ScanPage.Route`instead of changing the Page.
            Navigator.of(context).pushNamed(
              ScanPage.route,
              arguments: ScanPageParams(scannerContext: QrScannerContext.mainPage),
            );
          } else {
            setState(() {
              _tabIndex = index;
              _pageController.jumpToPage(index);
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        items: _navBarItems(_tabIndex),
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class TabData {
  /// used for our integration tests to click on a UI element
  final TabKey key;

  /// used for our integration tests to click on a UI element
  final IconData iconData;

  TabData(this.key, this.iconData);
}

enum TabKey {
  Wallet,
  Bazaar,
  Scan,
  Contacts,
  Profile,
}
