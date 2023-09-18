import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_box_service.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_count_down.dart';
import 'package:encointer_wallet/l10n/l10.dart';

/// Shows primarily the date of the next ceremony.
///
/// If the current time is close to the meetup time, a countdown is shown.
class CeremonySchedule extends StatelessWidget {
  const CeremonySchedule({
    required this.nextCeremonyDate,
    required this.communityRules,
    this.languageCode,
    super.key,
  });

  final DateTime nextCeremonyDate;
  final CommunityRules communityRules;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    final showCountDown = CeremonyBoxService.shouldShowCountdown(nextCeremonyDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showCountDown)
          CeremonyDateLabelAbsolute(
              nextCeremonyDate: nextCeremonyDate, communityRules: communityRules, languageCode: languageCode)
        else
          CeremonyDateLabelRelative(
              nextCeremonyDate: nextCeremonyDate, communityRules: communityRules, languageCode: languageCode),
        const SizedBox(height: 8),
        if (showCountDown)
          CeremonyCountDown(
              nextCeremonyDate: nextCeremonyDate, communityRules: communityRules, languageCode: languageCode)
        else
          CeremonyDate(nextCeremonyDate: nextCeremonyDate, communityRules: communityRules, languageCode: languageCode)
      ],
    );
  }
}

class CeremonyDateLabelAbsolute extends StatelessWidget {
  const CeremonyDateLabelAbsolute({
    required this.nextCeremonyDate,
    required this.communityRules,
    this.languageCode,
    super.key,
  });

  final DateTime nextCeremonyDate;
  final CommunityRules communityRules;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final nextCeremonyHourMinute = DateFormat.Hm(languageCode).format(nextCeremonyDate);
    final nextCeremonyYearMonthDay = CeremonyBoxService.formatYearMonthDay(nextCeremonyDate, l10n, languageCode);

    final timeDisplay =
        communityRules.isLoCoLight ? nextCeremonyYearMonthDay : '$nextCeremonyYearMonthDay $nextCeremonyHourMinute';

    return RichText(
      text: TextSpan(
        text: '${l10n.nextCycleDateLabel} ',
        style: context.bodySmall.copyWith(color: AppColors.encointerGrey),
        children: [
          TextSpan(text: timeDisplay, style: context.bodyMedium.copyWith(color: AppColors.encointerBlack)),
        ],
      ),
    );
  }
}

class CeremonyDateLabelRelative extends StatelessWidget {
  const CeremonyDateLabelRelative({
    required this.nextCeremonyDate,
    required this.communityRules,
    this.languageCode,
    super.key,
  });

  final DateTime nextCeremonyDate;
  final CommunityRules communityRules;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    final timeUntilCeremony = communityRules.isLoCoLight
        ? CeremonyBoxService.ddUntilCeremony(nextCeremonyDate)
        : CeremonyBoxService.ddHHUntilCeremony(nextCeremonyDate);

    return RichText(
      text: TextSpan(
        text: '${context.l10n.nextCycleTimeLeft} ',
        style: context.bodyLarge.copyWith(color: AppColors.encointerGrey),
        children: [
          TextSpan(
            text: timeUntilCeremony,
            style: context.bodyLarge.copyWith(color: AppColors.encointerBlack),
          ),
        ],
      ),
    );
  }
}

class CeremonyDate extends StatelessWidget {
  const CeremonyDate({
    required this.nextCeremonyDate,
    required this.communityRules,
    this.languageCode,
    super.key,
  });

  final DateTime nextCeremonyDate;
  final CommunityRules communityRules;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    final h2BlackTheme = context.titleLarge.copyWith(color: AppColors.encointerBlack);
    final nextCeremonyYearMonthDay =
        CeremonyBoxService.formatYearMonthDay(nextCeremonyDate, context.l10n, languageCode);

    return Row(
      children: [
        const Icon(
          Iconsax.calendar_1,
          color: AppColors.encointerGrey,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          nextCeremonyYearMonthDay,
          style: h2BlackTheme,
        ),
        const SizedBox(width: 12),
        if (!communityRules.isLoCoLight)
          Row(
            children: [
              const Icon(
                Iconsax.clock,
                color: AppColors.encointerGrey,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                DateFormat.Hm(languageCode).format(nextCeremonyDate),
                style: h2BlackTheme,
              ),
            ],
          ),
      ],
    );
  }
}
