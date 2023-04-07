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
  String get invalidTransactionTitle;
  String get invalidTransactionBody;
  String get alreadyEndorsedTitle;
  String get alreadyEndorsedBody;
  String get invalidRequestTitle;
  String get invalidRequestBody;
  String get invalidClaimTitle;
  String get invalidClaimBody;
  String get lowPriorityTitle;
  String get lowPriorityBody;
  String get rewardsIssuedTitle;
  String get rewardsIssuedBody;
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
  String get unregisterParticipantNotificationTitle => 'Registration cancelled';
  @override
  String get alreadyEndorsedBody =>
      'You have already endorsed this participant. Please do not attempt to endorse the same participant more than once.';
  @override
  String get alreadyEndorsedTitle => 'Already Endorsed';
  @override
  String get invalidClaimBody =>
      'Claims can be submitted after all attendees have scanned everyone. Please ensure that you have scanned all attendees and tapped on claims.';
  @override
  String get invalidClaimTitle => 'Invalid Claim';
  @override
  String get invalidRequestBody =>
      'You cannot claim rewards before meetup finishes. Please ensure the meeting completed.';
  @override
  String get invalidRequestTitle => 'Invalid Request';
  @override
  String get invalidTransactionBody =>
      'Your transaction has failed due to insufficient funds. Please ensure that you have sufficient account balance to complete the transaction.';
  @override
  String get invalidTransactionTitle => 'Invalid Transaction';
  @override
  String get lowPriorityBody =>
      'Your transaction has a low priority and cannot replace another transaction already in the pool. Please wait for the previous transaction to complete before submitting a new one.';
  @override
  String get lowPriorityTitle => 'Low Priority';
  @override
  String get rewardsIssuedBody =>
      'Rewards for this claim have already been issued. Please do not attempt to submit the same claim again.';
  @override
  String get rewardsIssuedTitle => 'Rewards Issued';
}

