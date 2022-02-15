import 'package:encointer_wallet/common/components/encointerTextFormField.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class ReceivePage extends StatefulWidget {
  ReceivePage(this.store);
  static final String route = '/assets/receive';
  final AppStore store;
  @override
  _ReceivePageState createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  final TextEditingController _amountController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool generateQR = false;
  var invoice = [];

  @override
  Widget build(BuildContext context) {
    // final Map args = ModalRoute.of(context).settings.arguments;
    //
    // String codeAddress =
    //     'substrate:${widget.store.account.currentAddress}:${widget.store.account.currentAccount.pubKey}:${widget.store.account.currentAccount.name}';

    // Map<String, String> invoiceMap = {
    //   'header': 'encointer-contact',
    //   'versrion': 'V1.0',
    //   'community': '',
    //   'accountAddress': '${widget.store.account.currentAccount.address}',
    //   'amount': (0.0).toString(),
    //   'name': '${widget.store.account.currentAccount.name}'
    // };

    Widget generateQRforValueGreaterZero() {
      print("latest value ${_amountController.text}");
      if (_amountController.text != null &&
          _amountController.text.isNotEmpty &&
          double.parse(_amountController.text) != 0.0) {
        return Container(
          child:
              // NOT WORKING YET, should probably add observer
              QrImage(
            data: invoice.join('\n'),
            embeddedImage: AssetImage('assets/images/public/app.png'),
            embeddedImageStyle: QrEmbeddedImageStyle(size: Size(40, 40)),
          ),
        );
      } else
        return Container();
    }

    // @override
    // void initState() {
    //   super.initState();
    //   // Start listening to changes.
    //   _amountController.addListener(generateQRforValueGreaterZero);
    // }

    // @override
    // void dispose() {
    //   // Clean up the controller when the widget is removed from the
    //   // widget tree.
    //   _amountController.dispose();
    //   super.dispose();
    // }

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(I18n.of(context).translationsForLocale().assets.receive),
          leading: Container(),
          actions: [
            IconButton(
              key: Key('close-receive-page'),
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                      I18n.of(context).translationsForLocale().profile.qrScanHint,
                      style: Theme.of(context).textTheme.headline3.copyWith(color: encointerBlack),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: EncointerTextFormField(
                      labelText: I18n.of(context).translationsForLocale().assets.invoiceAmount,
                      textStyle: Theme.of(context).textTheme.headline2.copyWith(color: encointerBlack),
                      inputFormatters: [UI.decimalInputFormatter()],
                      controller: _amountController,
                      textFormFieldKey: Key('invoice-amount-input'),
                      validator: (String value) {
                        print("value is ${double.parse(value)}");
                        if (value == null || value.isEmpty || double.parse(value) == 0.0) {
                          return I18n.of(context).translationsForLocale().assets.amountError;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          invoice = [
                            'encointer-contact',
                            'V1.0',
                            widget.store.encointer.chosenCid != null
                                ? (widget.store.encointer.chosenCid).toFmtString()
                                : '',
                            widget.store.account.currentAccount.address,
                            _amountController.text,
                            widget.store.account.currentAccount.name
                          ];
                        });
                      },
                      suffixIcon: Text(
                        "ⵐ",
                        style: TextStyle(
                          color: encointerGrey,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                  '${I18n.of(context).translationsForLocale().profile.receiverAccount} ${widget.store.account.currentAccount.name}',
                  style: Theme.of(context).textTheme.headline3.copyWith(color: encointerGrey),
                  textAlign: TextAlign.center),
              SizedBox(height: 8),
              Column(children: [
                generateQRforValueGreaterZero(),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: ZurichLion.shade500),
                          SizedBox(width: 8),
                          Text(
                            I18n.of(context).translationsForLocale().assets.shareQrCode,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ]),
                  ),
                  onTap: () => {
                    if (_formKey.currentState.validate())
                      {
                        print("amount ${_amountController.text} is stored"),
                        invoice[4] = _amountController.text,
                        print("the final share message is: ${invoice.join('\n')}"),
                        // not working yet with map..
                        // invoiceMap['amount'] = '${_amountController.text}',
                        // how to define type?
                        // var invoiceString = '',
                        // invoiceMap.values.map((e) => invoiceString.join(e.toString(),'\n')),
                        Share.share(invoice.join('\n')),
                      }
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
