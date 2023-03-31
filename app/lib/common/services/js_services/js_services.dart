import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:flutter/material.dart';

const _tag = 'js_services';

class JsServices {
  static Future<String> loadMainJs(BuildContext context) {
    Log.d('loadMainJs', _tag);
    return DefaultAssetBundle.of(context).loadString('js_service_encointer/dist/main.js');
  }
}
