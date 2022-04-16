import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// Core interface to talk with our JS-service
class JSApi {
  Map<String, Function> _msgHandlers = {};
  Map<String, Completer> _msgCompleters = {};
  FlutterWebviewPlugin _web;
  StreamSubscription _subscription;

  int _evalJavascriptUID = 0;

  Function _webViewPostInitCallback;

  Future<void> launchWebView(BuildContext context, Function webViewPostInitCallback) async {
    _msgHandlers = {};
    _msgCompleters = {};
    _evalJavascriptUID = 0;

    _webViewPostInitCallback = webViewPostInitCallback;

    final bool needLaunch = _web == null;
    if (needLaunch) {
      _web = FlutterWebviewPlugin();
    }

    if (_subscription != null) {
      //  (should only happen in hot-restart)
      _subscription.cancel();
    }

    _subscription = _web.onStateChanged.listen((viewState) async {
      if (viewState.type == WebViewState.finishLoad) {
        String network = 'encointer';
        print('webview loaded for network $network');

        DefaultAssetBundle.of(context).loadString('lib/js_service_$network/dist/main.js').then((String js) {
          print('js_service_$network loaded in webview');
          // inject js file to webview
          _web.evalJavascript(js);

          _webViewPostInitCallback();
        });
      }
    });

    if (!needLaunch) {
      _web.reload();
      return;
    } else {
      _web.launch(
        'about:blank',
        javascriptChannels: [
          JavascriptChannel(
              name: 'PolkaWallet',
              onMessageReceived: (JavascriptMessage message) {
                print('received msg: ${message.message}');
                compute(jsonDecode, message.message).then((msg) {
                  final String path = msg['path'];
                  if (_msgCompleters[path] != null) {
                    Completer handler = _msgCompleters[path];
                    handler.complete(msg['data']);
                    if (path.contains('uid=')) {
                      _msgCompleters.remove(path);
                    }
                  }
                  if (_msgHandlers[path] != null) {
                    Function handler = _msgHandlers[path];
                    handler(msg['data']);
                  }
                });
              }),
        ].toSet(),
        ignoreSSLErrors: true,
//      debuggingEnabled: true,
//        withLocalUrl: true,
//        localUrlScope: 'lib/polkadot_js_service/dist/',
        hidden: true,
      );
    }
  }

  /// Evaluate javascript [code] in the webView.
  ///
  /// If [wrapPromise] is true, evaluation of [code] will directly be awaited and the result is returned.
  /// Otherwise, a future is created and put into the list of pending JS-calls.
  /// If [allowRepeat] is true, a call to the same JS-method can be made repeatedly. Otherwise, subsequent calls will
  /// not have any effect.
  Future<dynamic> evalJavascript(
    String code, {
    bool wrapPromise = true,
    // True is the safe approach; otherwise a crashing (and therefore not returning) JS-call, will prevent subsequent
    // calls to the same method.
    bool allowRepeat = true,
  }) async {
    // check if there's a same request loading
    if (!allowRepeat) {
      for (String i in _msgCompleters.keys) {
        String call = code.split('(')[0];
        if (i.compareTo(call) == 0) {
          print('request $call loading');
          return _msgCompleters[i].future;
        }
      }
    }

    if (!wrapPromise) {
      String res = await _web.evalJavascript(code);
      return res;
    }

    Completer c = new Completer();

    String method = 'uid=${_getEvalJavascriptUID()};${code.split('(')[0]}';
    _msgCompleters[method] = c;

    String script = '$code.then(function(res) {'
        '  PolkaWallet.postMessage(JSON.stringify({ path: "$method", data: res }));'
        '}).catch(function(err) {'
        '  PolkaWallet.postMessage(JSON.stringify({ path: "$method:error", data: err.message }));'
        '})';

    _web.evalJavascript(script);

    return c.future;
  }

  int _getEvalJavascriptUID() {
    return _evalJavascriptUID++;
  }

  Future<void> subscribeMessage(
    String code,
    String channel,
    Function callback,
  ) async {
    _msgHandlers[channel] = callback;
    evalJavascript(code, allowRepeat: true);
  }

  Future<void> unsubscribeMessage(String channel) async {
    if (_msgHandlers[channel] != null) {
      _web.evalJavascript('unsub$channel()');
    }
  }

  Future<void> closeWebView() async {
    print("[JSApi]: closing webView");
    if (_web != null) {
      _web.close();
      _web = null;
    } else {
      print("[JSApi]: Did not close webView because it was closed already.");
    }
  }
}
