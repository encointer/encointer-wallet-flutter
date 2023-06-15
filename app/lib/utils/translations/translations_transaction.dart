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
  String get balanceTooLowTitle;
  String get balanceTooLowBody;
  String get transactionError;
  String get received;
  String get sent;
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
  String get alreadyEndorsedErrorBody => 'This account has already been endorsed for this cycle.';
  @override
  String get alreadyEndorsedErrorTitle => 'Already Endorsed';
  @override
  String get noValidClaimsErrorBody => 'You did not send any valid claims. Did you scan the other attendees?';
  @override
  String get noValidClaimsErrorTitle => 'No Valid Claims';
  @override
  String get votesNotDependableErrorBody =>
      "Only half or less of the assigned participants were attested for this gathering. It could also be that some attendees haven't submitted their attestation yet. This prevents the early payout, and you need to wait for 48 hours.";
  @override
  String get votesNotDependableErrorTitle => 'Votes not dependable';
  @override
  String get insufficientFundsErrorBody =>
      'You do not have sufficient funds on this account. See on the website of your local community how to get some.';
  @override
  String get insufficientFundsErrorTitle => 'Insufficient Funds';
  @override
  String get txTooLowPriorityErrorBody =>
      'Technical transaction priority error. This can happen if you tap twice on a submit button very quickly. Please wait for a few seconds.';
  @override
  String get txTooLowPriorityErrorTitle => 'Transaction priority error';
  @override
  String get rewardsAlreadyIssuedErrorBody =>
      'Another attendee has triggered the payout for this gathering. You should have received your income already.';
  @override
  String get rewardsAlreadyIssuedErrorTitle => 'Rewards already issued';
  @override
  String get transactionError => 'Transaction error';
  @override
  String get balanceTooLowBody =>
      "You don't have sufficient funds in your account. You can't send all your money because you need some for the fees.";
  @override
  String get balanceTooLowTitle => 'Balance too low';
  @override
  String get received => 'Received';
  @override
  String get sent => 'Sent';
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
  String get alreadyEndorsedErrorBody => 'Dieses Konto wurde bereits für diesen Key-Signing Cycle endorsed.';
  @override
  String get alreadyEndorsedErrorTitle => 'Bereits endorsed';
  @override
  String get noValidClaimsErrorBody =>
      'Keine gültigen Bestätigungen wurden eingereicht. Hast du andere Teilnehmer gescannt?';
  @override
  String get noValidClaimsErrorTitle => 'Keine gültigen Bestätigungen';
  @override
  String get votesNotDependableErrorBody =>
      'Es wurde nur die Hälfte oder weniger der zugewiesenen Teilnehmer bestätigt, oder einige Teilnehmer haben ihre Bestätigungen noch nicht eingereicht. Das verhindert das sofortige Auszahlen des Einkommens und du musst 48 Stunden warten.';
  @override
  String get votesNotDependableErrorTitle => 'Unzureichende Bestätigungen';
  @override
  String get insufficientFundsErrorBody =>
      'Du hast nicht genügend Geld auf diesem Konto. Schaue auf der Webseite deiner lokalen Gemeinschaft, wie du welches bekommen kannst.';
  @override
  String get insufficientFundsErrorTitle => 'Zu wenig Guthaben';
  @override
  String get txTooLowPriorityErrorBody =>
      'Technischer Transaktionsfehler. Das kann passieren, wenn du zweimal innerhalb sehr kurzer Zeit eine Transaktion abschickst. Bitte warte einige Sekunden.';
  @override
  String get txTooLowPriorityErrorTitle => 'Transaktions Prioritätsfehler';
  @override
  String get rewardsAlreadyIssuedErrorBody =>
      'Ein anderer Teilnehmer hat die Auszahlung für dieses Treffen ausgelöst. Du solltest dein Einkommen bereits erhalten haben.';
  @override
  String get rewardsAlreadyIssuedErrorTitle => 'Einkommen bereits ausgezahlt';
  @override
  String get transactionError => 'Transaktionsfehler';
  @override
  String get balanceTooLowBody =>
      'Du hast nicht genug Geld auf dem Konto. Du kannst nicht dein ganzes Geld schicken, weil du noch ein wenig für die Gebühren brauchst.';
  @override
  String get balanceTooLowTitle => 'Kontostand zu tief';
  @override
  String get received => 'Empfangen';
  @override
  String get sent => 'Gesendet';
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
  String get alreadyEndorsedErrorBody => 'Ce compte a déjà été endossé pour ce cycle';
  @override
  String get alreadyEndorsedErrorTitle => 'Déjà endossé';
  @override
  String get noValidClaimsErrorBody =>
      "Vous n'avez pas envoyé de confirmations valables. As-tu scanné les autres participants?";
  @override
  String get noValidClaimsErrorTitle => 'Pas de confirmations valides';
  @override
  String get votesNotDependableErrorBody =>
      "Seule la moitié ou moins des participants attribués ont été confirmés, ou certains participants n'ont pas encore envoyé leurs confirmations. Cela empêche le paiement immédiat du revenu et tu dois attendre 48 heures.";
  @override
  String get votesNotDependableErrorTitle => 'Confirmations insuffisantes';
  @override
  String get insufficientFundsErrorBody =>
      "Tu n'as pas assez d'argent sur ce compte. Regarde sur le site web de ta communauté locale pour savoir comment en obtenir.";
  @override
  String get insufficientFundsErrorTitle => 'Trop peu de crédit';
  @override
  String get txTooLowPriorityErrorBody =>
      "Erreur technique de transaction. Cela peut arriver si tu envoies deux fois une transaction dans un laps de temps très court. Veuillez patienter quelques secondes'.";
  @override
  String get txTooLowPriorityErrorTitle => 'Erreur de priorité de transaction';
  @override
  String get rewardsAlreadyIssuedErrorBody =>
      'Un autre participant a déclenché le paiement pour cette rencontre. Tu devrais avoir déjà reçu ton revenu.';
  @override
  String get rewardsAlreadyIssuedErrorTitle => 'Revenu déjà versé';
  @override
  String get transactionError => 'Erreur de transaction';
  @override
  String get balanceTooLowBody =>
      "Tu n'as pas assez d'argent sur ton compte. Tu ne peux pas envoyer tout ton argent, car il t'en faut encore un peu pour payer les frais.";
  @override
  String get balanceTooLowTitle => 'Solde trop bas';
  @override
  String get received => 'Reçu';
  @override
  String get sent => 'Envoyé';
}

