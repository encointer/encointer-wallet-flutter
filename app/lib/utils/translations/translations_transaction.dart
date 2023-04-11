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
  String get insufficientFundsErrorTitle;
  String get insufficientFundsErrorBody;
  String get alreadyEndorsedErrorTitle;
  String get alreadyEndorsedErrorBody;
  String get votesNotDependableErrorTitle;
  String get votesNotDependableErrorBody;
  String get noValidClaimsErrorTitle;
  String get noValidClaimsErrorBody;
  String get txTooLowPriorityErrorTitle;
  String get txTooLowPriorityErrorBody;
  String get rewardsAlreadyIssuedErrorTitle;
  String get rewardsAlreadyIssuedErrorBody;
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
  String get alreadyEndorsedErrorBody =>
      'You have already endorsed this participant. Please do not attempt to endorse the same participant more than once.';
  @override
  String get alreadyEndorsedErrorTitle => 'Already Endorsed';
  @override
  String get noValidClaimsErrorBody =>
      'Claims can be submitted after all attendees have scanned everyone. Please ensure that you have scanned all attendees and tapped on claims.';
  @override
  String get noValidClaimsErrorTitle => 'Invalid Claim';
  @override
  String get votesNotDependableErrorBody =>
      'You cannot claim rewards before meetup finishes. Please ensure the meeting completed.';
  @override
  String get votesNotDependableErrorTitle => 'Invalid Request';
  @override
  String get insufficientFundsErrorBody =>
      'You do not have sufficient funds on this account. See on the website of your local community how to get some.';
  @override
  String get insufficientFundsErrorTitle => 'Transaction error';
  @override
  String get txTooLowPriorityErrorBody =>
      'Your transaction has a low priority and cannot replace another transaction already in the pool. Please wait for the previous transaction to complete before submitting a new one.';
  @override
  String get txTooLowPriorityErrorTitle => 'Low Priority';
  @override
  String get rewardsAlreadyIssuedErrorBody =>
      'Rewards for this claim have already been issued. Please do not attempt to submit the same claim again.';
  @override
  String get rewardsAlreadyIssuedErrorTitle => 'Rewards Issued';
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
  String get alreadyEndorsedErrorBody =>
      'Sie haben diesen Teilnehmer bereits befürwortet. Bitte versuchen Sie nicht, denselben Teilnehmer mehr als einmal zu befürworten.';
  @override
  String get alreadyEndorsedErrorTitle => 'Bereits befürwortet';
  @override
  String get noValidClaimsErrorBody =>
      'Ansprüche können erst gestellt werden, nachdem alle Teilnehmer alle gescannt haben. Bitte stellen Sie sicher, dass Sie alle Teilnehmer gescannt und Ansprüche geltend gemacht haben.';
  @override
  String get noValidClaimsErrorTitle => 'Ungültiger Anspruch';
  @override
  String get votesNotDependableErrorBody =>
      'Sie können Belohnungen nicht beanspruchen, bevor das Treffen beendet ist. Bitte stellen Sie sicher, dass das Meeting abgeschlossen ist.';
  @override
  String get votesNotDependableErrorTitle => 'Ungültige Anfrage';
  @override
  String get insufficientFundsErrorBody =>
      'Du hast nicht genügend Geld auf diesem Konto. Schaue auf der Webseite deiner lokalen gemeinschaft, wie du welches bekommen kannst.';
  @override
  String get insufficientFundsErrorTitle => 'Transaktionsfehler';
  @override
  String get txTooLowPriorityErrorBody =>
      'Ihre Transaktion hat eine niedrige Priorität und kann keine andere bereits im Pool befindliche Transaktion ersetzen. Bitte warten Sie, bis die vorherige Transaktion abgeschlossen ist, bevor Sie eine neue senden.';
  @override
  String get txTooLowPriorityErrorTitle => 'Niedrige Priorität';
  @override
  String get rewardsAlreadyIssuedErrorBody =>
      'Die Belohnungen für diesen Anspruch wurden bereits ausgegeben. Bitte versuchen Sie nicht, denselben Anspruch erneut einzureichen.';
  @override
  String get rewardsAlreadyIssuedErrorTitle => 'Belohnungen ausgegeben';
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
  String get alreadyEndorsedErrorBody =>
      "Vous avez déjà approuvé ce participant. Veuillez ne pas essayer d'approuver le même participant plus d'une fois.";
  @override
  String get alreadyEndorsedErrorTitle => 'Déjà Endossé';
  @override
  String get noValidClaimsErrorBody =>
      "Les demandes peuvent être soumises après que tous les participants ont scanné tout le monde. Veuillez vous assurer d'avoir scanné tous les participants et appuyé sur les réclamations.";
  @override
  String get noValidClaimsErrorTitle => 'Réclamation invalide';
  @override
  String get votesNotDependableErrorBody =>
      'Vous ne pouvez pas réclamer de récompenses avant la fin de la rencontre. Veuillez vous assurer que la réunion est terminée.';
  @override
  String get votesNotDependableErrorTitle => 'Demande invalide';
  @override
  String get insufficientFundsErrorBody =>
      "Tu n'as pas assez d'argent sur ce compte. Regarde sur le site web de ta communauté locale pour savoir comment en obtenir.";
  @override
  String get insufficientFundsErrorTitle => 'Erreur de transaction.';
  @override
  String get txTooLowPriorityErrorBody =>
      "Votre transaction a une faible priorité et ne peut pas remplacer une autre transaction déjà dans le pool. Veuillez attendre que la transaction précédente soit terminée avant d'en soumettre une nouvelle.";
  @override
  String get txTooLowPriorityErrorTitle => 'Priorité faible';
  @override
  String get rewardsAlreadyIssuedErrorBody =>
      'Les récompenses pour cette réclamation ont déjà été émises. Veuillez ne pas essayer de soumettre la même réclamation à nouveau.';
  @override
  String get rewardsAlreadyIssuedErrorTitle => 'Récompenses émises';
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
  String get alreadyEndorsedErrorBody =>
      'Вы уже подтвердили участника. Пожалуйста, не пытайтесь подтвердить того же участника более одного раза.';
  @override
  String get alreadyEndorsedErrorTitle => 'Уже подтверждено';
  @override
  String get noValidClaimsErrorBody =>
      'Запросы на вознаграждения могут быть отправлены после того, как все участники отсканировали всех. Пожалуйста, убедитесь, что вы отсканировали всех участников и нажали на запросы на вознаграждения.';
  @override
  String get noValidClaimsErrorTitle => 'Недействительный запрос на вознаграждение';
  @override
  String get votesNotDependableErrorBody =>
      'Вы не можете запросить вознаграждение до завершения встречи. Пожалуйста, убедитесь, что встреча завершена.';
  @override
  String get votesNotDependableErrorTitle => 'Недействительный запрос';
  @override
  String get insufficientFundsErrorBody =>
      'У вас недостаточно средств на этом счете. Смотрите на сайте вашей местной общины, как получить вознаграждение';
  @override
  String get insufficientFundsErrorTitle => 'Ошибка транзакции';
  @override
  String get txTooLowPriorityErrorBody =>
      'Ваша транзакция имеет низкий приоритет и не может заменить другую транзакцию, уже находящуюся в пуле. Пожалуйста, подождите, пока предыдущая транзакция завершится, прежде чем отправлять новую.';
  @override
  String get txTooLowPriorityErrorTitle => 'Низкий приоритет';
  @override
  String get rewardsAlreadyIssuedErrorBody =>
      'Вознаграждения за этот запрос уже были выданы. Пожалуйста, не пытайтесь повторно отправлять тот же запрос.';
  @override
  String get rewardsAlreadyIssuedErrorTitle => 'Выданы вознаграждения';
}
