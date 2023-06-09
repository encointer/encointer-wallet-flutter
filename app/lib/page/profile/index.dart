import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/common/components/launch/send_to_trello_list_tile.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/page/network_select_page.dart';
import 'package:encointer_wallet/page/profile/about_page.dart';
import 'package:encointer_wallet/page/profile/account/account_manage_page.dart';
import 'package:encointer_wallet/page/profile/account/change_password_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  EndpointData? _selectedNetwork;

  List<Widget> _buildAccountList() {
    final allAccountsAsWidgets = <Widget>[];

    final accounts = context.read<AppStore>().account.accountListAll;

    allAccountsAsWidgets.addAll(accounts.map((account) {
      return InkWell(
        key: Key(account.name),
        child: Column(
          children: [
            Stack(
              children: [
                AddressIcon(
                  '',
                  account.pubKey,
                  size: 70,
                  tapToCopy: false,
                ),
                const Positioned(
                  bottom: 0,
                  right: 0, //give the values according to your requirement
                  child: Icon(Iconsax.edit),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              Fmt.accountName(context, account),
              style: context.textTheme.headlineMedium,
            ),
            // This sizedBox is here to define a distance between the accounts
            const SizedBox(width: 100),
          ],
        ),
        onTap: () => {
          Navigator.pushNamed(context, AccountManagePage.route, arguments: account.pubKey),
        },
      );
    }).toList());
    return allAccountsAsWidgets;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h3Grey = context.textTheme.displaySmall!.copyWith(color: AppColors.encointerGrey);
    final store = context.watch<AppStore>();
    final appSettings = context.watch<AppSettings>();
    final appSettingsStore = context.watch<AppSettings>();
    _selectedNetwork = store.settings.endpoint;

    // if all accounts are deleted, go to createAccountPage
    if (store.account.accountListAll.isEmpty) {
      store.settings.setPin('');
      Future.delayed(Duration.zero, () {
        Navigator.pop(context);
      });
    }
    final dic = I18n.of(context)!.translationsForLocale();

    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.title),
        iconTheme: const IconThemeData(color: AppColors.encointerGrey), //change your color here,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Observer(
        builder: (_) {
          if (_selectedNetwork == null) return Container();
          return ListView(
            key: const Key('profile-list-view'),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      dic.profile.accounts,
                      style: context.textTheme.displayMedium!.copyWith(color: AppColors.encointerBlack),
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.add_square),
                      color: context.colorScheme.secondary,
                      onPressed: () => Navigator.of(context).pushNamed(AddAccountView.route),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 130,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        context.theme.scaffoldBackgroundColor.withOpacity(0),
                        context.theme.scaffoldBackgroundColor,
                        context.theme.scaffoldBackgroundColor,
                        context.theme.scaffoldBackgroundColor.withOpacity(0),
                      ],
                      stops: const [0.0, 0.1, 0.9, 1.0],
                    ).createShader(bounds);
                  },
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _buildAccountList(),
                  ),
                  // blendMode: BlendMode.dstATop,
                ),
              ),
              ListTile(
                title: Text(
                  dic.profile.changeYourPin,
                  style: context.textTheme.displaySmall,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.pushNamed(context, ChangePasswordPage.route),
              ),
              ListTile(
                key: const Key('remove-all-accounts'),
                title: Text(dic.profile.accountsDeleteAll, style: h3Grey),
                onTap: () => showRemoveAccountsDialog(context, store),
              ),
              ListTile(
                  title: Text(dic.profile.reputationOverall, style: h3Grey),
                  trailing: store.encointer.account?.reputations != null
                      ? Text(store.encointer.account?.reputations.length.toString() ?? 0.toString())
                      : Text(dic.encointer.fetchingReputations)),
              ListTile(
                title: Text(dic.profile.about, style: context.textTheme.displaySmall),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.pushNamed(context, AboutPage.route),
              ),
              ListTile(
                key: const Key('settings-language'),
                title: Text(dic.profile.settingLang, style: h3Grey),
                onTap: () => Navigator.pushNamed(context, LangPage.route),
              ),
              SwitchListTile(
                title: Text(dic.account.biometricAuth, style: h3Grey),
                onChanged: (value) async {
                  final appStore = context.read<AppStore>();
                  final appSettings = context.read<AppSettings>();
                  await AppAlert.showPasswordInputDialog(
                    context,
                    showCancelButton: true,
                    account: appStore.account.currentAccount,
                    onSuccess: (_) => appSettings.setIsBiometricAuthenticationEnabled(value),
                  );
                },
                value: appSettings.isBiometricAuthenticationEnabled,
              ),
              const SendToTrelloListTile(),
              ListTile(
                title: Text(dic.profile.developer, style: h3Grey),
                trailing: Checkbox(
                  key: const Key('dev-mode'),
                  value: appSettingsStore.developerMode,
                  onChanged: (v) => context.read<AppSettings>().toggleDeveloperMode(),
                ),
              ),
              if (appSettingsStore.developerMode)
                // Column in case we add more developer options
                Column(
                  children: <Widget>[
                    ListTile(
                      title: InkWell(
                        key: const Key('choose-network'),
                        child: Observer(
                          builder: (_) => Text(
                            'Change network (current: ${store.settings.endpoint.info})', // for devs only
                            style: context.textTheme.headlineMedium,
                          ),
                        ),
                        onTap: () => Navigator.of(context).pushNamed(NetworkSelectPage.route),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 13), // align with developer checkbox above
                        child: store.settings.isConnected
                            ? const Icon(Icons.check, color: Colors.green)
                            : const CupertinoActivityIndicator(),
                      ),
                    ),
                    ListTile(
                      title: Text(dic.profile.enableBazaar, style: h3Grey),
                      trailing: Checkbox(
                        value: store.settings.enableBazaar,
                        // Fixme: Need to change the tab to update the tabList. But, do we care? This is only
                        // temporary, and a developer option. It is unnecessary to include the complexity to update
                        // the parent widget from here.
                        onChanged: (_) => store.settings.toggleEnableBazaar(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SubmitButton(
                        key: const Key('next-phase-button'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.login_1),
                            SizedBox(width: 6),
                            Text('Next-Phase (only works for local dev-network)'),
                          ],
                        ),
                        onPressed: (_) async {
                          final res = await submitNextPhase(webApi);
                          RootSnackBar.showMsg(res.toString());
                        },
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

Future<void> showRemoveAccountsDialog(BuildContext context, AppStore store) {
  final dic = I18n.of(context)!.translationsForLocale();

  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(dic.profile.accountsDelete),
        actions: <Widget>[
          CupertinoButton(
            child: Text(dic.home.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoButton(
            key: const Key('remove-all-accounts-check'),
            child: Text(dic.home.ok),
            onPressed: () async {
              final accounts = store.account.accountListAll;

              for (final acc in accounts) {
                await store.account.removeAccount(acc);
              }

              await Navigator.pushNamedAndRemoveUntil(context, CreateAccountEntryView.route, (route) => false);
            },
          ),
        ],
      );
    },
  );
}