class TranslationsRuTransaction implements TranslationsTransaction {
  @override
  String get endorseNewcomerNotificationBody => 'Благодарим за одобрение новичка в нашем сообществе!';
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
  String get alreadyEndorsedErrorBody => 'Этот аккаунт уже был подтвержден в этом цикле.';
  @override
  String get alreadyEndorsedErrorTitle => 'Уже подтверждено';
  @override
  String get noValidClaimsErrorBody =>
      'Вы не отправили никаких действительных требований. Вы проверили наличие других участников?';
  @override
  String get noValidClaimsErrorTitle => 'Нет действительных требований';
  @override
  String get votesNotDependableErrorBody =>
      'Назначенных участников собрания подтвердили только половину или менее. Также возможно, что некоторые участники еще не представили свое подтверждение. Это мешает достижению ранней выплаты, и вам нужно подождать 48 часов.';
  @override
  String get votesNotDependableErrorTitle => 'Голоса недостоверны';
  @override
  String get insufficientFundsErrorBody =>
      'У вас недостаточно средств на этом аккаунте. Посмотрите на веб-сайте вашего местного сообщества, как их получить.';
  @override
  String get insufficientFundsErrorTitle => 'Недостаточно средств';
  @override
  String get txTooLowPriorityErrorBody =>
      'Техническая ошибка приоритета транзакции. Это может произойти, если вы быстро дважды нажмете на кнопку отправки. Пожалуйста, подождите несколько секунд.';
  @override
  String get txTooLowPriorityErrorTitle => 'Техническая ошибка приоритета транзакции';
  @override
  String get rewardsAlreadyIssuedErrorBody =>
      'Другой участник инициировал выплату за это собрание. Вы уже должны были получить свой доход.';
  @override
  String get rewardsAlreadyIssuedErrorTitle => 'Вознаграждения уже выданы';
  @override
  String get transactionError => 'Ошибка транзакции';
  @override
  String get balanceTooLowBody =>
      'У вас недостаточно средств на счету. Вы не можете отправить все свои деньги, так как часть нужна для оплаты комиссии.';
  @override
  String get balanceTooLowTitle => 'Недостаточно средств на счете';
  @override
  String get received => 'Получено';
  @override
  String get sent => 'Отправлено';
}
