import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaar_main.dart';
import 'package:encointer_wallet/page/profile/contacts/contacts_page.dart';
import 'package:encointer_wallet/page/profile/index.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_page.dart';
import 'package:encointer_wallet/presentation/assets/ui/views/assets_view.dart';
import 'package:encointer_wallet/presentation/home/store/home_view_store.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/extras/utils/encointer_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

const _tag = 'home_view';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String route = '/home-view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with EncointerStateMixin {
  final PageController _pageController = PageController();

  late final HomeViewStore _store = HomeViewStore();

  late List<TabData> _tabList;
  int _tabIndex = 0;

  @override
  void initState() {
    Log.d('initState', _tag);
    if (buildConfig != BuildConfig.integrationTestRealApp) {
      NotificationPlugin.init(context);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Log.d('initState.WidgetsBinding.instance.addPostFrameCallback', _tag);
      await _store.init(context);
    });

    _getTabLists(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          const AssetsView(),
          if (_store.appStore.settings.enableBazaar) ...[
            const BazaarMain(),
          ],
          ScanPage(),
          const ContactsPage(),
          const Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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

  void _getTabLists(BuildContext context) {
    _tabList = <TabData>[
      TabData(
        TabKey.wallet,
        Iconsax.home_2,
      ),
      if (_store.appStore.settings.enableBazaar) ...[
        TabData(
          TabKey.bazaar,
          Iconsax.shop,
        ),
      ],
      // dart collection if
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
                            bottom: BorderSide(width: 2),
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
