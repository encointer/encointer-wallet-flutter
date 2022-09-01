import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

class UpdateVersion {
  static const bool simpleBehavior = false;

  final newVersion = NewVersion(
    iOSId: 'org.encointer.walle',
    androidId: 'org.encointer.walle',
  );

  Future<void> checkVersion(BuildContext context) async {
    log('simpleBehavior $simpleBehavior');
    if (simpleBehavior) {
      await basicStatusCheck(context);
    } else {
      await advancedStatusCheck(context);
    }
  }

  Future<void> basicStatusCheck(BuildContext context) async {
    log('showAlertIfNecessary $simpleBehavior');
    await newVersion.showAlertIfNecessary(context: context);
  }

  Future<void> advancedStatusCheck(BuildContext context) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      log(status.releaseNotes.toString());
      log(status.appStoreLink);
      log(status.localVersion);
      log(status.storeVersion);
      log(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Custom Title',
        dialogText: 'Custom Text',
      );
    }
  }
}
