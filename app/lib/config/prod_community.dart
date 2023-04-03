import 'package:encointer_wallet/config/consts.dart';

enum Community {
  leu(notificationSound: _leuZurichSound, webSiteLink: _leuZurichLink),
  gbd(notificationSound: _greenbaySound, webSiteLink: _greenbayLink);

  const Community({
    required this.webSiteLink,
    required this.notificationSound,
  });

  factory Community.fromCid(String? cid) {
    switch (cid) {
      case Cids.gbdKsm:
      case Cids.gbdRoc:
      case Cids.gbdGsl:
        return gbd;
      case Cids.leuKsm:
      case Cids.leuRoc:
        return leu;
      default:
        return leu;
    }
  }

  final String webSiteLink;
  final String notificationSound;
}

class Cids {
  static const String leuKsm = 'u0qj944rhWE';
  static const String leuRoc = 'gb1bc2QX9PQ';

  static const String gbdKsm = 'dpcmj33LUs9';
  static const String gbdRoc = 'dpcmj33LUs9';
  static const String gbdGsl = 'dpcm5272THU';
}

const _leuZurichSound = 'lions_growl';
const _greenbaySound = 'gbd_chime';
const _leuZurichLink = 'https://leu.zuerich/$localePlaceHolder';
const _greenbayLink = 'http://greenbaydollar.com/';