class TranslationsDeTransaction implements TranslationsTransaction {
  @override
  String get endorseNewcomerNotificationBody => 'Danke für das Endorsen des Newbies!';
  @override
  String get endorseNewcomerNotificationTitle => 'Newbie endorsed';
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
      'Du hast dich abgemeldet vom nächsten Cycle. Du kannst dich wider anmelden, wenn du es dir anders überlegst.';
  @override
  String get unregisterParticipantNotificationTitle => 'Registrierung storniert';
  @override
  String get alreadyEndorsedBody =>
      'Sie haben diesen Teilnehmer bereits befürwortet. Bitte versuchen Sie nicht, denselben Teilnehmer mehr als einmal zu befürworten.';
  @override
  String get alreadyEndorsedTitle => 'Bereits befürwortet';
  @override
  String get invalidClaimBody =>
      'Ansprüche können erst gestellt werden, nachdem alle Teilnehmer alle gescannt haben. Bitte stellen Sie sicher, dass Sie alle Teilnehmer gescannt und Ansprüche geltend gemacht haben.';
  @override
  String get invalidClaimTitle => 'Ungültiger Anspruch';
  @override
  String get invalidRequestBody =>
      'Sie können Belohnungen nicht beanspruchen, bevor das Treffen beendet ist. Bitte stellen Sie sicher, dass das Meeting abgeschlossen ist.';
  @override
  String get invalidRequestTitle => 'Ungültige Anfrage';
  @override
  String get invalidTransactionBody =>
      ' Ihre Transaktion ist aufgrund unzureichender Mittel fehlgeschlagen. Stellen Sie bitte sicher, dass Sie ausreichend Kontoguthaben haben, um die Transaktion abzuschließen.';
  @override
  String get invalidTransactionTitle => 'Ungültige Transaktion';
  @override
  String get lowPriorityBody =>
      'Ihre Transaktion hat eine niedrige Priorität und kann keine andere bereits im Pool befindliche Transaktion ersetzen. Bitte warten Sie, bis die vorherige Transaktion abgeschlossen ist, bevor Sie eine neue senden.';
  @override
  String get lowPriorityTitle => 'Niedrige Priorität';
  @override
  String get rewardsIssuedBody =>
      'Die Belohnungen für diesen Anspruch wurden bereits ausgegeben. Bitte versuchen Sie nicht, denselben Anspruch erneut einzureichen.';
  @override
  String get rewardsIssuedTitle => 'Belohnungen ausgegeben';
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
      "Tu t'es désinscrit du prochain cycle. Tu peux te réinscrire si tu changes d'avis.";
  @override
  String get unregisterParticipantNotificationTitle => 'Inscription annulée';
  @override
  String get alreadyEndorsedBody =>
      "Vous avez déjà approuvé ce participant. Veuillez ne pas essayer d'approuver le même participant plus d'une fois.";
  @override
  String get alreadyEndorsedTitle => 'Déjà Endossé';
  @override
  String get invalidClaimBody =>
      "Les demandes peuvent être soumises après que tous les participants ont scanné tout le monde. Veuillez vous assurer d'avoir scanné tous les participants et appuyé sur les réclamations.";
  @override
  String get invalidClaimTitle => 'Réclamation invalide';
  @override
  String get invalidRequestBody =>
      'Vous ne pouvez pas réclamer de récompenses avant la fin de la rencontre. Veuillez vous assurer que la réunion est terminée.';
  @override
  String get invalidRequestTitle => 'Demande invalide';
  @override
  String get invalidTransactionBody =>
      "Votre transaction a échoué en raison de fonds insuffisants. Veuillez vous assurer que vous disposez d'un solde de compte suffisant pour effectuer la transaction.";
  @override
  String get invalidTransactionTitle => 'Transaction invalide';
  @override
  String get lowPriorityBody =>
      "Votre transaction a une faible priorité et ne peut pas remplacer une autre transaction déjà dans le pool. Veuillez attendre que la transaction précédente soit terminée avant d'en soumettre une nouvelle.";
  @override
  String get lowPriorityTitle => 'Priorité faible';
  @override
  String get rewardsIssuedBody =>
      'Les récompenses pour cette réclamation ont déjà été émises. Veuillez ne pas essayer de soumettre la même réclamation à nouveau.';
  @override
  String get rewardsIssuedTitle => 'Récompenses émises';
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
  @override
  String get alreadyEndorsedBody =>
      'Вы уже подтвердили участника. Пожалуйста, не пытайтесь подтвердить того же участника более одного раза.';
  @override
  String get alreadyEndorsedTitle => 'Уже подтверждено';
  @override
  String get invalidClaimBody =>
      'Запросы на вознаграждения могут быть отправлены после того, как все участники отсканировали всех. Пожалуйста, убедитесь, что вы отсканировали всех участников и нажали на запросы на вознаграждения.';
  @override
  String get invalidClaimTitle => 'Недействительный запрос на вознаграждение';
  @override
  String get invalidRequestBody =>
      'Вы не можете запросить вознаграждение до завершения встречи. Пожалуйста, убедитесь, что встреча завершена.';
  @override
  String get invalidRequestTitle => 'Недействительный запрос';
  @override
  String get invalidTransactionBody =>
      'Ваша транзакция не удалась из-за недостаточных средств. Пожалуйста, убедитесь, что у вас достаточный баланс на счете для завершения транзакции.';
  @override
  String get invalidTransactionTitle => 'Ошибка недействительной транзакции';
  @override
  String get lowPriorityBody =>
      'Ваша транзакция имеет низкий приоритет и не может заменить другую транзакцию, уже находящуюся в пуле. Пожалуйста, подождите, пока предыдущая транзакция завершится, прежде чем отправлять новую.';
  @override
  String get lowPriorityTitle => 'Низкий приоритет';
  @override
  String get rewardsIssuedBody =>
      'Вознаграждения за этот запрос уже были выданы. Пожалуйста, не пытайтесь повторно отправлять тот же запрос.';
  @override
  String get rewardsIssuedTitle => 'Выданы вознаграждения';
}
