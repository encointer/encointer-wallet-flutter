import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class Log {
  static void e(String message, [String? description, StackTrace? stackTrace]) {
    log('[ERROR] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
  }

  static void d(String message, [String? description, StackTrace? stackTrace]) {
    log('[DEBUG] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
  }

  static void p(String message, [String? description, StackTrace? stackTrace]) {
    log('[PRINT] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
  }

  static Future<void> sendToTrelloWithEmail(
    BuildContext context,
    String message, [
    String? description,
    StackTrace? stackTrace,
  ]) async {
    log('[Error] ${description ?? ''} ==> : $message ${stackTrace ?? ''}');
    final dic = I18n.of(context)!.translationsForLocale().profile;
    showCupertinoDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Uygulamada bir hata oluştu. Hatayı geliştiricilere göndermek istermisiniz?'),
          content: Text(
            '$message\n$stackTrace',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            CupertinoButton(
              key: const Key('close-educate-dialog'),
              child: const Text('cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: const Text('send'),
              onPressed: () => AppLaunch.sendEmail(
                'malikelbay1+np8u5ozogws6ijqbldun@boards.trello.com',
                snackBarText: dic.checkEmailApp,
                context: context,
                subject: 'Catch error $stackTrace',
                body: message,
              ),
            ),
          ],
        );
      },
    );
  }

  static const apiKey = '<api-key>';
  static const token = '<your-token>';
  static const boardId = '<board-id>';
  static const listId = '<list-id>';

  static Future<void> sendToTrelloWithHttp(
    String message, [
    String? description,
    StackTrace? stackTrace,
  ]) async {
    final url = Uri.parse(
      'https://api.trello.com/1/cards?name=${description}error${message}stackTrace$stackTrace&idList=$listId&keepFromSource=all&key=$apiKey&token=$token',
    );
    final response = await http.post(url);
    if (response.statusCode != 200) {
      log('Failed to send error to Trello: ${response.body}');
    }
  }
}
