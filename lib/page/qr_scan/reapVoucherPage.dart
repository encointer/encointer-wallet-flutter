import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/common/theme.dart';

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
  BalanceEntry _voucherBalance;

  Future<void> fetchVoucherData(Api api, String voucherUri, CommunityIdentifier cid) async {
    _voucherAddress = await api.account.addressFromUri(voucherUri);

    setState(() {});

    _voucherBalance = await api.encointer.getEncointerBalance(_voucherAddress, cid);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    final h2Grey = Theme.of(context).textTheme.headline2.copyWith(color: encointerGrey);

    ReapVoucherParams params = ModalRoute.of(context).settings.arguments;

    final voucherUri = params.voucher.voucherUri;
    final cid = params.voucher.cid;

    if (_voucherAddress == null) {
      fetchVoucherData(widget.api, voucherUri, cid);
    }

    return Scaffold(
      appBar: AppBar(title: Text(dic.assets.voucher)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            _voucherAddress != null
                ? AddressIconWithLabel(_voucherAddress, _voucherAddress, size: 96)
                : SizedBox(
                    width: 96,
                    height: 96,
                    child: CupertinoActivityIndicator(),
                  ),
            _voucherBalance != null
                ? TextGradient(
                    text: '${Fmt.doubleFormat(_voucherBalance.applyDemurrage(
                      widget.store.chain.latestHeaderNumber,
                      // Todo: handle case when the scanned voucher is not of the current community
                      widget.store.encointer.community.demurrage,
                    ))} ⵐ',
                    style: TextStyle(fontSize: 30),
                  )
                : CupertinoActivityIndicator(),
            Text(
              "${dic.assets.voucherBalance}, ${widget.store.encointer.community?.symbol}",
              style: Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(dic.assets.doYouWantToRedeemThisVoucher, style: h2Grey),
            ),
            PrimaryButton(
              key: Key('transfer-done'),
              child: Container(
                height: 24,
                child: Text(dic.assets.done),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context, CommunityIdentifier cid, String recipientAddress, double amount) async {
    var params = encointerBalanceTransferParams(cid, recipientAddress, amount);

    // await submitTx(context, widget.store, widget.api, params, onFinish: onFinish);

    // for debugging
    // Future.delayed(const Duration(milliseconds: 1500), () {
    //   setState(() {
    //     _transferState = TransferState.finished;
    //   });
    // });

    // _log("TransferState after callback: ${_transferState.toString()}");

    // trigger rebuild after state update in callback
    setState(() {});
  }
}

void _log(String msg) {
  print("[VoucherPage] $msg");
}
