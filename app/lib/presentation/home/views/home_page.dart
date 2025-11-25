import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/presentation/home/service/home_page_service.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page/page.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/page-encointer/bazaar/bazaar_main.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/logic/businesses_store.dart';

class EncointerHomePage extends StatefulWidget {
  const EncointerHomePage({super.key});

  static const String route = '/home';

  @override
  State<EncointerHomePage> createState() => _EncointerHomePageState();
}

class _EncointerHomePageState extends State<EncointerHomePage> {
  final PageController _pageController = PageController();

  late final HomePageService _service;

  late List<TabData> _tabList;
  int _tabIndex = 0;

  @override
  void initState() {
    _service = HomePageService(context.read<AppStore>(), context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _service.postFrameCallbacks();
      final loginStore = context.read<LoginStore>();
      if (loginStore.getBiometricAuthState == null) {
        await LoginDialog.showToggleBiometricAuthAlert(context);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getTabList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          AssetsView(_service.appStore),
          Provider(
            create: (context) => BusinessesStore(),
            child: const BazaarPage(),
          ),

          /// empty widget here because when qr code is clicked, we navigate to [ScanPage]
          const SizedBox(),
          const ContactsPage(),
          const Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: const Key(EWTestKeys.bottomNav),
        currentIndex: _tabIndex,
        iconSize: 22,
        onTap: (index) async {
          if (_tabList[index].key == TabKey.scan) {
            // Push `ScanPage.Route`instead of changing the Page.
            await Navigator.of(context).pushNamed(
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

  void _getTabList() {
    _tabList = <TabData>[
      TabData(
        TabKey.wallet,
        Iconsax.home_2,
      ),
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
  }

  List<BottomNavigationBarItem> _navBarItems(int activeItem) {
    return _tabList
        .map(
          (tabData) => BottomNavigationBarItem(
            icon: _tabList[activeItem] == tabData
                ? ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => AppColors.primaryGradient(context).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(
                        tabData.iconData,
                        key: Key(tabData.key.name),
                      ),
                      Container(
                        height: 4,
                        width: 16,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2),
                          ),
                        ),
                      )
                    ]),
                  )
                : Icon(
                    tabData.iconData,
                    key: Key(tabData.key.name),
                    color: tabData.key == TabKey.scan ? context.colorScheme.onSurface : AppColors.encointerGrey,
                  ),
            label: '',
          ),
        )
        .toList();
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
