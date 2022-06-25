import 'dart:convert';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/encointer_feed/meetupOverrides.dart';
import 'package:http/http.dart' as http;

Future<List<MeetupOverrides>> getMeetupOverrides() async {
  final response = await http.get(Uri.parse(encointer_feed_overrides));

  if (response.statusCode == 200) {
    List<dynamic> list = jsonDecode(response.body);
    return list.map((e) => MeetupOverrides.fromJson(e)).toList();
  } else {
    throw Exception('Failed to get meetup overrides.');
  }
}
