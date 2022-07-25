import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremonyBoxService.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'ceremonyCountDown.dart';

/// Shows primarily the date of the next ceremony.
///
/// If the current time is close to the meetup time, a countdown is shown.
class CeremonySchedule extends StatelessWidget {
  const CeremonySchedule({
    required this.nextCeremonyDate,
    this.languageCode,
    Key? key,
  }) : super(key: key);

  final DateTime nextCeremonyDate;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    bool showCountDown = CeremonyBoxService.shouldShowCountdown(nextCeremonyDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showCountDown
            ? CeremonyDateLabelAbsolute(nextCeremonyDate: nextCeremonyDate, languageCode: languageCode)
            : CeremonyDateLabelRelative(nextCeremonyDate: nextCeremonyDate, languageCode: languageCode),
        SizedBox(height: 8),
        showCountDown
            ? CeremonyCountDown(nextCeremonyDate)
            : CeremonyDate(nextCeremonyDate: nextCeremonyDate, languageCode: languageCode)
      ],
    );
  }
}

class CeremonyDateLabelAbsolute extends StatelessWidget {
  const CeremonyDateLabelAbsolute({
    required this.nextCeremonyDate,
    this.languageCode,
    Key? key,
  }) : super(key: key);

  final DateTime nextCeremonyDate;
  final String? languageCode;

  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    String nextCeremonyHourMinute = '${DateFormat.Hm(languageCode).format(nextCeremonyDate)}';
    String nextCeremonyYearMonthDay = CeremonyBoxService.formatYearMonthDay(nextCeremonyDate, dic, languageCode);

    return RichText(
      text: TextSpan(
        text: '${dic.encointer.nextCeremonyDateLabel} ',
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
  const CeremonyDateLabelRelative({
    required this.nextCeremonyDate,
    this.languageCode,
    Key? key,
  }) : super(key: key);

  final DateTime nextCeremonyDate;
  final String? languageCode;

  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    String timeLeftUntilCeremonyStartsDaysHours =
        CeremonyBoxService.getTimeLeftUntilCeremonyStartsDaysHours(nextCeremonyDate);

    return RichText(
      text: TextSpan(
        text: '${dic.encointer.nextCeremonyTimeLeft} ',
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
  const CeremonyDate({
    this.nextCeremonyDate,
    this.languageCode,
    Key? key,
  }) : super(key: key);

  final DateTime? nextCeremonyDate;
  final String? languageCode;

  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final h2BlackTheme = Theme.of(context).textTheme.headline2!.copyWith(color: encointerBlack);
    String nextCeremonyYearMonthDay = CeremonyBoxService.formatYearMonthDay(nextCeremonyDate!, dic, languageCode);
    String nextCeremonyHourMinute = '${DateFormat.Hm(languageCode).format(nextCeremonyDate!)}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Iconsax.calendar_1,
          color: encointerGrey,
          size: 18,
        ),
        SizedBox(width: 6),
        Text(
          nextCeremonyYearMonthDay,
          style: h2BlackTheme,
        ),
        SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Icon(
            Iconsax.clock,
            color: encointerGrey,
            size: 18,
          ),
        ),
        SizedBox(width: 6),
        Text(
          nextCeremonyHourMinute,
          style: h2BlackTheme,
        ),
      ],
    );
  }
}
