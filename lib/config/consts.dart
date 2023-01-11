import 'dart:io';

import 'package:encointer_wallet/config/node.dart';
import 'package:encointer_wallet/service/log/log.dart';
import 'package:encointer_wallet/store/settings.dart';

const String networkNameEncointerGesell = 'nctr-gsl';
const String networkNameEncointerLietaer = 'nctr-r';
const String networkNameEncointerMainnet = 'nctr-k';
const String networkNameEncointerCantillon = 'nctr-ctln';

const String androidLocalHost = '10.0.2.2';
const String iosLocalHost = 'localhost';

EndpointData networkEndpointEncointerGesell = EndpointData.fromJson({
  'info': 'nctr-gsl',
  'ss58': 42,
  'text': 'Encointer Gesell (Hosted by Encointer Association)',
  'value': 'wss://gesell.encointer.org',
  'overrideConfig': gesellConfig.toJson(),
  'ipfsGateway': ipfsGatewayEncointer
});

EndpointData networkEndpointEncointerLietaer = EndpointData.fromJson({
  'info': 'nctr-r',
  'ss58': 42,
  'text': 'Encointer Lietaer on Rococo (Hosted by Encointer Association)',
  'value': 'wss://rococo.api.encointer.org',
  'overrideConfig': gesellConfig.toJson(),
  'ipfsGateway': ipfsGatewayEncointer
});

EndpointData networkEndpointEncointerMainnet = EndpointData.fromJson({
  'info': 'nctr-k',
  'ss58': 42, // Fixme: #567
  'text': 'Encointer Network on Kusama (Hosted by Encointer Association)',
  'value': 'wss://kusama.api.encointer.org',
  'overrideConfig': gesellConfig.toJson(),
  'ipfsGateway': ipfsGatewayEncointer
});

EndpointData networkEndpointEncointerGesellDev = EndpointData.fromJson({
  'info': 'nctr-gsl-dev',
  'ss58': 42,
  'text': 'Encointer Gesell Local Devnet',
  'value':
      'ws://${Platform.isAndroid ? androidLocalHost : iosLocalHost}:9944', // do not use the docker's address, use the host's
  'overrideConfig': masterBranchConfig.toJson(),
  'ipfsGateway': ipfs_gateway_local
});

EndpointData networkEndpointEncointerCantillon = EndpointData.fromJson({
  'info': 'nctr-cln',
  'ss58': 42,
  'text': 'Encointer Cantillon (Hosted by Encointer Association)',
  'value': 'wss://cantillon.encointer.org',
  'worker': 'wss://substratee03.scs.ch',
  'mrenclave': 'CbE3fPWjeYVo9LSNKgPPiCXThFBjfhP1GK6Y9S7t5WVe',
  'overrideConfig': cantillonConfig.toJson(),
  'ipfsGateway': ipfsGatewayEncointer
});

EndpointData networkEndpointEncointerCantillonDev = EndpointData.fromJson({
  'info': 'nctr-cln-dev',
  'ss58': 42,
  'text': 'Encointer Cantillon (Hosted by Encointer Association)',
  'value': 'ws://10.0.0.134:9979', // do not use the docker's address, use the host's
  'worker': 'ws:/10.0.0.134:2079',
  'mrenclave': '4SkU25tusVChcrUprW8X22QoEgamCgj3HKQeje7j8Z4E',
  'overrideConfig': sgxBranchConfig.toJson(),
  'ipfsGateway': ipfsGatewayEncointer
});

List<EndpointData> networkEndpoints = [
  networkEndpointEncointerGesell,
  networkEndpointEncointerLietaer,
  networkEndpointEncointerMainnet,
  networkEndpointEncointerGesellDev,
  // networkEndpointEncointerCantillon,
  // networkEndpointEncointerCantillonDev,
];

const networkSs58Map = {
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

const fallBackCommunityIcon = 'assets/nctr_logo_faces_only_thick.svg';
const communityIconName = 'community_icon.svg';

// AVD: ${Platform.isAndroid ? androidLocalHost : iosLocalHost} = 127.0.0.1
const String ipfsGatewayEncointer = 'http://ipfs.encointer.org:8080';
// ignore: non_constant_identifier_names
final String ipfs_gateway_local = 'http://${Platform.isAndroid ? androidLocalHost : iosLocalHost}:8080';

const String encointerFeed = 'https://encointer.github.io/feed';
const String encointerFeedOverrides = '$encointerFeed/overrides.json';

const int ertDecimals = 12;
const int encointerCurrenciesDecimals = 18;

const double faucetAmount = 0.1;

const int dotReDenominateBlock = 1248328;

const int secondOfDay = 24 * 60 * 60; // seconds of one day
const int secondOfYear = 365 * 24 * 60 * 60; // seconds of one year

// links
const localePlaceHolder = 'LOCALE_PLACEHOLDER';
const ceremonyInfoLinkBase = 'https://leu.zuerich/$localePlaceHolder/#zeremonien';
const _leuZurichLink = 'https://leu.zuerich/$localePlaceHolder';
const meetupNotificationLink = 'https://encointer.github.io/feed/community_messages/$localePlaceHolder/cm.json';
const encointerLink = 'https://wallet.encointer.org/app/';

String toDeepLink([String? linkText]) => '$encointerLink${linkText?.replaceAll('\n', '_')}';

String ceremonyInfoLink(String locale) {
  return replaceLocalePlaceholder(ceremonyInfoLinkBase, locale);
}

String leuZurichLink(String locale) {
  return replaceLocalePlaceholder(_leuZurichLink, locale);
}

const assignmentFAQLinkEN = 'https://leu.zuerich/en/#why-have-i-not-been-assigned-to-a-cycle';
const assignmentFAQLinkDE = 'https://leu.zuerich/#warum-wurde-ich-keinem-cycle-zugewiesen';

String leuZurichCycleAssignmentFAQLink(String locale) {
  switch (locale) {
    case 'en':
      return assignmentFAQLinkEN;
    case 'de':
      return assignmentFAQLinkDE;
    default:
      Log.d('[replaceLocale] unsupported locale, defaulting to english', 'consts.dart');
      return assignmentFAQLinkEN;
  }
}

String replaceLocalePlaceholder(String link, String locale) {
  switch (locale) {
    case 'en':
      return link.replaceAll(localePlaceHolder, 'en');
    case 'de':
      return link.replaceAll(localePlaceHolder, '');
    default:
      Log.d('[replaceLocale] unsupported locale, defaulting to english', 'consts.dart');
      return link.replaceAll(localePlaceHolder, 'en');
  }
}
