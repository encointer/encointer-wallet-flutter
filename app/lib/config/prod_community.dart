import 'package:flutter/material.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/theme/theme.dart';

enum CommunityConfig {
  leu(
    notificationSound: _leuZurichSound,
    webSiteLink: _leuZurichLink,
    colorScheme: AppColors.leu,
    cid: WellKnownCids.leuKsm,
  ),
  gbd(
    notificationSound: _greenbaySound,
    webSiteLink: _greenbayLink,
    colorScheme: AppColors.gbd,
    cid: WellKnownCids.gbdKsm,
  ),

  /// Default config in case we don't have a community specific one.
  def(
    notificationSound: _leuZurichSound,
    webSiteLink: _leuZurichLink,
    colorScheme: AppColors.leu,
    cid: WellKnownCids.leuKsm,
  );

  const CommunityConfig({
    required this.webSiteLink,
    required this.notificationSound,
    required this.colorScheme,
    required this.cid,
  });

  /// Returns a community config based on the cid, or the default in case the
  /// the cid does not match a configured one or is null.
  factory CommunityConfig.fromCid(String? cid) {
    if (cid == null) return def;
    if (WellKnownCids.isGbd(cid)) return gbd;
    if (WellKnownCids.isLeu(cid)) return leu;
    return def;
  }

  final String webSiteLink;
  final String notificationSound;
  final ColorScheme colorScheme;
  final String cid;
}

class WellKnownCids {
  static const leuKsm = 'u0qj944rhWE';
  static const leuRoc = 'gb1bc2QX9PQ';
  // leu does not exist on Gesell.

  static const gbdKsm = 'dpcmj33LUs9';
  static const gbdRoc = 'dpcmj33LUs9';
  static const gbdGsl = 'dpcm5272THU';

  static const _leuCids = <String>[leuKsm, leuRoc];
  static const _gbdCids = <String>[gbdKsm, gbdRoc, gbdRoc];

  static bool isLeu(String cid) => _leuCids.contains(cid);
  static bool isGbd(String cid) => _gbdCids.contains(cid);
}

const _leuZurichSound = 'lions_growl';
const _greenbaySound = 'gbd_chime';
const _leuZurichLink = 'https://leu.zuerich/$localePlaceHolder';
const _greenbayLink = 'http://greenbaydollar.com/';
