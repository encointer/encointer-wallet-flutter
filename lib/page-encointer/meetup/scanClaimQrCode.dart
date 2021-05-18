import 'dart:convert';

import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
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

  @override
  Widget build(BuildContext context) {
    Future _onScan(String data, String _rawData) async {
      if (data != null) {
        var claim = ClaimOfAttendance.fromJson(json.decode(data));
        store.encointer.addParticipantClaim(claim);
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
                builder: (_) => Text("Scanned ${store.encointer.scannedClaimsCount} / $confirmedParticipantsCount Claims")
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
