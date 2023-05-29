import 'package:ew_http/ew_http.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaar_main.dart';
import 'package:encointer_wallet/page/assets/index.dart';
import 'package:encointer_wallet/page/profile/contacts/contacts_page.dart';
import 'package:encointer_wallet/page/profile/index.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_page.dart';
import 'package:encointer_wallet/service/deep_link/deep_link.dart';
import 'package:encointer_wallet/service/meetup/meetup.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

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
    if (!RepositoryProvider.of<AppConfig>(context).isIntegrationTest) NotificationPlugin.init(context);
    final encointer = context.read<AppStore>().encointer;
    final cid = encointer.community?.cid.toFmtString();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initialDeepLinks(context);
      await NotificationHandler.fetchMessagesAndScheduleNotifications(
        tz.local,
        NotificationPlugin.scheduleNotification,
        langCode: Localizations.localeOf(context).languageCode,
        cid: cid,
        ewHttp: RepositoryProvider.of<EwHttp>(context),
      );

      // Should never be null, we either come from the splash screen, and hence we had
      // enough time to connect to the blockchain or we already have a populated store.
      //
      // Hence, can only be null if someone uses the app for the first time and is offline.
      if (encointer.nextRegisteringPhaseStart != null &&
          encointer.currentCeremonyIndex != null &&
          encointer.ceremonyCycleDuration != null) {
        await CeremonyNotifications.scheduleRegisteringStartsReminders(
          encointer.nextRegisteringPhaseStart!,
          encointer.currentCeremonyIndex!,
          encointer.ceremonyCycleDuration!,
          I18n.of(context)!.translationsForLocale().encointer,
          cid: cid,
        );

        await CeremonyNotifications.scheduleLastDayOfRegisteringReminders(
          encointer.assigningPhaseStart!,
          encointer.currentCeremonyIndex!,
          encointer.ceremonyCycleDuration!,
          I18n.of(context)!.translationsForLocale().encointer,
          cid: cid,
        );
      }
    });
    super.initState();
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
          AssetsView(store),
          if (context.select<AppStore, bool>((store) => store.settings.enableBazaar)) const BazaarMain(),

          /// empty widget here because when qr code is clicked, we navigate to [ScanPage]
          const SizedBox(),
          const ContactsPage(),
          const Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: const Key('bottom-nav'),
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
