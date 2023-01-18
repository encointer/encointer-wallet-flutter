import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

class AppLaunch {
  static Future<bool> sendEmail(
    String email, {
    String? subject,
    String? body,
    String? snackBarText,
    BuildContext? context,
  }) async {
    final launchedEmailSuccessfully = await launchUrl(
      Uri(scheme: 'mailto', path: email, queryParameters: {'subject': subject, 'body': body}),
    );
    if (!launchedEmailSuccessfully && snackBarText != null && context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(snackBarText)),
      );
    }
    return launchedEmailSuccessfully;
  }

  static Future<void> launchURL(String url, {String? snackBarText, BuildContext? context}) async {
    try {
      final launchedUrlSuccessfully = await launchUrl(Uri.parse(url));
      if (!launchedUrlSuccessfully && snackBarText != null && context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(snackBarText)),
        );
      }
    } catch (e, s) {
      Log.e('Could not launch URL: $e', 'UI', s);
    }
  }

  static Future<void> launchMap(Location location) async {
    final uri = Uri.parse(Platform.isIOS
        ? 'https://maps.apple.com/?q=${location.lat},${location.lon}'
        : 'https://www.google.com/maps/search/?api=1&query=${location.lat},${location.lon}');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      Log.e(e.toString());
      await launchUrl(uri);
    }
  }
}
