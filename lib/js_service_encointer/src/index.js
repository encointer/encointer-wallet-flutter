import 'core-js/stable/index.js';
import 'regenerator-runtime/runtime.js';

import account from './service/account.js';
import encointer from './service/encointer.js';
import settings from './service/settings.js';
import chain from './service/chain.js';
import codec from './service/scale-codec.js';

window.addEventListener('flutterInAppWebViewPlatformReady', function (event) {
  console.log('Initializing Window');

  window.send = send;

  window.account = account;
  window.chain = chain;
  window.encointer = encointer;
  window.codec = codec;
  window.settings = settings;

  console.log('Initialized Window');
});

// send message to JSChannel: PolkaWallet
function send (path, data) {
  console.log(path, data);
}
