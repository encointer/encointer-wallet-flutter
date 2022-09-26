import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

Future<void> initialDeepLinks(BuildContext context) async {
  Log.d('==============> initialDeepLink started', 'initialDeepLinks');
  final url = await getInitialLink();
  if (url != null) {
    Log.d('==============> $url', 'initialDeepLinks');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(url)));
  } else {
    Log.d('==============> $url', 'initialDeepLinks');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('url null keldi')));
  }
}
