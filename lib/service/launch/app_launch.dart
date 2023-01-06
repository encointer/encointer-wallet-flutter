import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:encointer_wallet/service/log/log_service.dart';

class AppLaunch {
  static Future<bool> sendEmail(String email, {String? snackBarText, BuildContext? context}) async {
    final isSuccess = await launchUrl(Uri(scheme: 'mailto', path: email));
    if (!isSuccess && snackBarText != null && context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(snackBarText)),
      );
    }
    return isSuccess;
  }

  static Future<void> launchURL(String url, {String? snackBarText, BuildContext? context}) async {
    try {
      final isSuccess = await launchUrl(Uri.parse(url));
      if (!isSuccess && snackBarText != null && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(snackBarText)),
        );
      }
    } catch (e, s) {
      Log.e('Could not launch URL: $e', 'UI', s);
    }
  }
}
