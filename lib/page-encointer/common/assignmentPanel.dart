import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import 'encointerMap.dart';

class AssignmentPanel extends StatelessWidget {
  AssignmentPanel(this.store);

  final AppStore store;

  final double initialZoom = 14;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    return Container(
      width: double.infinity,
      child: RoundedCard(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Observer(builder: (_) {
              Meetup meetup = store.encointer.communityAccount.meetup;

              Location meetupLocation = meetup == null
                  ? store.encointer.community.meetupLocations?.first
                  : store.encointer.community.meetupLocations[meetup.locationIndex];

              return store.encointer.communities == null
                  ? Text(dic.assets.communitiesNotFound)
                  : Column(
                      children: <Widget>[
                        store.encointer.communityAccount.isAssigned
                            ? Column(
                                children: <Widget>[
                                  Text(dic.encointer.alreadyRegistered, style: TextStyle(color: Colors.green)),
                                  Text(dic.encointer.ceremonyWillTakePlaceOn),
                                  MaybeMeetupTime(store.encointer.community.meetupTime, dateFormat: 'yyyy-MM-dd-HH:mm'),
                                  ElevatedButton(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        meetupLocation != null
                                            ? Icon(
                                                Icons.location_on,
                                                size: 25,
                                                color: Colors.blueAccent,
                                              )
                                            : CupertinoActivityIndicator(),
                                        Text(dic.encointer.meetupLocation),
                                      ],
                                    ),
                                    onPressed: meetupLocation != null
                                        ? () => showOnEncointerMap(context, store, meetupLocation)
                                        : null,
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    dic.encointer.youAreNotRegistered,
                                    style: TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 4),
                                  MaybeMeetupTime(store.encointer.community.meetupTime),
                                ],
                              ),
                      ],
                    );
            })
          ],
        ),
      ),
    );
  }
}

class MaybeMeetupTime extends StatelessWidget {
  MaybeMeetupTime(this.meetupTime, {this.dateFormat = 'yyyy-MM-dd', this.style});

  final int meetupTime;

  final String dateFormat;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    String date;

    if (meetupTime != null) {
      date = DateFormat(dateFormat).format(new DateTime.fromMillisecondsSinceEpoch(meetupTime));
    }

    return meetupTime != null ? Text(date, style: this.style) : CupertinoActivityIndicator();
  }
}
