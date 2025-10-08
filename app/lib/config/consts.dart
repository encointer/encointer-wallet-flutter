import 'dart:io';

import 'package:encointer_wallet/config/prod_community.dart';

const String androidLocalHost = '10.0.2.2';
const String iosLocalHost = 'localhost';

const fallBackCommunityIcon = 'assets/nctr_logo_faces_only_thick.svg';
const communityIconName = 'community_icon.svg';

// AVD: ${Platform.isAndroid ? androidLocalHost : iosLocalHost} = 127.0.0.1
const String ipfsGatewayEncointer = 'http://ipfs.encointer.org:8080';
final String ipfsGatewayLocal = 'http://${Platform.isAndroid ? androidLocalHost : iosLocalHost}:8080';

const encointerFeed = 'https://encointer.github.io/feed';
const communityMessagesPath = 'community_messages/$localePlaceHolder/cm.json';
const encointerFeedOverridesPath = 'overrides.json';

String getEncointerFeedLink({bool devMode = false}) {
  return devMode ? '$encointerFeed/dev' : encointerFeed;
}

const int ertDecimals = 12;
const int encointerCurrenciesDecimals = 18;

// links
const localePlaceHolder = 'LOCALE_PLACEHOLDER';
const ceremonyInfoLinkBase = 'https://leu.zuerich/$localePlaceHolder/#zeremonien';
const encointerLink = 'https://wallet.encointer.org/app/';
const encointerApi = 'https://api.encointer.org/v1/';
const bugReportMail = 'bugreports@mail.encointer.org';

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
const encointerIpfsUrl = 'http://ipfs.encointer.org:8080/ipfs';

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
