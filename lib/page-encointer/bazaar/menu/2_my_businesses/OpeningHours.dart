import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../0_main/BazaarMainState.dart';

class OpeningHours extends StatelessWidget {
  final BazaarMainState bazaarMainState;

  OpeningHours(this.bazaarMainState);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [0, 1, 2, 3, 4, 5, 6].map((int day) => OpeningHoursViewForDay(bazaarMainState, day)).toList());
  }
}

class OpeningHoursViewForDay extends StatelessWidget {
  final day;

  final BazaarMainState bazaarMainState;
  final businessFormState;

  OpeningHoursViewForDay(this.bazaarMainState, this.day)
      : businessFormState = bazaarMainState.bazaarMyBusinessesState.businessFormState;

  @override
  Widget build(BuildContext context) {
    final openingHours = businessFormState.openingHours;
    final openingHoursForThisDay = openingHours.getOpeningHoursFor(day);

    return Card(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 36),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Observer(
                  builder: (BuildContext context) => IconButton(
                    color: day == openingHours.dayOnFocus ? Colors.lightGreenAccent : Colors.blueGrey,
                    icon: Icon(
                      Icons.add_circle,
                    ),
                    iconSize: 36,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      openingHours.setDayOnFocus(day);
                    },
                  ),
                ),
                Container(
                  width: 32,
                  child: Text(
                    "${openingHours.getDayString(day)}",
                  ),
                ),
                Observer(
                  builder: (BuildContext context) => IconButton(
                    icon: Icon(
                      Icons.copy,
                      color: day == openingHours.dayToCopyFrom ? Colors.lightGreenAccent : Colors.blueGrey, // TODO
                    ),
                    iconSize: 36,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      openingHours.copyFrom(day);
                    },
                  ),
                ),
                Flexible(
                  child: Observer(
                    builder: (_) => ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: openingHoursForThisDay.openingIntervals.length,
                        itemBuilder: (_, index) {
                          final interval = openingHoursForThisDay.openingIntervals[index];
                          return Container(
                            width: 200,
                            child: Row(
                              children: [
                                Text(
                                  interval.humanReadable(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Observer(
                                  builder: (_) => IconButton(
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                    iconSize: 36,
                                    visualDensity: VisualDensity.compact,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      openingHoursForThisDay.removeInterval(index);
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Observer(
                  builder: (_) => IconButton(
                    icon: Icon(
                      Icons.paste,
                      color: Colors.blueGrey,
                    ),
                    iconSize: 36,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      openingHours.pasteOpeningHoursTo(day);
                    },
                  ),
                ),
              ],
            ),

            Observer(
              builder: (_) => Visibility(
                child: AddOpeningIntervalForDay(bazaarMainState, day),
                visible: day == openingHours.dayOnFocus,
              ),
            ),
            // Text(openingHoursForThisDay.showTextField.toString()),
          ],
        ),
      ),
    );
  }
}

class AddOpeningIntervalForDay extends StatelessWidget {
  final _textController = TextEditingController(text: '');
  final day;

  final BazaarMainState bazaarMainState;
  final businessFormState;

  AddOpeningIntervalForDay(this.bazaarMainState, this.day)
      : businessFormState = bazaarMainState.bazaarMyBusinessesState.businessFormState;

  @override
  Widget build(BuildContext context) {
    final openingHours = businessFormState.openingHours;
    var openingHoursForDay = openingHours.getOpeningHoursFor(day);

    return Observer(
      builder: (_) => TextField(
        // TODO would be nice to only allow certain chars but then backspace is broken, also if added to regex as \b
        // inputFormatters: <TextInputFormatter>[
        //   FilteringTextInputFormatter.allow(RegExp(r"[0-9]|a|A|p|P|m|M|:|-|\b")),
        // ],
        autofocus: true,
        decoration: InputDecoration(
            labelText: 'Add a time interval',
            hintText: 'e.g. 8:15-14:45 or 9-5pm',
            contentPadding: EdgeInsets.all(8),
            errorText: openingHoursForDay.timeFormatError),
        controller: _textController,
        textInputAction: TextInputAction.done,
        onSubmitted: (String startEnd) {
          openingHoursForDay.addParsedIntervalIfValid(startEnd);
          if (openingHoursForDay.timeFormatError == null) {
            _textController.clear();
          }
        },
      ),
    );
  }
}
