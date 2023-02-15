import 'package:flutter/material.dart';

class JsServices {
  static Future<String> loadMainJs(BuildContext context) {
    return DefaultAssetBundle.of(context).loadString('js_service_encointer/dist/main.js');
  }
}
