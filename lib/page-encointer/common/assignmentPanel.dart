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

class AssignmentPanel extends StatefulWidget {
  AssignmentPanel(this.store);

  final AppStore store;

  @override
  _AssignmentPanelState createState() => _AssignmentPanelState();
}

class _AssignmentPanelState extends State<AssignmentPanel> {
  _AssignmentPanelState();

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
              builder: (_) => widget.store.encointer.meetupTime != null
                  ? widget.store.encointer.communities == null
                      ? Text(dic.assets.communitiesNotFound)
                      : Column(
                          children: <Widget>[
                            widget.store.encointer.meetupIndex > 0
                                ? Column(
                                    children: <Widget>[
                                      Text("You are registered! ", style: TextStyle(color: Colors.green)),
                                      Text("Ceremony will take place on:"),
                                      Text(new DateTime.fromMillisecondsSinceEpoch(widget.store.encointer.meetupTime)
                                          .toIso8601String()),
                                      Text("at location:"),
                                      ElevatedButton(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            widget.store.encointer.meetupLocation != null
                                                ? Icon(
                                                    Icons.location_on,
                                                    size: 25,
                                                    color: Colors.blueAccent,
                                                  )
                                                : CupertinoActivityIndicator(),
                                            Text(dic.encointer.meetupLocation),
                                          ],
                                        ),
                                        onPressed: widget.store.encointer.meetupLocation != null
                                            ? () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return EncointerMap(
                                                        widget.store,
                                                        popupBuilder: (BuildContext context, Marker marker) =>
                                                            SizedBox(),
                                                        markers: buildMarkers(widget.store.encointer.meetupLocation),
                                                        title: dic.encointer.meetupLocation,
                                                        center: widget.store.encointer.meetupLocation.toLatLng(),
                                                        initialZoom: initialZoom,
                                                      );
                                                    },
                                                  ),
                                                )
                                            : null,
                                      )
                                    ],
                                  )
                                : Text(
                                    "You are not registered for ceremony on " +
                                        DateFormat('yyyy-MM-dd').format(new DateTime.fromMillisecondsSinceEpoch(
                                            widget.store.encointer.meetupTime)) +
                                        " for the selected community",
                                    style: TextStyle(color: Colors.red),
                                  ),
                          ],
                        )
                  : CupertinoActivityIndicator(),
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
