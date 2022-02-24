import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:encointer_wallet/service/ceremonyBoxService.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class CeremonyInfoAndCalendar extends StatelessWidget {
  const CeremonyInfoAndCalendar({
    this.nextCeremonyDate,
    this.infoLink,
    Key key,
  }) : super(key: key);

  /// date for the next ceremony
  final DateTime nextCeremonyDate;

  /// open this Uri in a browser to give the user background information
  final Uri infoLink;

  // final

  @override
  Widget build(BuildContext context) {
    // var dic = I18n.of(context).translationsForLocale(); // TODO should be this, delete next line
    Translations dic = TranslationsDe();
    Event calendarEventToAdd = CeremonyBoxService.createCalendarEvent(nextCeremonyDate, dic);
    bool showAddToCalendarIconButton = CeremonyBoxService.showAddToCalendarIconButton();
    return Column(
      children: [
        IconButton(
          icon: RotatedBox(
            quarterTurns: 2,
            child: Icon(Iconsax.info_circle),
          ),
          onPressed: () {
            print('TODO open some webpage... $infoLink');
          },
        ),
        if (showAddToCalendarIconButton)
          IconButton(
            icon: Icon(Iconsax.calendar_1),
            onPressed: () => Add2Calendar.addEvent2Cal(calendarEventToAdd),
          ),
      ],
    ); // 'info and cal widget'
  }
}
