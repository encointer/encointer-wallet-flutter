import 'dart:convert';

import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_scan/qrcode_reader_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// TODO: scan image failed
class ScanClaimQrCode extends StatelessWidget {
  ScanClaimQrCode(this.store, this.confirmedParticipantsCount);

  final AppStore store;
  final int confirmedParticipantsCount;

  final GlobalKey<QrcodeReaderViewState> _qrViewKey = GlobalKey();

  Future<bool> canOpenCamera() async {
    // will do nothing if already granted
    return Permission.camera.request().isGranted;
  }

  void _showSnackBar(BuildContext context, String msg) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
        content: Text(msg, style: TextStyle(color: Colors.black54)),
        duration: Duration(seconds: 2),
      ));
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;

    Future _onScan(String data, String _rawData) async {
      if (data != null) {
        var claim = ClaimOfAttendance.fromJson(json.decode(data));

        String msg = store.encointer.containsClaim(claim) ? dic['claims.scanned.already'] : dic['claims.scanned.new'];
        store.encointer.addParticipantClaim(claim);
        _showSnackBar(context, msg);

        // if we don't wait, scans are spammed of the same qr code
        Future.delayed(const Duration(milliseconds: 500), () {
          _qrViewKey.currentState.startScan();
        });

      } else {
        _qrViewKey.currentState.startScan();
      }
    }

    return Scaffold(
      body: FutureBuilder<bool>(
        future: canOpenCamera(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return QrcodeReaderView(
              key: _qrViewKey,
              helpWidget: Observer(
                builder: (_) => Text(dic['claims.scanned.n.of.m']
                    .replaceAll('SCANNED_COUNT', store.encointer.scannedClaimsCount.toString())
                    .replaceAll('TOTAL_COUNT', confirmedParticipantsCount.toString())
                )
              ),
              headerWidget: SafeArea(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).cardColor,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              onScan: _onScan,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
