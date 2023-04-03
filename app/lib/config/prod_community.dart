import 'package:encointer_wallet/config/consts.dart';

enum Community {
  leo(notificationSound: _leuZurichSound, webSiteLink: _leuZurichLink),
  gbd(notificationSound: _greenbaySound, webSiteLink: _greenbayLink);

  const Community({
    required this.webSiteLink,
    required this.notificationSound,
  });

  final String webSiteLink;
  final String notificationSound;

  static Community getCommunityByCid(String? cid) {
    switch (cid) {
      case 'dpcmj33LUs9':
      case 'dpcm5272THU':
        return gbd;
      case 'u0qj944rhWE':
        return leo;
      default:
        return leo;
    }
  }
}

const _leuZurichSound = 'lions_growl';
const _greenbaySound = 'gbd_chime';
const _leuZurichLink = 'https://leu.zuerich/$localePlaceHolder';
const _greenbayLink = 'http://greenbaydollar.com/';
