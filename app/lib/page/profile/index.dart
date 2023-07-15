import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/common/components/launch/send_to_trello_list_tile.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config/biometiric_auth_state.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page/network_select_page.dart';
import 'package:encointer_wallet/page/profile/about_page.dart';
import 'package:encointer_wallet/page/profile/account/account_manage_page.dart';
import 'package:encointer_wallet/page/profile/account/change_password_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    final loginStore = context.watch<LoginStore>();
    final appSettingsStore = context.watch<AppSettings>();
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.title),
        iconTheme: const IconThemeData(color: AppColors.encointerGrey), //change your color here,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Observer(
        builder: (_) {
          return ListView(
            key: const Key(EWTestKeys.profileListView),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      l10n.accounts,
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
                ),
              ),
              ListTile(
                title: Text(
                  l10n.changeYourPin,
                  style: context.textTheme.displaySmall,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.pushNamed(context, ChangePasswordPage.route),
              ),
              ListTile(
                key: const Key(EWTestKeys.removeAllAccounts),
                title: Text(l10n.accountsDeleteAll, style: h3Grey),
                onTap: () {
                  LoginDialog.verifyPinOrBioAuth(
                    context,
                    titleText: l10n.accountsDelete,
                    onSuccess: (v) async {
                      for (final acc in context.read<AppStore>().account.accountListAll) {
                        await store.account.removeAccount(acc);
                      }
                      await context.read<LoginStore>().clearPin();
                      context.read<AppStore>().settings.cachedPin = '';
                      await Navigator.pushNamedAndRemoveUntil(context, CreateAccountEntryView.route, (route) => false);
                    },
                  );
                },
              ),
              ListTile(
                  title: Text(l10n.reputationOverall, style: h3Grey),
                  trailing: store.encointer.account?.reputations != null
                      ? Text(store.encointer.account?.reputations.length.toString() ?? 0.toString())
                      : Text(l10n.fetchingReputations)),
              ListTile(
                title: Text(l10n.about, style: context.textTheme.displaySmall),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.pushNamed(context, AboutPage.route),
              ),
              ListTile(
                key: const Key(EWTestKeys.settingsLanguage),
                title: Text(l10n.settingLang, style: h3Grey),
                onTap: () => Navigator.pushNamed(context, LangPage.route),
              ),
              Observer(builder: (_) {
                return switch (loginStore.getBiometricAuthState) {
                  BiometricAuthState.deviceNotSupported => const SizedBox.shrink(),
                  _ => SwitchListTile(
                      title: Text(l10n.biometricAuth, style: h3Grey),
                      onChanged: (value) => LoginDialog.switchBiometricAuth(context, isEnable: value),
                      value: loginStore.biometricAuthState == BiometricAuthState.enabled,
                    ),
                };
              }),
              const SendToTrelloListTile(),
              ListTile(
                title: Text(l10n.developer, style: h3Grey),
                trailing: Checkbox(
                  key: const Key(EWTestKeys.devMode),
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
                        key: const Key(EWTestKeys.chooseNetwork),
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
                      title: Text(l10n.enableBazaar, style: h3Grey),
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
                        key: const Key(EWTestKeys.nextPhaseButton),
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
