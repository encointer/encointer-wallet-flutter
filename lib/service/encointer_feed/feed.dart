import 'dart:convert';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/encointer_feed/meetupOverrides.dart';
import 'package:http/http.dart' as http;

Future<MeetupOverrides> getMeetupOverrides() async {
  final response = await http.get(Uri.parse(encointer_feed_overrides));

  if (response.statusCode == 200) {
    return MeetupOverrides.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get meetup overrides.');
  }
}
