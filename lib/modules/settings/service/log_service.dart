import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SendErrorMessagesService {
  const SendErrorMessagesService(this.pref, this.client);

  final SharedPreferences pref;
  final http.Client client;

  static const _sendToTrelloKey = 'send-trello';

  bool getShouldSendToTrello() => pref.getBool(_sendToTrelloKey) ?? true;

  Future<bool> setShouldSendToTrello(bool value) async {
    return pref.setBool(_sendToTrelloKey, value);
  }

  static const apiKey = '<api-key>';
  static const token = '<your-token>';
  static const boardId = '<board-id>';
  static const listId = '<list-id>';
  static const trelloBaseUrl = 'https://api.trello.com/1/';

  Future<void> sendMessageToTrello(
    String message, [
    String? description,
    StackTrace? stackTrace,
  ]) async {
    try {
      final url = Uri.parse(
        '$trelloBaseUrl/cards?name=${description}error${message}stackTrace$stackTrace&idList=$listId&keepFromSource=all&key=$apiKey&token=$token',
      );
      final response = await client.post(url);
      if (response.statusCode == 200) log('Success to send error to Trello: ${response.body}');
    } catch (e) {
      log(e.toString());
    }
  }

  String get sendToTrelloKey => _sendToTrelloKey;
}
