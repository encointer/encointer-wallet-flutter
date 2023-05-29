import 'package:flutter/material.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/theme/theme.dart';

enum Community {
  leu(
    notificationSound: _leuZurichSound,
    webSiteLink: _leuZurichLink,
    colorScheme: AppColors.leu,
  ),
  gbd(
    notificationSound: _greenbaySound,
    webSiteLink: _greenbayLink,
    colorScheme: AppColors.gbd,
  );

  const Community({
    required this.webSiteLink,
    required this.notificationSound,
    required this.colorScheme,
  });

  factory Community.fromCid(String? cid) {
    if (Cids.isGbd(cid)) return gbd;
    if (Cids.isLeu(cid)) return leu;
    return leu;
  }

  final String webSiteLink;
  final String notificationSound;
  final ColorScheme colorScheme;
}

class Cids {
  static const leuKsm = 'u0qj944rhWE';
  static const leuRoc = 'gb1bc2QX9PQ';
  // leu does not exist on Gesell.

  static const gbdKsm = 'dpcmj33LUs9';
  static const gbdRoc = 'dpcmj33LUs9';
  static const gbdGsl = 'dpcm5272THU';

  static const _leuCids = <String>[leuKsm, leuRoc];
  static const _gbdCids = <String>[gbdKsm, gbdRoc, gbdRoc];

  static bool isLeu(String? cid) => _leuCids.contains(cid);
  static bool isGbd(String? cid) => _gbdCids.contains(cid);
}

const _leuZurichSound = 'lions_growl';
const _greenbaySound = 'gbd_chime';
const _leuZurichLink = 'https://leu.zuerich/$localePlaceHolder';
const _greenbayLink = 'http://greenbaydollar.com/';
