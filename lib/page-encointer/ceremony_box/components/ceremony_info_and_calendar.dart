import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_box_service.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/ui.dart';

class CeremonyInfoAndCalendar extends StatelessWidget {
  const CeremonyInfoAndCalendar({
    required this.nextCeremonyDate,
    this.infoLink,
    this.devMode = false,
    Key? key,
  }) : super(key: key);

  final devMode;

  /// date for the next ceremony
  final DateTime nextCeremonyDate;

  /// open this Uri in a browser to give the user background information
  final String? infoLink;

  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context)!.translationsForLocale();
    Event calendarEventToAdd = CeremonyBoxService.createCalendarEvent(nextCeremonyDate, dic);
    bool showAddToCalendarIconButton = CeremonyBoxService.showAddToCalendarIconButton();
    return Column(
      children: [
        IconButton(
          icon: const RotatedBox(
            quarterTurns: 2,
            child: Icon(Iconsax.info_circle),
          ),
          onPressed: () => UI.launchURL(infoLink!),
        ),
        if (showAddToCalendarIconButton)
          IconButton(
            icon: const Icon(Iconsax.calendar_1),
            onPressed: () => Add2Calendar.addEvent2Cal(calendarEventToAdd),
          ),
      ],
    ); // 'info and cal widget'
  }
}
