import 'package:encointer_wallet/config/consts.dart';

enum Community {
  leu(notificationSound: _leuZurichSound, webSiteLink: _leuZurichLink),
  gbd(notificationSound: _greenbaySound, webSiteLink: _greenbayLink);

  const Community({
    required this.webSiteLink,
    required this.notificationSound,
  });

  factory Community.fromCid(String? cid) {
    if (Cids.isGbd(cid)) return gbd;
    if (Cids.isLeu(cid)) return leu;
    return leu;
  }

  final String webSiteLink;
  final String notificationSound;
}

class Cids {
  /// The list of community cids [communityKusamaCid, communityRococoCid, communityGesselCid]
  static const _leuCids = <String>['u0qj944rhWE', 'u0qj944rhWE'];
  static const _gbdCids = <String>['dpcmj33LUs9', 'dpcmj33LUs9', 'dpcm5272THU'];

  static bool isLeu(String? cid) => _leuCids.contains(cid);
  static bool isGbd(String? cid) => _gbdCids.contains(cid);
}

const _leuZurichSound = 'lions_growl';
const _greenbaySound = 'gbd_chime';
const _leuZurichLink = 'https://leu.zuerich/$localePlaceHolder';
const _greenbayLink = 'http://greenbaydollar.com/';
