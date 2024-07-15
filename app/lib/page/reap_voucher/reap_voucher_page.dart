import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/secondary_button_wide.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/page/reap_voucher/dialogs.dart';
import 'package:encointer_wallet/page/reap_voucher/utils.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ReapVoucherParams {
  ReapVoucherParams({
    required this.voucher,
    this.showFundVoucher = false,
  });

  final VoucherData voucher;
  final bool showFundVoucher;
}

class ReapVoucherPage extends StatefulWidget {
  const ReapVoucherPage(this.api, this.voucher, this.showFundVoucher, {super.key});

  static const String route = '/qrcode/voucher';
  final Api api;

  final VoucherData voucher;
  final bool showFundVoucher;

  @override
  State<ReapVoucherPage> createState() => _ReapVoucherPageState();
}

class _ReapVoucherPageState extends State<ReapVoucherPage> {
  late KeyringAccount _voucherKeyringAccount;
  String? _voucherAddress;
  double? _voucherBalance;

  /// Is true when all the data has been fetched.
  bool _isReady = false;

  Future<void> fetchVoucherData(Api api, String voucherUri, CommunityIdentifier cid) async {
    Log.d('Fetching voucher data...', 'ReapVoucherPage');
    final store = context.read<AppStore>();

    _voucherKeyringAccount = await KeyringAccount.fromUri('Voucher', voucherUri);
    _voucherAddress = _voucherKeyringAccount.address(prefix: store.settings.endpoint.ss58()).encode();

    setState(() {});

    final voucherBalanceEntry = await api.encointer.getEncointerBalance(_voucherAddress!, cid);
    _voucherBalance = voucherBalanceEntry.applyDemurrage(
      store.chain.latestHeaderNumber!,
      store.encointer.community!.demurrage!,
    );

    _isReady = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final l10n = context.l10n;
        final voucher = widget.voucher;

        final result = await _changeNetworkAndCommunityIfNeeded(context, voucher.network, voucher.cid);

        if (result == ChangeResult.ok) {
          await fetchVoucherData(widget.api, voucher.voucherUri, voucher.cid);
        } else if (result == ChangeResult.invalidNetwork) {
          await showErrorDialog(context, l10n.invalidNetwork);
        } else if (result == ChangeResult.invalidCommunity) {
          await showErrorDialog(context, l10n.invalidCommunity);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.read<AppStore>();
    final h2Grey = context.titleLarge.copyWith(color: AppColors.encointerGrey);
    final h4Grey = context.bodyLarge.copyWith(color: AppColors.encointerGrey);

    final voucher = widget.voucher;
    final recipient = Address.decode(store.account.currentAddress);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.voucher)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            SizedBox(
              height: 96,
              child: _voucherAddress != null
                  ? AddressIcon(_voucherAddress!, _voucherAddress!)
                  : const CupertinoActivityIndicator(),
            ),
            const SizedBox(height: 8),
            Text(voucher.issuer, style: h2Grey),
            SizedBox(
              height: 80,
              child: _voucherBalance != null
                  ? TextGradient(
                      text: '${Fmt.doubleFormat(_voucherBalance)} ⵐ',
                      style: const TextStyle(fontSize: 60),
                    )
                  : const CupertinoActivityIndicator(),
            ),
            Text('${l10n.voucherBalance}, ${store.encointer.community?.symbol}', style: h4Grey),
            Expanded(
              // fit: FlexFit.tight,
              child: Center(
                child: Text(
                  l10n.doYouWantToRedeemThisVoucher(store.account.currentAccount.name),
                  style: h2Grey,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (widget.showFundVoucher)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SecondaryButtonWide(
                  key: const Key(EWTestKeys.voucherToTransferPage),
                  onPressed: _isReady ? () => _pushTransferPage(context, voucher, _voucherAddress!) : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.login_1),
                      const SizedBox(width: 6),
                      Text(l10n.fundVoucher),
                    ],
                  ),
                ),
              ),
            SubmitButton(
              key: const Key(EWTestKeys.submitVoucher),
              onPressed: _isReady
                  ? (context) => _submitReapVoucher(context, _voucherKeyringAccount, voucher.cid, recipient)
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.login_1),
                  const SizedBox(width: 6),
                  Text(l10n.redeemVoucher),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReapVoucher(
    BuildContext context,
    KeyringAccount voucherKeyringAccount,
    CommunityIdentifier cid,
    Address recipientAddress,
  ) async {
    // Fixme, use proper threshold here: #589
    if (_voucherBalance! < 0.04) return showRedeemFailedDialog(context, context.l10n.voucherBalanceTooLow);

    await submitEncointerTransferAll(
      context, context.read<AppStore>(), widget.api, voucherKeyringAccount, recipientAddress, cid,
      // the voucher obviously has tokens in cid.
      txPaymentAsset: cid,
      onError: (report) async {
        Log.d('Error redeeming voucher: ${report.toJson()}', 'ReapVoucherPage');
        await showRedeemFailedDialog(context, report.toJson().toString());
      },
      onFinish: (context, report) async {
        await VoucherDialogs.showRedeemSuccessDialog(
          context: context,
          onOK: () => Navigator.of(context).popUntil((route) => route.isFirst),
        );
      },
    );
  }

  Future<ChangeResult?> _changeNetworkAndCommunityIfNeeded(
    BuildContext context,
    String networkInfo,
    CommunityIdentifier cid,
  ) async {
    final store = context.read<AppStore>();

    if (store.settings.endpoint.id() != networkInfo) {
      return showChangeNetworkAndCommunityDialog(
        context,
        store,
        widget.api,
        networkInfo,
        cid,
      );
    }

    if (store.encointer.chosenCid != cid) {
      return showChangeCommunityDialog(
        context,
        store,
        widget.api,
        networkInfo,
        cid,
      );
    }

    // We are already at the correct network and cid
    return ChangeResult.ok;
  }
}

void _pushTransferPage(BuildContext context, VoucherData data, String voucherAddress) {
  Navigator.of(context).popAndPushNamed(
    TransferPage.route,
    arguments: TransferPageParams(
      cid: data.cid,
      recipientAddress: voucherAddress,
      label: data.issuer,
    ),
  );
}
