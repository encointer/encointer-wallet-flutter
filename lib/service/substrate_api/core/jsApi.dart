import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const EncointerJsService = "EncointerJsService";

/// Core interface to talk with our JS-service
class JSApi {
  Map<String, Function> _msgHandlers = {};
  Map<String, Completer> _msgCompleters = {};

  HeadlessInAppWebView _web;

  int _evalJavascriptUID = 0;

  Function _webViewPostInitCallback;

  Future<void> launchWebView(BuildContext context, Future<void> Function() webViewPostInitCallback) async {
    _msgHandlers = {};
    _msgCompleters = {};
    _evalJavascriptUID = 0;

    _webViewPostInitCallback = webViewPostInitCallback;

    if (_web != null) {
      closeWebView();
    }

    String jsServiceEncointer =
        await DefaultAssetBundle.of(context).loadString('lib/js_service_encointer/dist/main.js');

    _web = HeadlessInAppWebView(
      initialData: InAppWebViewInitialData(data: jSSourceHtmlContainer(jsServiceEncointer)),
      onConsoleMessage: (controller, message) => print("JS-Console: ${message.message}"),
      onWebViewCreated: (controller) async {
        print("Adding the PolkaWallet javascript handler");

        controller.addJavaScriptHandler(
            handlerName: EncointerJsService,
            callback: (args) {
              print('[JavaScripHandler/callback]: ${args.toString()}');

              var res = args[0];

              final String path = res['path'];
              if (_msgCompleters[path] != null) {
                Completer handler = _msgCompleters[path];
                handler.complete(res['data']);
                if (path.contains('uid=')) {
                  _msgCompleters.remove(path);
                }
              }
              if (_msgHandlers[path] != null) {
                Function handler = _msgHandlers[path];
                handler(res['data']);
              }
            });
      },
      onLoadStop: (controller, _) async {
        await _webViewPostInitCallback();
      },
    );

    await _web.run();
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
      String res = await _web.webViewController.evaluateJavascript(source: code);
      return res;
    }

    Completer c = new Completer();

    String method = 'uid=${_getEvalJavascriptUID()};${code.split('(')[0]}';
    _msgCompleters[method] = c;

    // Send the result from JS to dart after `code` completed.
    String script = """
        $code.then(function(res) {
          window.flutter_inappwebview
            .callHandler("$EncointerJsService", { path: "$method", data: res });
        }).catch(function(err) {
          window.flutter_inappwebview
            .callHandler("$EncointerJsService", { path: "$method:error", data: err.message  });
        })""";

    _web.webViewController.evaluateJavascript(source: script);

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
      _web.webViewController.evaluateJavascript(source: 'unsub$channel()');
    }
  }

  Future<void> closeWebView() async {
    print("[JSApi]: closing webView");
    if (_web != null) {
      await _web.dispose();
      _web = null;
    } else {
      print("[JSApi]: Did not close webView because it was closed already.");
    }
  }
}

/// Wraps `jSSource` in a html document ready to be hoisted in a webView.
String jSSourceHtmlContainer(String jSSource) {
  return """
  <!DOCTYPE html>
  <html lang="en">
    <body>
      <script>
        $jSSource
      </script>
    </body>
  </html>
  """;
}
