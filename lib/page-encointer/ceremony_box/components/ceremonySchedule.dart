import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremonyBoxService.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'ceremonyCountDown.dart';

/// shows primarily the date of the next ceremony
/// but if it is close to the start show a count down
/// if nextCeremonyDate is null show 'Ceremony is over'
class CeremonySchedule extends StatelessWidget {
  const CeremonySchedule({
    this.nextCeremonyDate,
    this.languageCode,
    Key key,
  }) : super(key: key);

  final DateTime nextCeremonyDate;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context).translationsForLocale();
    if (nextCeremonyDate == null) {
      return Text(
        '${dic.encointer.ceremonyIsOver}',
        style: Theme.of(context).textTheme.headline2.copyWith(color: encointerBlack),
      );
    }

    bool showCountDown = CeremonyBoxService.shouldShowCountdown(nextCeremonyDate);
    String nextCeremonyHourMinute = '${DateFormat.Hm(languageCode).format(nextCeremonyDate)}';
    String nextCeremonyYearMonthDay = CeremonyBoxService.formatYearMonthDay(nextCeremonyDate, dic, languageCode);
    String timeLeftUntilCeremonyStartsDaysHours =
        CeremonyBoxService.getTimeLeftUntilCeremonyStartsDaysHours(nextCeremonyDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        RichText(
          text: TextSpan(
            text: '${showCountDown ? dic.encointer.nextCeremonyDateLabel : dic.encointer.nextCeremonyTimeLeft} ',
            style: Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey),
            children: [
              TextSpan(
                text: showCountDown
                    ? '$nextCeremonyYearMonthDay $nextCeremonyHourMinute'
                    : timeLeftUntilCeremonyStartsDaysHours,
                style: Theme.of(context).textTheme.headline4.copyWith(color: encointerBlack),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Icon(
                showCountDown ? Iconsax.timer_start : Iconsax.calendar_1,
                color: encointerGrey,
                size: 18,
              ),
            ),
            SizedBox(
              width: 6,
            ),
            showCountDown
                ? CeremonyCountDown()
                : Text(
                    nextCeremonyYearMonthDay,
                    style: Theme.of(context).textTheme.headline2.copyWith(color: encointerBlack),
                  ),
            SizedBox(
              width: 24,
            ),
            showCountDown
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(
                      Iconsax.clock,
                      color: encointerGrey,
                      size: 18,
                    ),
                  ),
            SizedBox(
              width: 6,
            ),
            showCountDown
                ? SizedBox()
                : Text(
                    nextCeremonyHourMinute,
                    style: Theme.of(context).textTheme.headline2.copyWith(color: encointerBlack),
                  ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
