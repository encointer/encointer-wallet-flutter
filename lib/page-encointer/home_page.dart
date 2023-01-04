import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaar_main.dart';
import 'package:encointer_wallet/page/assets/index.dart';
import 'package:encointer_wallet/page/profile/contacts/contacts_page.dart';
import 'package:encointer_wallet/page/profile/index.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_page.dart';
import 'package:encointer_wallet/service/deep_link/deep_link.dart';
import 'package:encointer_wallet/service/meetup/meetup.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/store/app.dart';

class EncointerHomePage extends StatefulWidget {
  const EncointerHomePage({super.key});

  static const String route = '/home';

  @override
  State<EncointerHomePage> createState() => _EncointerHomePageState();
}

class _EncointerHomePageState extends State<EncointerHomePage> {
  final PageController _pageController = PageController();

  late List<TabData> _tabList;
  int _tabIndex = 0;

  @override
  void initState() {
    if (context.read<AppStore>().appCast == null) NotificationPlugin.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initialDeepLinks(context);
      await NotificationHandler.fetchMessagesAndScheduleNotifications(
        tz.local,
        NotificationPlugin.scheduleNotification,
        Localizations.localeOf(context).languageCode,
      );
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
                        key: Key(i.key.name),
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
                    key: Key(i.key.name),
                    color: i.key == TabKey.scan ? zurichLion.shade900 : encointerGrey,
                  ),
            label: '',
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    _tabList = <TabData>[
      TabData(
        TabKey.wallet,
        Iconsax.home_2,
      ),
      if (context.select<AppStore, bool>((store) => store.settings.enableBazaar))
        TabData(
          TabKey.bazaar,
          Iconsax.shop,
        ), // dart collection if
      TabData(
        TabKey.scan,
        Iconsax.scan_barcode,
      ),
      TabData(
        TabKey.contacts,
        Iconsax.profile_2user,
      ),
      TabData(
        TabKey.profile,
        Iconsax.profile_circle,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Assets(store),
          if (context.select<AppStore, bool>((store) => store.settings.enableBazaar)) const BazaarMain(),
          ScanPage(),
          const ContactsPage(),
          const Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        iconSize: 22.0,
        onTap: (index) async {
          if (_tabList[index].key == TabKey.scan) {
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
  TabData(this.key, this.iconData);

  /// used for our integration tests to click on a UI element
  final TabKey key;

  /// used for our integration tests to click on a UI element
  final IconData iconData;
}

enum TabKey {
  wallet,
  bazaar,
  scan,
  contacts,
  profile,
}
