import 'dart:ui';

import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/components/secondaryButtonWide.dart';
import 'package:encointer_wallet/common/components/submitButton.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'dialogs.dart';
import 'utils.dart';

class ReapVoucherParams {
  ReapVoucherParams({
    this.voucher,
    this.showFundVoucher = false,
  });

  final VoucherData voucher;
  final bool showFundVoucher;
}

class ReapVoucherPage extends StatefulWidget {
  const ReapVoucherPage(this.store, this.api);

  static const String route = '/qrcode/voucher';
  final AppStore store;
  final Api api;

  @override
  _ReapVoucherPageState createState() => _ReapVoucherPageState();
}

class _ReapVoucherPageState extends State<ReapVoucherPage> {
  String _voucherAddress;
  double _voucherBalance;

  bool _postFrameCallbackCalled = false;

  /// Is true when all the data has been fetched.
  bool _isReady = false;

  Future<void> fetchVoucherData(Api api, String voucherUri, CommunityIdentifier cid) async {
    _log("Fetching voucher data...");
    _voucherAddress = await api.account.addressFromUri(voucherUri);

    setState(() {});

    var voucherBalanceEntry = await api.encointer.getEncointerBalance(_voucherAddress, cid);
    _voucherBalance = voucherBalanceEntry.applyDemurrage(
      widget.store.chain.latestHeaderNumber,
      widget.store.encointer.community.demurrage,
    );

    _isReady = true;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    final h2Grey = Theme.of(context).textTheme.headline2.copyWith(color: encointerGrey);
    final h4Grey = Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey);
    ReapVoucherParams params = ModalRoute.of(context).settings.arguments;

    final voucher = params.voucher;
    final voucherUri = voucher.voucherUri;
    final cid = voucher.cid;
    final networkInfo = voucher.network;
    final issuer = voucher.issuer;
    final recipient = widget.store.account.currentAddress;
    final showFundVoucher = params.showFundVoucher;

    if (!_postFrameCallbackCalled) {
      _postFrameCallbackCalled = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          var result = await _changeNetworkAndCommunityIfNeeded(context, networkInfo, cid);

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
                  ? AddressIcon(_voucherAddress, _voucherAddress, size: 96)
                  : CupertinoActivityIndicator(),
            ),
            SizedBox(height: 8),
            Text(issuer, style: h2Grey),
            SizedBox(
              height: 80,
              child: _voucherBalance != null
                  ? TextGradient(
                      text: '${Fmt.doubleFormat(_voucherBalance)} ⵐ',
                      style: TextStyle(fontSize: 60),
                    )
                  : CupertinoActivityIndicator(),
            ),
            Text(
              "${dic.assets.voucherBalance}, ${widget.store.encointer.community?.symbol}",
              style: h4Grey,
            ),
            Expanded(
              // fit: FlexFit.tight,
              child: Center(
                child: Text(
                  dic.assets.doYouWantToRedeemThisVoucher,
                  style: h2Grey,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (showFundVoucher)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SecondaryButtonWide(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.login_1),
                      SizedBox(width: 6),
                      Text(dic.assets.fundVoucher),
                    ],
                  ),
                  onPressed: _isReady ? () => _pushTransferPage(context, voucher, _voucherAddress) : null,
                ),
              ),
            SubmitButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.login_1),
                  SizedBox(width: 6),
                  Text(dic.assets.redeemVoucher),
                ],
              ),
              onPressed: _isReady ? (context) => _submitReapVoucher(context, voucherUri, cid, recipient) : null,
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
    var res = await submitReapVoucher(widget.api, voucherUri, recipientAddress, cid);

    if (res['hash'] == null) {
      _log('Error redeeming voucher: ${res['error']}');
      showRedeemFailedDialog(context, res['error']);
    } else {
      showRedeemSuccessDialog(context);
    }
  }

  Future<ChangeResult> _changeNetworkAndCommunityIfNeeded(
    BuildContext context,
    String networkInfo,
    CommunityIdentifier cid,
  ) async {
    var result = ChangeResult.ok;

    if (widget.store.settings.endpoint.info != networkInfo) {
      result = await showChangeNetworkAndCommunityDialog(
        context,
        widget.store,
        widget.api,
        networkInfo,
        cid,
      );
    }

    if (result != ChangeResult.ok) {
      return result;
    }

    if (widget.store.encointer.chosenCid != cid) {
      result = await showChangeCommunityDialog(
        context,
        widget.store,
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
      redirect: ReapVoucherPage.route,
    ),
  );
}

void _log(String msg) {
  print("[ReapVoucherPage] $msg");
}
