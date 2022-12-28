import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/secondary_button_wide.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/common/theme.dart';
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
import 'package:encointer_wallet/utils/translations/index.dart';

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

    final voucherBalanceEntry = await api.encointer.getEncointerBalance(_voucherAddress!, cid);
    if (context.read<AppStore>().chain.latestHeaderNumber != null) {
      _voucherBalance = voucherBalanceEntry.applyDemurrage(
        context.read<AppStore>().chain.latestHeaderNumber!,
        context.read<AppStore>().encointer.community!.demurrage!,
      );
    }

    _isReady = true;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final store = context.watch<AppStore>();
    final h2Grey = Theme.of(context).textTheme.headline2!.copyWith(color: encointerGrey);
    final h4Grey = Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey);
    final params = ModalRoute.of(context)!.settings.arguments! as ReapVoucherParams;

    final voucher = params.voucher;
    final voucherUri = voucher.voucherUri;
    final cid = voucher.cid;
    final networkInfo = voucher.network;
    final issuer = voucher.issuer;
    final recipient = store.account.currentAddress;
    final showFundVoucher = params.showFundVoucher;

    if (!_postFrameCallbackCalled) {
      _postFrameCallbackCalled = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          final result = await _changeNetworkAndCommunityIfNeeded(context, networkInfo, cid);

          if (result == ChangeResult.ok) {
            fetchVoucherData(widget.api, voucherUri, cid);
          } else if (result == ChangeResult.invalidNetwork) {
            await showErrorDialog(context, dic.assets.invalidNetwork);
          } else if (result == ChangeResult.invalidCommunity) {
            await showErrorDialog(context, dic.assets.invalidCommunity);
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(dic.assets.voucher)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            SizedBox(
              height: 96,
              child: _voucherAddress != null
                  ? AddressIcon(_voucherAddress!, _voucherAddress!, size: 96)
                  : const CupertinoActivityIndicator(),
            ),
            const SizedBox(height: 8),
            Text(issuer, style: h2Grey),
            SizedBox(
              height: 80,
              child: _voucherBalance != null
                  ? TextGradient(
                      text: '${Fmt.doubleFormat(_voucherBalance)} ⵐ',
                      style: const TextStyle(fontSize: 60),
                    )
                  : const CupertinoActivityIndicator(),
            ),
            Text('${dic.assets.voucherBalance}, ${store.encointer.community?.symbol}', style: h4Grey),
            Expanded(
              // fit: FlexFit.tight,
              child: Center(
                child: Text(
                  dic.assets.doYouWantToRedeemThisVoucher.replaceAll(
                    'ACCOUNT_PLACEHOLDER',
                    store.account.currentAccount.name,
                  ),
                  style: h2Grey,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (showFundVoucher)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SecondaryButtonWide(
                  onPressed: _isReady ? () => _pushTransferPage(context, voucher, _voucherAddress!) : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.login_1),
                      const SizedBox(width: 6),
                      Text(dic.assets.fundVoucher),
                    ],
                  ),
                ),
              ),
            SubmitButton(
              onPressed: _isReady ? (context) => _submitReapVoucher(context, voucherUri, cid, recipient) : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.login_1),
                  const SizedBox(width: 6),
                  Text(dic.assets.redeemVoucher),
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
      showRedeemFailedDialog(context, res['error'] as String?);
    } else {
      showRedeemSuccessDialog(context);
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
      recipient: voucherAddress,
      label: data.issuer,
    ),
  );
}
