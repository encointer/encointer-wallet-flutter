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
import 'package:encointer_wallet/modules/login/logic/login_store.dart';
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
  const ReapVoucherPage(this.api, {super.key});

  static const String route = '/qrcode/voucher';
  final Api api;

  @override
  State<ReapVoucherPage> createState() => _ReapVoucherPageState();
}

class _ReapVoucherPageState extends State<ReapVoucherPage> {
  String? _voucherAddress;
  double? _voucherBalance;

  bool _postFrameCallbackCalled = false;

  /// Is true when all the data has been fetched.
  bool _isReady = false;

  Future<void> fetchVoucherData(Api api, String voucherUri, CommunityIdentifier cid) async {
    Log.d('Fetching voucher data...', 'ReapVoucherPage');

    _voucherAddress = await api.account.addressFromUri(voucherUri);

    setState(() {});

    final pin = await context.read<LoginStore>().getPin(context);
    if (pin != null) {
      final voucherBalanceEntry = await api.encointer.getEncointerBalance(_voucherAddress!, cid, pin);
      if (context.read<AppStore>().chain.latestHeaderNumber != null) {
        _voucherBalance = voucherBalanceEntry.applyDemurrage(
          context.read<AppStore>().chain.latestHeaderNumber!,
          context.read<AppStore>().encointer.community!.demurrage!,
        );
      }

      _isReady = true;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.watch<AppStore>();
    final h2Grey = context.titleLarge.copyWith(color: AppColors.encointerGrey);
    final h4Grey = context.bodyLarge.copyWith(color: AppColors.encointerGrey);
    final params = ModalRoute.of(context)?.settings.arguments as ReapVoucherParams?;

    final voucher = params?.voucher;
    final voucherUri = voucher?.voucherUri;
    final cid = voucher?.cid;
    final networkInfo = voucher?.network;
    final issuer = voucher?.issuer;
    final recipient = store.account.currentAddress;
    final showFundVoucher = params?.showFundVoucher;

    if (!_postFrameCallbackCalled) {
      _postFrameCallbackCalled = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          final result = cid != null ? await _changeNetworkAndCommunityIfNeeded(context, networkInfo!, cid) : null;

          if (result == ChangeResult.ok && cid != null) {
            await fetchVoucherData(widget.api, voucherUri!, cid);
          } else if (result == ChangeResult.invalidNetwork) {
            await showErrorDialog(context, l10n.invalidNetwork);
          } else if (result == ChangeResult.invalidCommunity) {
            await showErrorDialog(context, l10n.invalidCommunity);
          }
        },
      );
    }

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
            Text(issuer ?? '', style: h2Grey),
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
            if (showFundVoucher ?? false)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SecondaryButtonWide(
                  key: const Key(EWTestKeys.voucherToTransferPage),
                  onPressed: _isReady ? () => _pushTransferPage(context, voucher!, _voucherAddress!) : null,
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
              onPressed: _isReady ? (context) => _submitReapVoucher(context, voucherUri!, cid!, recipient) : null,
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
    String voucherUri,
    CommunityIdentifier cid,
    String recipientAddress,
  ) async {
    final res = await submitReapVoucher(widget.api, voucherUri, recipientAddress, cid);

    if (res['hash'] == null) {
      Log.d('Error redeeming voucher: ${res['error']}', 'ReapVoucherPage');
      await showRedeemFailedDialog(context, res['error'] as String?);
    } else {
      await VoucherDialogs.showRedeemSuccessDialog(
        context: context,
        onOK: () => Navigator.of(context).popUntil((route) => route.isFirst),
      );
    }
  }

  Future<ChangeResult?> _changeNetworkAndCommunityIfNeeded(
    BuildContext context,
    String networkInfo,
    CommunityIdentifier cid,
  ) async {
    ChangeResult? result = ChangeResult.ok;
    final store = context.read<AppStore>();

    if (store.settings.endpoint.info != networkInfo) {
      result = await showChangeNetworkAndCommunityDialog(
        context,
        store,
        widget.api,
        networkInfo,
        cid,
      );
    }

    if (result != ChangeResult.ok) {
      return result;
    }

    if (store.encointer.chosenCid != cid) {
      result = await showChangeCommunityDialog(
        context,
        store,
        widget.api,
        networkInfo,
        cid,
      );
    }

    return result;
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
