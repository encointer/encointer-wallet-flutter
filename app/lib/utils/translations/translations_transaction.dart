abstract class TranslationsTransaction {
  String get endorseNewcomerNotificationTitle;
  String get endorseNewcomerNotificationBody;
  String get registerParticipantNotificationTitle;
  String get registerParticipantNotificationBody;
  String get unregisterParticipantNotificationTitle;
  String get unregisterParticipantNotificationBody;
  String get attestNotificationTitle;
  String get attestNotificationBody;
  String get claimRewardsNotificationTitle;
  String get claimRewardsNotificationBody;
  String get balanceTransferNotificationTitle;
  String get balanceTransferNotificationBody;
}

class TranslationsEnTransaction implements TranslationsTransaction {
  @override
  String get endorseNewcomerNotificationBody => 'Thanks for endorsing the newbie!';
  @override
  String get endorseNewcomerNotificationTitle => 'Newbie endorsed';
  @override
  String get registerParticipantNotificationBody => 'You will receive a reminder one day before.';
  @override
  String get registerParticipantNotificationTitle => 'Registered for the next cycle!';
  @override
  String get attestNotificationBody =>
      'If all participants have sent the attestations, you can try to claim the income.';
  @override
  String get attestNotificationTitle => 'Attested attendees';
  @override
  String get claimRewardsNotificationBody => 'You have already received your community income!';
  @override
  String get claimRewardsNotificationTitle => 'Claimed the community income';
  @override
  String get balanceTransferNotificationBody => 'The recipient has received the tokens.';
  @override
  String get balanceTransferNotificationTitle => 'Transaction completed';
  @override
  String get unregisterParticipantNotificationBody =>
      'Your registration for the next cycle has been cancelled. If you change your mind, you can register again.';
  @override
  String get unregisterParticipantNotificationTitle => 'Registration Cancelled';
}

class TranslationsDeTransaction implements TranslationsTransaction {
  @override
  String get endorseNewcomerNotificationBody => 'Danke für das Endorsen des Newbies!';
  @override
  String get endorseNewcomerNotificationTitle => 'Newbie Endorsed';
  @override
  String get registerParticipantNotificationBody => 'Du erhältst eine Erinnerung einen Tag zuvor.';
  @override
  String get registerParticipantNotificationTitle => 'Für den nächsten Cycle angemeldet!';
  @override
  String get attestNotificationBody =>
      'Wenn alle Teilnehmer die Attestierungen geschickt haben, kannst du versuchen das Einkommen zu erhalten.';
  @override
  String get attestNotificationTitle => 'Teilnehmer attestiert';
  @override
  String get claimRewardsNotificationBody => 'Du hast dein Gemeinschaftseinkommen bereits erhalten.';
  @override
  String get claimRewardsNotificationTitle => 'Gemeinschaftseinkommen angefordert';
  @override
  String get balanceTransferNotificationBody => 'Der Empfänger hat die Tokens erhalten.';
  @override
  String get balanceTransferNotificationTitle => 'Transaktion abgeschlossen';
  @override
  String get unregisterParticipantNotificationBody =>
      'Ihre Anmeldung für den nächsten Zyklus wurde storniert. Wenn Sie es sich anders überlegen, können Sie sich erneut anmelden.';
  @override
  String get unregisterParticipantNotificationTitle => 'Registrierung storniert';
}

class TranslationsFrTransaction implements TranslationsTransaction {
  @override
  String get endorseNewcomerNotificationBody => "Merci d'avoir endossé le Novice!";
  @override
  String get endorseNewcomerNotificationTitle => 'Novice endossé';
  @override
  String get registerParticipantNotificationBody => 'Tu recevras un rappel un jour avant.';
  @override
  String get registerParticipantNotificationTitle => 'Inscrit pour le prochain cycle!';
  @override
  String get attestNotificationBody =>
      "Une fois que tous les participants ont envoyé les attestations, tu peux essayer d'obtenir le revenu.";
  @override
  String get attestNotificationTitle => 'Participants attestés';
  @override
  String get claimRewardsNotificationBody => 'Tu as déjà reçu ton revenu communautaire.';
  @override
  String get claimRewardsNotificationTitle => 'Revenu communautaire demandé';
  @override
  String get balanceTransferNotificationBody => 'Le destinataire a reçu les tokens.';
  @override
  String get balanceTransferNotificationTitle => 'Transaction complète';
  @override
  String get unregisterParticipantNotificationBody =>
      "Votre inscription pour le prochain cycle a été annulée. Si vous changez d'avis, vous pouvez vous inscrire à nouveau.";
  @override
  String get unregisterParticipantNotificationTitle => 'Inscription annulée';
}

class TranslationsRuTransaction implements TranslationsTransaction {
  @override
  String get endorseNewcomerNotificationBody => 'Благодарим за одобрение нвичка в нашем сообществе!';
  @override
  String get endorseNewcomerNotificationTitle => 'Новичок одобрен';
  @override
  String get registerParticipantNotificationBody =>
      'Спасибо за регистрацию. Вам будет отправлено напоминание за день до встречи.';
  @override
  String get registerParticipantNotificationTitle => 'Вы успешно зарегистрировались на следующую встречу!';
  @override
  String get attestNotificationBody =>
      'Если все участники отправили свои подтверждения, можно попробовать получить доход.';
  @override
  String get attestNotificationTitle => 'Фаза Аттестации успешно завершена';
  @override
  String get claimRewardsNotificationBody =>
      'Ваш запрос на вознаграждение получен и будет обработан в кратчайшие сроки. Вы получили свой доход сообщества!';
  @override
  String get claimRewardsNotificationTitle => 'Доход сообщества запрошен';
  @override
  String get balanceTransferNotificationBody => 'Токены успешно переведены на счет получателя!';
  @override
  String get balanceTransferNotificationTitle => 'Транзакция завершена';
  @override
  String get unregisterParticipantNotificationBody =>
      'Ваша регистрация на следующий цикл была отменена. Если вы передумаете, вы можете зарегистрироваться снова.';
  @override
  String get unregisterParticipantNotificationTitle => 'Регистрация отменена';
}
