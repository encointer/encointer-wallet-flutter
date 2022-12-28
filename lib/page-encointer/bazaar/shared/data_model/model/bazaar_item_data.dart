import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

/// A BazaarItem can either be an offering or a business.
/// info contains the price in case of an offering and the distance in case of a business
abstract class BazaarItemData {
  BazaarItemData(this.title, this.description, this.image);

  final String title;
  final String description;
  final Image image;

  Color? get cardColor;

  Icon get icon;

  String get info;
}

class BazaarOfferingData extends BazaarItemData {
  BazaarOfferingData(
    String title,
    String description,
    this.price,
    Image image,
  ) : super(title, description, image);

  final double price;

  @override
  String get info => price.toString();

  @override
  Color? get cardColor => Colors.red[300];

  @override
  Icon get icon => const Icon(Icons.local_offer);
}

class BazaarBusinessData extends BazaarItemData {
  BazaarBusinessData(
    String title,
    String description,
    this.coordinates,
    Image image,
    this.openingHours,
    this.offerings,
  ) : super(title, description, image);

  final LatLng coordinates;
  final OpeningHours openingHours;
  final List<BazaarOfferingData> offerings;

  // for now:
  final LatLng turbinenplatz = LatLng(47.389712, 8.517076);
  // TODO use coordinates of the respective community

  @override
  String get info {
    const distance = Distance();
    final distanceInMeters = distance(turbinenplatz, coordinates);
    return '${distanceInMeters.toStringAsFixed(0)}m';
  }

  @override
  Color? get cardColor => Colors.blue[300];

  @override
  Icon get icon => const Icon(Icons.business);
}

class OpeningHours {
  OpeningHours(this.mon, this.tue, this.wed, this.thu, this.fri, this.sat, this.sun);

  /// 0 -> Mon, 1 -> Tue, ... 6 -> Sun
  final OpeningHoursForDay mon;
  final OpeningHoursForDay tue;
  final OpeningHoursForDay wed;
  final OpeningHoursForDay thu;
  final OpeningHoursForDay fri;
  final OpeningHoursForDay sat;
  final OpeningHoursForDay sun;

  OpeningHoursForDay? getOpeningHoursFor(int day) {
    switch (day) {
      case 0:
        return mon;
      case 1:
        return tue;
      case 2:
        return wed;
      case 3:
        return thu;
      case 4:
        return fri;
      case 5:
        return sat;
      case 6:
        return sun;
      default:
        // TODO
        // throw IllegalArgumentException();
        return null;
    }
  }

  /// where 0 -> Mon, 1 -> Tue, ...
  String getDayString(int day) {
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day];
  }
}

/// EmptyList means closed
/// You can have as many (disjoint) OpeningIntervals per day as you please.
class OpeningHoursForDay {
  OpeningHoursForDay(this.openingIntervals);

  final List<OpeningInterval> openingIntervals;

  void addInterval(OpeningInterval interval) {
    openingIntervals.add(interval);
  }

  void removeInterval(int index) {
    openingIntervals.removeAt(index);
  }

  /// where 0 -> Mon, 1 -> Tue, ...
  @override
  String toString() {
    final asString = StringBuffer();
    if (openingIntervals.isEmpty) {
      asString.write('(closed)');
    } else {
      for (var i = 0; i < openingIntervals.length; i++) {
        asString.write(openingIntervals[i].toString());
        asString.write(i < openingIntervals.length - 1 ? ', ' : '');
      }
    }
    return asString.toString();
  }
}

/// start and end in minutes since midnight of that day
class OpeningInterval {
  OpeningInterval(this.start, this.end);

  /// example "8:00-12:00" or "8:00 - 12:00"
  OpeningInterval.fromString(String startEndTime)
      : start = _parseTime(startEndTime, 0),
        end = _parseTime(startEndTime, 1);

  final int start;
  final int end;

  static int _parseTime(String startEndTime, int part) {
    final startEnd = startEndTime.split('-');
    final time = startEnd[part].trim();
    final minutes = int.parse(
      time.substring(time.length - 2),
    );
    final hours = int.parse(
      time.substring(0, time.length - 3),
    );
    return (hours * 60 + minutes) % (24 * 60);
  }

  @override
  String toString() {
    return '${start ~/ 60}:${(start % 60 + 100).toString().substring(1)} - ${end ~/ 60}:${(end % 60 + 100).toString().substring(1)}';
  }
}
