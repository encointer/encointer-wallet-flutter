import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_box_service.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/components/ceremony_count_down.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

/// Shows primarily the date of the next ceremony.
///
/// If the current time is close to the meetup time, a countdown is shown.
class CeremonySchedule extends StatelessWidget {
  const CeremonySchedule({required this.nextCeremonyDate, this.languageCode, super.key});

  final DateTime nextCeremonyDate;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    final showCountDown = CeremonyBoxService.shouldShowCountdown(nextCeremonyDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showCountDown)
          CeremonyDateLabelAbsolute(nextCeremonyDate: nextCeremonyDate, languageCode: languageCode)
        else
          CeremonyDateLabelRelative(nextCeremonyDate: nextCeremonyDate, languageCode: languageCode),
        const SizedBox(height: 8),
        if (showCountDown)
          CeremonyCountDown(nextCeremonyDate)
        else
          CeremonyDate(nextCeremonyDate: nextCeremonyDate, languageCode: languageCode)
      ],
    );
  }
}

class CeremonyDateLabelAbsolute extends StatelessWidget {
  const CeremonyDateLabelAbsolute({required this.nextCeremonyDate, this.languageCode, super.key});

  final DateTime nextCeremonyDate;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    final nextCeremonyHourMinute = DateFormat.Hm(languageCode).format(nextCeremonyDate);
    final nextCeremonyYearMonthDay = CeremonyBoxService.formatYearMonthDay(nextCeremonyDate, dic, languageCode);

    return RichText(
      text: TextSpan(
        text: '${dic.encointer.nextCycleDateLabel} ',
        style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey),
        children: [
          TextSpan(
            text: '$nextCeremonyYearMonthDay $nextCeremonyHourMinute',
            style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerBlack),
          ),
        ],
      ),
    );
  }
}

class CeremonyDateLabelRelative extends StatelessWidget {
  const CeremonyDateLabelRelative({required this.nextCeremonyDate, this.languageCode, super.key});

  final DateTime nextCeremonyDate;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    final timeLeftUntilCeremonyStartsDaysHours =
        CeremonyBoxService.getTimeLeftUntilCeremonyStartsDaysHours(nextCeremonyDate);

    return RichText(
      text: TextSpan(
        text: '${dic.encointer.nextCycleTimeLeft} ',
        style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey),
        children: [
          TextSpan(
            text: timeLeftUntilCeremonyStartsDaysHours,
            style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerBlack),
          ),
        ],
      ),
    );
  }
}

class CeremonyDate extends StatelessWidget {
  const CeremonyDate({this.nextCeremonyDate, this.languageCode, super.key});

  final DateTime? nextCeremonyDate;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final h2BlackTheme = Theme.of(context).textTheme.headline2!.copyWith(color: encointerBlack);
    final nextCeremonyYearMonthDay = CeremonyBoxService.formatYearMonthDay(nextCeremonyDate!, dic, languageCode);
    final nextCeremonyHourMinute = DateFormat.Hm(languageCode).format(nextCeremonyDate!);

    return Row(
      children: [
        const Icon(
          Iconsax.calendar_1,
          color: encointerGrey,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(
          nextCeremonyYearMonthDay,
          style: h2BlackTheme,
        ),
        const SizedBox(width: 12),
        const Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Icon(
            Iconsax.clock,
            color: encointerGrey,
            size: 18,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          nextCeremonyHourMinute,
          style: h2BlackTheme,
        ),
      ],
    );
  }
}
