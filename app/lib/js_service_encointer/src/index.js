import 'core-js/stable/index.js';
import 'regenerator-runtime/runtime.js';

import account from './service/account.js';
import encointer from './service/encointer.js';
import settings from './service/settings.js';
import chain from './service/chain.js';

window.addEventListener('flutterInAppWebViewPlatformReady', function (event) {

  window.send = send;

  window.account = account;
  window.chain = chain;
  window.encointer = encointer;
  window.settings = settings;

  console.log('Initialized Window');
});

/**
 * Send messages from JS to dart if it is launched in a webView or
 * log `data` to console otherwise.
 *
 * This function is mostly used in the subscription methods.
 */
function send (path, data) {
  // Detect if we are running in the webview.
  if (window.location.href === 'about:blank') {
    // `EncointerJsService` is the overarching channel to talk from JS to dart.
    // The variable is set in `jsApi.dart`.
    window.flutter_inappwebview.callHandler("EncointerJsService", { path: path, data: data });
  } else {
    console.log(path, data);
  }
}
