import 'dart:ui';

import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/components/submitButton.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/config/consts.dart';
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

import 'qrCodes.dart';

class ReapVoucherParams {
  ReapVoucherParams({this.voucher});

  final VoucherData voucher;
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

  Future<void> fetchVoucherData(Api api, String voucherUri, CommunityIdentifier cid) async {
    _log("Fetching voucher data...");
    _voucherAddress = await api.account.addressFromUri(voucherUri);

    setState(() {});

    var voucherBalanceEntry = await api.encointer.getEncointerBalance(_voucherAddress, cid);
    _voucherBalance = voucherBalanceEntry.applyDemurrage(
      widget.store.chain.latestHeaderNumber,
      widget.store.encointer.community.demurrage,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    final h2Grey = Theme.of(context).textTheme.headline2.copyWith(color: encointerGrey);
    final h4Grey = Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey);
    ReapVoucherParams params = ModalRoute.of(context).settings.arguments;

    final voucherUri = params.voucher.voucherUri;
    final cid = params.voucher.cid;
    final networkInfo = params.voucher.network;
    final issuer = params.voucher.issuer;
    final recipient = widget.store.account.currentAddress;

    if (!_postFrameCallbackCalled) {
      _postFrameCallbackCalled = true;
      WidgetsBinding.instance.addPostFrameCallback(
            (_) async {
          if (widget.store.settings.endpoint.info != networkInfo) {
            await _changeNetworkAndCommunity(context, networkInfo, cid);
          }
          if (_voucherAddress == null) {
            fetchVoucherData(widget.api, voucherUri, cid);
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
            SubmitButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.login_1),
                  SizedBox(width: 6),
                  Text(dic.assets.redeemVoucher),
                ],
              ),
              onPressed: (context) => _submitReapVoucher(context, voucherUri, cid, recipient),
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

  Future<void> _changeNetworkAndCommunity(BuildContext context, String networkInfo, CommunityIdentifier cid) async {
    var network;

    try {
      network = networkEndpoints.firstWhere(
        (network) {
          _log("Network info: ${network.info}");
          return network.info == networkInfo;
        },
        orElse: () => throw FormatException('Invalid network in QrCode: $networkInfo'),
      );
    } catch (e) {
      showRedeemFailedDialog(context, e.toString());
      return Future.value(null);
    }

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context).translationsForLocale().home.loading),
          content: Container(height: 64, child: CupertinoActivityIndicator()),
        );
      },
    );

    await widget.store.settings.reloadNetwork(network);

    widget.store.encointer.setChosenCid(cid);

    // pop the loading dialog
    Navigator.of(context).pop();

    setState(() {});
  }
}

Future<void> showRedeemSuccessDialog(BuildContext context) {
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return redeemSuccessDialog(context);
    },
  );
}

Widget redeemSuccessDialog(BuildContext context) {
  final dic = I18n.of(context).translationsForLocale();

  return CupertinoAlertDialog(
    title: Container(),
    content: Text(dic.assets.redeemSuccess),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.home.ok),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
      ),
    ],
  );
}

Future<void> showRedeemFailedDialog(BuildContext context, String error) {
  return showCupertinoDialog(
    context: context,
    builder: (_) {
      return redeemFailedDialog(context, error);
    },
  );
}

Widget redeemFailedDialog(BuildContext context, String error) {
  final dic = I18n.of(context).translationsForLocale();

  return CupertinoAlertDialog(
    title: Container(),
    content: Text("${dic.assets.redeemFailure} $error"),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.home.ok),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
      ),
    ],
  );
}

Widget changeNetworkDialog(BuildContext context, Function onChangeConfirm) {
  final dic = I18n.of(context).translationsForLocale();

  return CupertinoAlertDialog(
    title: Text(I18n.of(context).translationsForLocale().home.exitConfirm),
    content: Text("Different network. You can change the network again under Profile > Developper mode"),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.home.cancel),
        onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
      ),
      CupertinoButton(
        child: Text(dic.home.ok),
        onPressed: onChangeConfirm,
      ),
    ],
  );
}

void _log(String msg) {
  print("[VoucherPage] $msg");
}
