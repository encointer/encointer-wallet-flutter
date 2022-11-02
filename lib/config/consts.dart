import 'package:encointer_wallet/config/node.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/settings.dart';

const String network_name_encointer_gesell = 'nctr-gsl';
const String network_name_encointer_lietaer = 'nctr-r';
const String network_name_encointer_mainnet = 'nctr-k';
const String network_name_encointer_cantillon = 'nctr-ctln';

EndpointData networkEndpointEncointerGesell = EndpointData.fromJson({
  'info': 'nctr-gsl',
  'ss58': 42,
  'text': 'Encointer Gesell (Hosted by Encointer Association)',
  'value': 'wss://gesell.encointer.org',
  'overrideConfig': GesellConfig.toJson(),
  'ipfsGateway': ipfs_gateway_encointer
});

EndpointData networkEndpointEncointerLietaer = EndpointData.fromJson({
  'info': 'nctr-r',
  'ss58': 42,
  'text': 'Encointer Lietaer on Rococo (Hosted by Encointer Association)',
  'value': 'wss://rococo.api.encointer.org',
  'overrideConfig': GesellConfig.toJson(),
  'ipfsGateway': ipfs_gateway_encointer
});

EndpointData networkEndpointEncointerMainnet = EndpointData.fromJson({
  'info': 'nctr-k',
  'ss58': 42, // Fixme: #567
  'text': 'Encointer Network on Kusama (Hosted by Encointer Association)',
  'value': 'wss://kusama.api.encointer.org',
  'overrideConfig': GesellConfig.toJson(),
  'ipfsGateway': ipfs_gateway_encointer
});

EndpointData networkEndpointEncointerGesellDev = EndpointData.fromJson({
  'info': 'nctr-gsl-dev',
  'ss58': 42,
  'text': 'Encointer Gesell Local Devnet',
  'value': 'ws://10.0.2.2:9944', // do not use the docker's address, use the host's
  'overrideConfig': MasterBranchConfig.toJson(),
  'ipfsGateway': ipfs_gateway_local
});

EndpointData networkEndpointEncointerCantillon = EndpointData.fromJson({
  'info': 'nctr-cln',
  'ss58': 42,
  'text': 'Encointer Cantillon (Hosted by Encointer Association)',
  'value': 'wss://cantillon.encointer.org',
  'worker': 'wss://substratee03.scs.ch',
  'mrenclave': 'CbE3fPWjeYVo9LSNKgPPiCXThFBjfhP1GK6Y9S7t5WVe',
  'overrideConfig': CantillonConfig.toJson(),
  'ipfsGateway': ipfs_gateway_encointer
});

EndpointData networkEndpointEncointerCantillonDev = EndpointData.fromJson({
  'info': 'nctr-cln-dev',
  'ss58': 42,
  'text': 'Encointer Cantillon (Hosted by Encointer Association)',
  'value': 'ws://10.0.0.134:9979', // do not use the docker's address, use the host's
  'worker': 'ws:/10.0.0.134:2079',
  'mrenclave': '4SkU25tusVChcrUprW8X22QoEgamCgj3HKQeje7j8Z4E',
  'overrideConfig': SgxBranchConfig.toJson(),
  'ipfsGateway': ipfs_gateway_encointer
});

List<EndpointData> networkEndpoints = [
  networkEndpointEncointerGesell,
  networkEndpointEncointerLietaer,
  networkEndpointEncointerMainnet,
  networkEndpointEncointerGesellDev,
  // networkEndpointEncointerCantillon,
  // networkEndpointEncointerCantillonDev,
];

const network_ss58_map = {
  'encointer': 42,
  'nctr-gsl': 42,
  'nctr-r': 42,
  'nctr-k': 42, // Fixme: #567
  'ss58': 42, // Fixme: #567
  'nctr-cln': 42,
  'nctr-gsl-dev': 42,
  'nctr-cln-dev': 42,
  'substrate': 42,
};

const fall_back_community_icon = 'assets/nctr_logo_faces_only_thick.svg';
const community_icon_name = 'community_icon.svg';

const String ipfs_gateway_encointer = 'http://ipfs.encointer.org:8080'; // AVD: 10.0.2.2 = 127.0.0.1
const String ipfs_gateway_local = 'http://10.0.2.2:8080';

const String encointer_feed = 'https://encointer.github.io/feed';
const String encointer_feed_overrides = '$encointer_feed/overrides.json';

const int ert_decimals = 12;
const int encointer_currencies_decimals = 18;

const double faucetAmount = 0.1;

const int dot_re_denominate_block = 1248328;

const int SECONDS_OF_DAY = 24 * 60 * 60; // seconds of one day
const int SECONDS_OF_YEAR = 365 * 24 * 60 * 60; // seconds of one year

/// test app versions
const String app_beta_version = '0.8.0';
const int app_beta_version_code = 800;

/// js code versions
const Map<String, int> js_code_version_map = {
  network_name_encointer_gesell: 10010,
  network_name_encointer_cantillon: 10010,
};

// links
const locale_place_holder = 'LOCALE_PLACEHOLDER';
const ceremony_info_link_base = 'https://leu.zuerich/$locale_place_holder/#zeremonien';
const leu_zurich_link = 'https://leu.zuerich/$locale_place_holder';
const meetup_notification_link = 'https://encointer.github.io/feed/community_messages/$locale_place_holder/cm.json';
const encointerLink = 'https://wallet.encointer.org/app/';

String setDeepLink([String? linkText]) => '$encointerLink${linkText?.replaceAll('\n', '_')}';

String ceremonyInfoLink(String locale) {
  return replaceLocalePlaceholder(ceremony_info_link_base, locale);
}

String leuZurichLink(String locale) {
  return replaceLocalePlaceholder(leu_zurich_link, locale);
}

String replaceLocalePlaceholder(String link, String locale) {
  switch (locale) {
    case 'en':
      return link.replaceAll(locale_place_holder, 'en');
    case 'de':
      return link.replaceAll(locale_place_holder, '');
    default:
      Log.d('[replaceLocale] unsupported locale, defaulting to english', 'consts.dart');
      return link.replaceAll(locale_place_holder, 'en');
  }
}
