import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
            Observer(
              builder: (_) => store.encointer.communities == null
                  ? Text(dic.assets.communitiesNotFound)
                  : Column(
                      children: <Widget>[
                        store.encointer.isRegistered
                            ? Column(
                                children: <Widget>[
                                  Text("You are registered! ", style: TextStyle(color: Colors.green)),
                                  Text("Ceremony will take place on:"),
                                  MaybeMeetupTime(store.encointer.meetupTime, dateFormat: 'yyyy-MM-dd-hh:mm'),
                                  ElevatedButton(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        store.encointer.meetupLocation != null
                                            ? Icon(
                                                Icons.location_on,
                                                size: 25,
                                                color: Colors.blueAccent,
                                              )
                                            : CupertinoActivityIndicator(),
                                        Text(dic.encointer.meetupLocation),
                                      ],
                                    ),
                                    onPressed: store.encointer.meetupLocation != null
                                        ? () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return EncointerMap(
                                                    store,
                                                    popupBuilder: (BuildContext context, Marker marker) => SizedBox(),
                                                    markers: buildMarkers(store.encointer.meetupLocation),
                                                    title: dic.encointer.meetupLocation,
                                                    center: store.encointer.meetupLocation.toLatLng(),
                                                    initialZoom: initialZoom,
                                                  );
                                                },
                                              ),
                                            )
                                        : null,
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    "You are not registered for a ceremony for the selected community on:",
                                    style: TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                  MaybeMeetupTime(store.encointer.meetupTime),
                                ],
                              ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  List<Marker> buildMarkers(Location meetupLocation) {
    List<Marker> markers = <Marker>[];
    markers.add(
      Marker(
        // marker is not a widget, hence test_driver cannot find it (it can find it in the Icon inside, though).
        // But we need the key to derive the popup key
        key: Key('meetup-location'),
        point: meetupLocation.toLatLng(),
        width: 40,
        height: 40,
        builder: (_) => Icon(
          Icons.location_on,
          size: 40,
          color: Colors.blueAccent,
          key: Key('meetup-location-icon'), // used for test_driver
        ),
        anchorPos: AnchorPos.align(AnchorAlign.top),
      ),
    );
    return markers;
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
