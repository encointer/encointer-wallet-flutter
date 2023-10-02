import 'dart:io';

import 'package:encointer_wallet/config/node.dart';
import 'package:encointer_wallet/config/prod_community.dart';
import 'package:encointer_wallet/store/settings.dart';

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
  'ss58': 2,
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

const fallBackCommunityIcon = 'assets/nctr_logo_faces_only_thick.svg';
const communityIconName = 'community_icon.svg';

// AVD: ${Platform.isAndroid ? androidLocalHost : iosLocalHost} = 127.0.0.1
const String ipfsGatewayEncointer = 'http://ipfs.encointer.org:8080';
// ignore: non_constant_identifier_names
final String ipfs_gateway_local = 'http://${Platform.isAndroid ? androidLocalHost : iosLocalHost}:8080';

const encointerFeed = 'https://encointer.github.io/feed';
const communityMessagesPath = 'community_messages/$localePlaceHolder/cm.json';
const encointerFeedOverridesPath = 'overrides.json';

String getEncointerFeedLink({bool devMode = false}) {
  return devMode ? '$encointerFeed/dev' : encointerFeed;
}

const int ertDecimals = 12;
const int encointerCurrenciesDecimals = 18;

const double faucetAmount = 0.1;

// links
const localePlaceHolder = 'LOCALE_PLACEHOLDER';
const ceremonyInfoLinkBase = 'https://leu.zuerich/$localePlaceHolder/#zeremonien';
const encointerLink = 'https://wallet.encointer.org/app/';
const encointerApi = 'https://api.encointer.org/v1/';

String toDeepLink([String? linkText]) => '$encointerLink${linkText?.replaceAll('\n', '_')}';
String getTransactionHistoryUrl(String cid, String address, {DateTime? startTime, DateTime? endTime}) {
  final start = startTime?.millisecondsSinceEpoch ?? 1670000000000;
  final end = (endTime ?? DateTime.now()).millisecondsSinceEpoch;
  return '$encointerApi/accounting/transaction-log?cid=$cid&start=$start&end=$end&account=$address';
}

String ceremonyInfoLink(String locale, String? cid) {
  final communityByCid = CommunityConfig.fromCid(cid);
  return replaceLocalePlaceholder(communityByCid.webSiteLink, locale);
}

const assignmentFAQLinkEN = 'https://leu.zuerich/en/#why-have-i-not-been-assigned-to-a-cycle';
const assignmentFAQLinkDE = 'https://leu.zuerich/#warum-wurde-ich-keinem-cycle-zugewiesen';
const infuraIpfsUrl = 'https://encointer.infura-ipfs.io/ipfs';

String leuZurichCycleAssignmentFAQLink(String locale) {
  return switch (locale) {
    'en' => assignmentFAQLinkEN,
    'de' => assignmentFAQLinkDE,
    _ => assignmentFAQLinkEN,
  };
}

String replaceLocalePlaceholder(String link, String locale) {
  return switch (locale) {
    'en' => link.replaceAll(localePlaceHolder, 'en'),
    'de' => link.replaceAll(localePlaceHolder, ''),
    _ => link.replaceAll(localePlaceHolder, 'en'),
  };
}
