/// contains translations for Encointer
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsEncointer {
  String get registerParticipant;
  String get claimsSubmit;
  String get claimsSubmitN;
  String get claimsPurge;
  String get claimsPurgeConfirm;
  String get keySigningCycle;
  String get countParticipants;
  String get nextCycleTimeLeft;
  String get nextCycleDateLabel;
  String get claimQr;
  String get claimsScanned;
  String get claimsScannedAlready;
  String get claimsScannedDecodeFailed;
  String get claimsScannedNew;
  String get claimsScannedNOfM;
  String get claimsSubmitDetail;
  String get communities;
  String get noCommunitiesAreYouOffline;
  String get meetupAttended;
  String get meetupClaimantInvalid;
  String get meetupClaimantEqualToSelf;
  String get meetupLocation;
  String get startGathering;
  String get alreadyRegistered;
  String get registerUntil;
  String get meetingPoint;
  String get gatheringIsOver;
  String get today;
  String get tomorrow;
  String get calendarEntryDescription;
  String get youAreNotRegistered;
  String get howManyParticipantsShowedUp;
  String get cycleWillTakePlaceOn;
  String get gatheringSuccessfullyCompleted;
  String get fetchingReputations;
  String get youAreRegisteredAs;
  String get youAreNotRegisteredPleaseRegisterNextTime;
  String get youAreAssignedToAGatheringWithNParticipants;
  String get successfullySentNAttestations;
  String get numberOfAttendees;
  String get next;
  String get closeGathering;
  String get count;
  String get scan;
  String get scanDescriptionForMeetup;
  String get scanOthers;
  String get finish;
  String get thankYou;
  String get weHopeToSeeYouAtTheNextGathering;
  String get goToLeuZurich;
  String get leuZurichFAQ;
  String get newbieTitle;
  String get newbieContent;
  String get endorseeTitle;
  String get endorseeContent;
  String get reputableTitle;
  String get reputableContent;
  String get bootstrapperTitle;
  String get bootstrapperContent;
  String get remainingNewbieTicketsAsReputable;
  String get remainingNewbieTicketsAsBootStrapper;
  String get onlyReputablesCanEndorseAttendGatheringToBecomeOne;
  String get meetupNotificationOneDayBeforeTitle;
  String get meetupNotificationOneDayBeforeContent;
  String get meetupNotificationOneHourBeforeTitle;
  String get meetupNotificationOneHourBeforeContent;
  String get showRouteMeetupLocation;
  String get registeringPhaseReminderTitle;
  String get registeringPhaseReminderContent;
  String get registeringLastDayOfRegisteringReminderTitle;
  String get registeringLastDayOfRegisteringReminderContent;
  String get offlineMessage;
}

class TranslationsEnEncointer implements TranslationsEncointer {
  @override
  String get registerParticipant => 'Register';
  @override
  String get claimsSubmit => 'Submit claims';
  @override
  String get claimsSubmitN => 'Submit N_COUNT claims';
  @override
  String get claimsPurge => 'Purge previously scanned claims';
  @override
  String get claimsPurgeConfirm => 'Are you sure, you want to purge all scanned claims?';
  @override
  String get keySigningCycle => 'Key-Signing Cycle';
  @override
  String get nextCycleTimeLeft => 'Next cycle is in';
  @override
  String get nextCycleDateLabel => 'Next cycle is on';
  @override
  String get claimQr => 'My Claim of Attendance';
  @override
  String get claimsScanned => 'You have scanned AMOUNT_PLACEHOLDER claims';
  @override
  String get claimsScannedAlready => 'Updated previously scanned claim';
  @override
  String get claimsScannedDecodeFailed => 'Could not decode scanned claim. The other party needs to update the App.';
  @override
  String get claimsScannedNew => 'Scanned new claim';
  @override
  String get claimsScannedNOfM => 'Scanned SCANNED_COUNT / TOTAL_COUNT Claims';
  @override
  String get claimsSubmitDetail => 'Submitting AMOUNT claims for the recent gathering';
  @override
  String get communities => 'Communities';
  @override
  String get noCommunitiesAreYouOffline => 'No communities were found. You can choose one later. Are you offline?.';
  @override
  String get meetupAttended => 'Attended last meetup';
  @override
  String get meetupClaimantInvalid => 'This claimant is not part of the meetup. Claim is not stored.';
  @override
  String get meetupClaimantEqualToSelf => 'Error: Claimant is equal to self. Claim is not stored.';
  @override
  String get meetupLocation => 'Meetup Location';
  @override
  String get startGathering => 'Start gathering';
  @override
  String get alreadyRegistered => 'Already Registered';
  @override
  String get registerUntil => 'Register before';
  @override
  String get meetingPoint => 'Meeting Point';
  @override
  String get gatheringIsOver => 'The gathering is over';
  @override
  String get today => 'Today';
  @override
  String get tomorrow => 'Tomorrow';
  @override
  String get calendarEntryDescription => 'Gathering to get your community income';
  @override
  String get youAreNotRegistered => 'You are not registered for a gathering for the selected community on:';
  @override
  String get howManyParticipantsShowedUp => 'How many attendees are present including yourself?';
  @override
  String get cycleWillTakePlaceOn => 'The key-signing cycle will take place on';
  @override
  String get gatheringSuccessfullyCompleted => 'Gathering successfully completed';
  @override
  String get fetchingReputations => 'Checking if you have reputation';
  @override
  String get youAreRegisteredAs => 'You have registered for the next gathering as PARTICIPANT_TYPE.';
  @override
  String get youAreNotRegisteredPleaseRegisterNextTime =>
      "You haven't been assigned for this key-signing cycle. Please join the next cycle to receive your community income.";
  @override
  String get youAreAssignedToAGatheringWithNParticipants => 'You are assigned to a gathering with P_COUNT people.';
  @override
  String get successfullySentNAttestations => 'You have successfully submitted attestations for P_COUNT other people.';
  @override
  String get countParticipants => 'Count';
  @override
  String get numberOfAttendees => 'Number of attendees';
  @override
  String get next => 'Next';
  @override
  String get closeGathering => 'Close meetup';
  @override
  String get count => 'Count';
  @override
  String get scan => 'Scan';
  @override
  String get scanDescriptionForMeetup => 'Every attendee must scan and be scanned by everyone else.';
  @override
  String get scanOthers => 'Scan others';
  @override
  String get finish => 'Finish';
  @override
  String get thankYou => 'Thank you';
  @override
  String get weHopeToSeeYouAtTheNextGathering => 'We hope to see you at the next gathering.';
  @override
  String get goToLeuZurich => 'Open leu.zuerich';
  @override
  String get leuZurichFAQ => 'leu.zuerich FAQ';
  @override
  String get bootstrapperContent =>
      'If you have endorsement tickets left, please consider endorsing newbies to help the community grow.';
  @override
  String get bootstrapperTitle => 'Registered as bootstrapper - your seat is guaranteed.';
  @override
  String get endorseeContent =>
      'You have been endorsed as a trustworthy community member. Hence, you are guaranteed to be assigned to a '
      'gathering this cycle.';
  @override
  String get endorseeTitle => 'Registered as endorsee - your seat is guaranteed';
  @override
  String get newbieContent =>
      "You registered as a newbie without previous reputation. We can't guarantee that you will be assigned to a "
      'gathering this cycle if there are many newbies. Please check your assignment status on the day before the cycle '
      'to learn if and where your gathering will take place.';
  @override
  String get newbieTitle => 'Registered as newbie - your seat is not definite';
  @override
  String get reputableContent =>
      'You used your reputation to get a guaranteed seat. Caution: Should you register, but not show up at the cycle,'
      ' you become a newbie again.';
  @override
  String get reputableTitle => 'Registered as reputable - your seat is guaranteed';
  @override
  String get remainingNewbieTicketsAsReputable => 'Remaining newbie tickets as reputable:';
  @override
  String get remainingNewbieTicketsAsBootStrapper => 'Remaining newbie tickets as bootsrapper:';
  @override
  String get onlyReputablesCanEndorseAttendGatheringToBecomeOne =>
      'Only reputables can endorse. Attend a gathering to get reputation!';
  @override
  String get meetupNotificationOneDayBeforeContent => 'Gathering starts in 24 hours';
  @override
  String get meetupNotificationOneDayBeforeTitle => '24 hours left';
  @override
  String get meetupNotificationOneHourBeforeContent => 'Gathering starts in one hour';
  @override
  String get meetupNotificationOneHourBeforeTitle => '1 hour left';
  @override
  String get showRouteMeetupLocation => 'Show route';
  @override
  String get registeringPhaseReminderContent => 'Registration for the next gathering has started.';
  @override
  String get registeringPhaseReminderTitle => 'Register now!';
  @override
  String get registeringLastDayOfRegisteringReminderContent => 'Registration for the next gathering ends today.';
  @override
  String get registeringLastDayOfRegisteringReminderTitle => 'Register now!';
  @override
  String get offlineMessage => 'You are currently offline. Your claims can be submitted later on the Home Screen.';
}

class TranslationsDeEncointer implements TranslationsEncointer {
  @override
  String get registerParticipant => 'Registrieren';
  @override
  String get claimsSubmit => 'Anträge einreichen';
  @override
  String get claimsSubmitN => 'N_COUNT Anträge einreichen';
  @override
  String get claimsPurge => 'Bereits gescannte Anträge löschen';
  @override
  String get claimsPurgeConfirm => 'Bist du sicher, dass du alle gescannte Anträge löschen möchtest?';
  @override
  String get keySigningCycle => 'Key-Signing Cycle';
  @override
  String get nextCycleTimeLeft => 'Nächster Cycle ist in';
  @override
  String get nextCycleDateLabel => 'Nächster Cycle:';
  @override
  String get claimQr => 'Mein Antrag auf Anwesenheitsbestätigung';
  @override
  String get claimsScanned => 'Du hast AMOUNT_PLACEHOLDER Anträge gescannt';
  @override
  String get claimsScannedAlready => 'bereits gescannter Antrag wurde aktualisiert';
  @override
  String get claimsScannedDecodeFailed =>
      'Gescannter Antrag konnte nicht dekodiert werden. Dein Gegenüber muss die App updaten.';
  @override
  String get claimsScannedNew => 'Neuer Antrag gescannt';
  @override
  String get claimsScannedNOfM => 'SCANNED_COUNT / TOTAL_COUNT gescannte Anträge';
  @override
  String get claimsSubmitDetail => 'Reiche AMOUNT Bezeugungen für diese Versammlung ein';
  @override
  String get communities => 'Gemeinschaften';
  @override
  String get noCommunitiesAreYouOffline =>
      'Keine Gemeinschaften gefunden. Du kannst später eine auswählen. Bist du offline?';
  @override
  String get meetupAttended => 'An der letzen Versammlung teilgenommen';
  @override
  String get meetupClaimantInvalid =>
      'Diese* Antragssteller*in gehört nicht zu deiner Versammlung. Antrag wurde nicht gespeichert.';
  @override
  String get meetupClaimantEqualToSelf => 'Fehler, Addresse ist aktueller account. Antrag wurde nicht gespeichert.';
  @override
  String get meetupLocation => 'Treffpunkt';
  @override
  String get startGathering => 'Versammlung starten';
  @override
  String get alreadyRegistered => 'Bereits registriert';
  @override
  String get registerUntil => 'Registriere dich vor dem';
  @override
  String get meetingPoint => 'Treffpunkt';
  @override
  String get gatheringIsOver => 'Die Versammung ist vorbei';
  @override
  String get today => 'Heute';
  @override
  String get tomorrow => 'Morgen';
  @override
  String get calendarEntryDescription => 'Nimm an der Versammlung teil um dein Einkommen zu erhalten';
  @override
  String get youAreNotRegistered => 'Du bist leider keiner Versammlung zugewiesen worden am';
  @override
  String get howManyParticipantsShowedUp => 'Wieviele Teilnehmende sind da inklusive dir?';
  @override
  String get cycleWillTakePlaceOn => 'Der Key-Signing Cycle wird stattfinden am';
  @override
  String get gatheringSuccessfullyCompleted => 'Versammlung erfolgreich durchgeführt';
  @override
  String get fetchingReputations => 'Es wird überprüft, ob du bereits Reputation hast';
  @override
  String get youAreRegisteredAs => 'Du hast dich für die nächste Versammlung als PARTICIPANT_TYPE registriert.';
  @override
  String get youAreNotRegisteredPleaseRegisterNextTime =>
      'Du wurdest nicht für diesen Key-Signing Cycle zugewiesen. Bitte registriere dich für den nächsten Cycle um dein Gemeinschaftseinkommen zu erhalten.';
  @override
  String get youAreAssignedToAGatheringWithNParticipants => 'Du bist einer Versammlung mit P_COUNT Leuten zugewiesen.';
  @override
  String get successfullySentNAttestations => 'Du hast erfolgreich Bezeugungen für P_COUNT andere Leute eingereicht.';
  @override
  String get countParticipants => 'Zähle';
  @override
  String get numberOfAttendees => 'Anzahl Teilnehmende';
  @override
  String get next => 'Weiter';
  @override
  String get closeGathering => 'Versammlung schliessen';
  @override
  String get count => 'Zähle';
  @override
  String get scan => 'Scannen';
  @override
  String get scanDescriptionForMeetup => 'Jede* Anwesende muss alle anderen scannen, und von allen gescannt werden.';
  @override
  String get scanOthers => 'Andere scannen';
  @override
  String get finish => 'Beenden';
  @override
  String get thankYou => 'Danke';
  @override
  String get weHopeToSeeYouAtTheNextGathering => 'Wir hoffen dich an der nächsten Versammlung wiederzusehen.';
  @override
  String get goToLeuZurich => 'leu.zuerich öffnen';
  @override
  String get leuZurichFAQ => 'leu.zuerich FAQ';
  @override
  String get bootstrapperContent =>
      'Wenn Du noch Endorsement-Tickets übrig hast, vergiss nicht Newbies zu als vertrauenswürdig zu bestätigen.';
  @override
  String get bootstrapperTitle => 'Als Bootstrapper registriert - Dein Platz ist garantiert.';
  @override
  String get endorseeContent =>
      'Du wurdest von einem Bootstrapper als vertrauenswürdiges Mitglied bestätigt. Deswegen ist dein Sitz garantiert.';
  @override
  String get endorseeTitle => 'Als Endorsee registriert - Dein Platz is garantiert.';
  @override
  String get newbieContent =>
      'Du hast dich als Newbie ohne bisherige Reputation registriert. Es ist nicht garantiert, dass du in diesem Cycle '
      'zugewiesen wirst, falls es viele Newbies hat. Bitte überprüfe deinen Zuweisungsstatus am Tag vor dem Cycle, um zu'
      ' erfahren, ob und wo deine Versammlung stattfinden wird.';
  @override
  String get newbieTitle => 'Als Newbie Registriert - Dein Platz ist noch nicht sicher.';
  @override
  String get reputableContent =>
      'Du hast deine Reputation genutzt um einen garantierten Platz zu erhalten. Achtung: Solltest Du dich anmelden,'
      ' aber nicht zur Versammlung erscheinen, wirst du wieder ein Newbie.';
  @override
  String get reputableTitle => 'Als Reputable registriert. Dein Platz ist garantiert';
  @override
  String get remainingNewbieTicketsAsReputable => 'Verbleibende Newbie Tickets als Reputable:';
  @override
  String get remainingNewbieTicketsAsBootStrapper => 'Verbleibende Newbie Tickets als Bootstrapper:';
  @override
  String get onlyReputablesCanEndorseAttendGatheringToBecomeOne =>
      'Nur Reputables können endorsen. Nimm an einem Treffen teil, um Reputation zu erhalten!';
  @override
  String get meetupNotificationOneDayBeforeContent => 'Treffen beginnt in 24 Stunden';
  @override
  String get meetupNotificationOneDayBeforeTitle => 'Noch 24 Stunden';
  @override
  String get meetupNotificationOneHourBeforeContent => 'Treffen beginnt in einer Stunde';
  @override
  String get meetupNotificationOneHourBeforeTitle => '1 Stunde übrig';
  @override
  String get showRouteMeetupLocation => 'Route anzeigen';
  @override
  String get registeringPhaseReminderContent => 'Die Anmeldung für das nächste Treffen hat begonnen.';
  @override
  String get registeringPhaseReminderTitle => 'Melde dich jetzt an!';
  @override
  String get registeringLastDayOfRegisteringReminderContent => 'Die Anmeldung für das nächste Treffen endet heute.';
  @override
  String get registeringLastDayOfRegisteringReminderTitle => 'Melde dich jetzt an!';
  @override
  String get offlineMessage =>
      'Sie sind derzeit offline. Sie können Ihre Ansprüche später auf dem Startbildschirm einreichen.';
}

class TranslationsFrEncointer implements TranslationsEncointer {
  @override
  String get registerParticipant => "S'inscrire";
  @override
  String get claimsSubmit => 'Déposer une demande';
  @override
  String get claimsSubmitN => 'Déposer N_COUNT des demandes.';
  @override
  String get claimsPurge => 'Supprimer les demandes déjà scannées.';
  @override
  String get claimsPurgeConfirm => 'Es-tu sûr de vouloir supprimer toutes les demandes scannées?';
  @override
  String get keySigningCycle => 'Cycle de signature de clé';
  @override
  String get nextCycleTimeLeft => 'Prochain cycle: dans';
  @override
  String get nextCycleDateLabel => 'Prochain cycle:';
  @override
  String get claimQr => "Ma demande d'attestation de présence";
  @override
  String get claimsScanned => 'Tu as scanné AMOUNT_PLACEHOLDER demandes.';
  @override
  String get claimsScannedAlready => 'La demande déjà scannée a été mise à jour';
  @override
  String get claimsScannedDecodeFailed =>
      "La demande scannée n'a pas pu être décodée. Ton vis-à-vis doit mettre à jour l'application.";
  @override
  String get claimsScannedNew => 'Nouvelle demande scannée';
  @override
  String get claimsScannedNOfM => 'SCANNED_COUNT / TOTAL_COUNT demandes scannées';
  @override
  String get claimsSubmitDetail => 'Dépose AMOUNT affirmations pour cette assemblée';
  @override
  String get meetupAttended => 'A participé à la dernière rencontre';
  @override
  String get meetupClaimantInvalid =>
      "L'auteur de la demande ne fait pas partie de ton rencontre. La demande n'a pas été enregistrée.";
  @override
  String get meetupClaimantEqualToSelf => "Erreur, l'adresse est le compte actuel. La demande n'a pas été enregistrée.";
  @override
  String get meetupLocation => 'Point de rencontre';
  @override
  String get startGathering => 'Démarrer la rencontre';
  @override
  String get alreadyRegistered => 'Déjà inscrit';
  @override
  String get communities => 'Communautés';
  @override
  String get noCommunitiesAreYouOffline =>
      "Aucune communauté n'a été trouvée. Tu pourras en choisir une plus tard. Tu es hors ligne ?";
  @override
  String get registerUntil => 'Inscrive-toi avant le';
  @override
  String get meetingPoint => 'Point de rencontre';
  @override
  String get gatheringIsOver => 'La rencontre est terminée';
  @override
  String get today => "Aujourd'hui";
  @override
  String get tomorrow => 'Demain';
  @override
  String get calendarEntryDescription => 'Participe à la rencontre pour recevoir ton paiement.';
  @override
  String get youAreNotRegistered => "Tu n'as malheureusement pas été attribué à une rencontre le";
  @override
  String get howManyParticipantsShowedUp => 'Combien de participants y a-t-il, toi y compris ';
  @override
  String get cycleWillTakePlaceOn => 'Le cycle de signature des clés aura lieu le';
  @override
  String get gatheringSuccessfullyCompleted => 'La rencontre a été un succès';
  @override
  String get fetchingReputations => 'Vérifier si tu as une réputation';
  @override
  String get youAreRegisteredAs => "Tu t'es inscrit comme PARTICIPANT_TYPE a la prochain rencontre.";
  @override
  String get youAreNotRegisteredPleaseRegisterNextTime => "Tu n'as pas été assigné à ce cycle de signature de clé. "
      "Si'il te plaît, inscris-toi pour le prochain cycle pour recevoir ton paiement de communauté.";
  @override
  String get youAreAssignedToAGatheringWithNParticipants =>
      'Tu es assigné à une rencontre avec des personnes de P_COUNT.';
  @override
  String get successfullySentNAttestations =>
      'Tu as soumis avec succès des attestations pour P_COUNT autres personnes.';
  @override
  String get countParticipants => 'Compte';
  @override
  String get numberOfAttendees => 'Nombre de participants';
  @override
  String get next => 'Continuer';
  @override
  String get closeGathering => 'Fermer la rencontre.';
  @override
  String get count => 'Compter';
  @override
  String get scan => 'Scanner';
  @override
  String get scanDescriptionForMeetup =>
      'Chaque personne présente doit scanner toutes les autres, et être scannée par toutes.';
  @override
  String get scanOthers => 'Scanner les autres';
  @override
  String get finish => 'Terminer';
  @override
  String get thankYou => 'Merci';
  @override
  String get weHopeToSeeYouAtTheNextGathering => 'Nous espérons te revoir à la prochaine rencontre';
  @override
  String get goToLeuZurich => 'Ouvrir leu.zuerich';
  @override
  String get leuZurichFAQ => 'leu.zuerich FAQ';
  @override
  String get bootstrapperContent =>
      "S'il te reste des tickets d'endossement, n'oublie pas de confirmer Novice comme digne de confiance.";
  @override
  String get bootstrapperTitle => 'Enregistré comme Bootstrapper - ta place est garantie.';
  @override
  String get endorseeContent =>
      'Tu as été confirmé comme membre de confiance par un Bootstrapper. Ta place est donc garantie.';
  @override
  String get endorseeTitle => 'Enregistré comme Endosser - Ta place est garantie.';
  @override
  String get newbieContent => "Tu t'es enregistré en tant que Novice Il n'est pas garanti que tu sois dans ce cycle "
      "Si le nombre de Novices est élevé, tu ne seras pas assigné. S'il te plaît, vérifie ton statut d'assignation le jour précédant le cycle pour savoir "
      'pour savoir si et où ta réunion aura lieu.';
  @override
  String get newbieTitle => "Enregistré comme Novice - Ta place n'est pas encore garantie";
  @override
  String get reputableContent =>
      '"Tu as utilisé ta réputation pour obtenir une place garantie. Attention : si tu t\'enregistres,'
      ' mais que tu ne te présentes pas à la réunion, tu redeviens un Novice".';
  @override
  String get reputableTitle => 'Enregistré en tant que Reputable. Ta place est garantie';
  @override
  String get remainingNewbieTicketsAsReputable => 'Comme Reputable les billets pour Novice restants:';
  @override
  String get remainingNewbieTicketsAsBootStrapper => 'Novice-Tickets restants en tant que bootstrapper';
  @override
  String get onlyReputablesCanEndorseAttendGatheringToBecomeOne =>
      'Seules les Reputables peuvent endosser. Participez à une réunion pour gagner de réputation!';
  @override
  String get meetupNotificationOneDayBeforeContent => 'Réunion commence dans 24h';
  @override
  String get meetupNotificationOneDayBeforeTitle => '24 heures restantes';
  @override
  String get meetupNotificationOneHourBeforeContent => 'Réunion commence dans une heure';
  @override
  String get meetupNotificationOneHourBeforeTitle => 'Encore 1 heure';
  @override
  String get showRouteMeetupLocation => 'Afficher la route';
  @override
  String get registeringPhaseReminderContent => "L'inscription pour la prochaine réunion a commencé.";
  @override
  String get registeringPhaseReminderTitle => 'Inscris-tois maintenant!';
  @override
  String get registeringLastDayOfRegisteringReminderContent =>
      "L'inscription pour la prochaine réunion se termine aujourd'hui.";
  @override
  String get registeringLastDayOfRegisteringReminderTitle => 'Inscris-tois maintenant!';
  @override
  String get offlineMessage =>
      "Vous êtes actuellement hors ligne. Vos demandes peuvent être soumises plus tard, sur l'écran d'accueil.";
}

class TranslationsRuEncointer implements TranslationsEncointer {
  @override
  String get registerParticipant => 'Регистрация';
  @override
  String get claimsSubmit => 'Подать заявление';
  @override
  String get claimsSubmitN => 'Подать N_COUNT заявление';
  @override
  String get claimsPurge => 'Очистить ранее отсканированные заявления';
  @override
  String get claimsPurgeConfirm => 'Вы уверены, что хотите удалить все ранее отсканированные заявления?';
  @override
  String get keySigningCycle => 'Цикл подписания ключей';
  @override
  String get nextCycleTimeLeft => 'Следующий цикл через ';
  @override
  String get nextCycleDateLabel => 'Следующий цикл';
  @override
  String get claimQr => 'Мое заявление на участие';
  @override
  String get claimsScanned => 'Вы отсканировали заявление AMOUNT_PLACEHOLDER ';
  @override
  String get claimsScannedAlready => 'Ранее отсканированные заявления обновлены';
  @override
  String get claimsScannedDecodeFailed => 'Отсканированные заявления не удалось расшифровать.';
  @override
  String get claimsScannedNew => 'Отсканировать новое заявление';
  @override
  String get claimsScannedNOfM => 'Отсканированные заявления SCANNED_COUNT / TOTAL_COUNT';
  @override
  String get claimsSubmitDetail => 'Подача заявлений на сумму AMOUNT за недавнее собрание';
  @override
  String get communities => 'Сообщества';
  @override
  String get noCommunitiesAreYouOffline =>
      'Сообщества не обнаружены. Позже вы можете выбрать одну из них. Вы в оффлайн режиме?';
  @override
  String get meetupAttended => 'Присутствовал на последней встрече';
  @override
  String get meetupClaimantInvalid => 'Этот заявитель не является участником встречи. Заявление не сохраняется.';
  @override
  String get meetupClaimantEqualToSelf => 'Ошибка, адреса расчетного счета. Запрос не был сохранен.';
  @override
  String get meetupLocation => 'Локация встречи';
  @override
  String get startGathering => 'Начинайте собрание';
  @override
  String get alreadyRegistered => 'Уже зарегистрирован';
  @override
  String get registerUntil => 'Зарегистрируйтесь до';
  @override
  String get meetingPoint => 'Место встречи';
  @override
  String get gatheringIsOver => 'Встреча завершена';
  @override
  String get today => 'Сегодня';
  @override
  String get tomorrow => 'Завтра';
  @override
  String get calendarEntryDescription => 'Принять участие в собрании для получения дохода общины';
  @override
  String get youAreNotRegistered => 'К сожалению Вы не зарегистрированы для участия в собрании:';
  @override
  String get howManyParticipantsShowedUp => 'Сколько участников присутствует, включая вас?';
  @override
  String get cycleWillTakePlaceOn => 'Цикл подписания ключей будет проходить';
  @override
  String get gatheringSuccessfullyCompleted => 'Встреча успешно завершена';
  @override
  String get fetchingReputations => 'Идет проверка Вашей репутации';
  @override
  String get youAreRegisteredAs => 'На следующую встречу вы зарегистрированы в качестве PARTICIPANT_TYPE.';
  @override
  String get youAreNotRegisteredPleaseRegisterNextTime =>
      'Вы не были записаны на этот цикл подписания ключей. Пожалуйста, присоединяйтесь к следующему циклу, для того, чтобы получить доход сообщества.';
  @override
  String get youAreAssignedToAGatheringWithNParticipants => 'Вы записаны на встречу вместе с P_COUNT участниками.';
  @override
  String get successfullySentNAttestations => 'Вы успешно отправили аттестации P_COUNT других людей.';
  @override
  String get countParticipants => 'Считать';
  @override
  String get numberOfAttendees => 'Количество участников';
  @override
  String get next => 'Следующий';
  @override
  String get closeGathering => 'Завершить встречу';
  @override
  String get count => 'Считать';
  @override
  String get scan => 'Сканировать';
  @override
  String get scanDescriptionForMeetup => 'Каждый участник должен сканировать и быть отсканированным всеми остальными.';
  @override
  String get scanOthers => 'Сканировать других';
  @override
  String get finish => 'Завершить';
  @override
  String get thankYou => 'Спасибо';
  @override
  String get weHopeToSeeYouAtTheNextGathering => 'Мы надеемся увидеть Вас на следующей встрече.';
  @override
  String get goToLeuZurich => 'Открыть leu.zuerich';
  @override
  String get leuZurichFAQ => 'ЧЗВ leu.zuerich';
  @override
  String get bootstrapperContent =>
      'Рассмотрите возможность одобрения новичков, если у вас есть билеты на одобрение,это поможет сообществу расти.';
  @override
  String get bootstrapperTitle => 'Зарегистрирован в качестве Бутсреппера - место гарантировано.';
  @override
  String get endorseeContent => 'Вы былы одобрены, как заслуживающий доверия член общины. '
      'Следовательно, Вы гарантированно будете назначены на этот цикл.';
  @override
  String get endorseeTitle => 'Зарегистрирован в качестве Индоссанта - ваше место гарантировано';
  @override
  String get newbieContent =>
      'Вы зарегистрировались в качестве новичка без репутации. Нет гарантии, что Вас назначат на '
      'этот цикл, если в нем будет участвовать большое количество новичков. Пожалуйста, '
      'проверьте статус вашего назначения за день до цикла '
      'чтобы узнать, состоится ли ваше собрание и где оно будет проходить.';
  @override
  String get newbieTitle => 'Зарегистрирован в качестве Новичка - место не гарантировано.';
  @override
  String get reputableContent => 'Вы воспользовались своей репутаций для получения гарантированного места. Внимание: '
      'Если вы зарегистрируетесь, но не явитесь на цикл, вы снова станете новичком.';
  @override
  String get reputableTitle => 'Зарегистрирован в качестве Уважаемого - ваше место гарантировано.';
  @override
  String get remainingNewbieTicketsAsReputable => 'Оставшиеся билеты для новичков Уважаемого:';
  @override
  String get remainingNewbieTicketsAsBootStrapper => 'Оставшиеся билеты для новичков Бутстреппера:';
  @override
  String get onlyReputablesCanEndorseAttendGatheringToBecomeOne =>
      'Одобрять могут только люди со статусом Уважаемого. Для получения репутации, посетите собрание!';
  @override
  String get meetupNotificationOneDayBeforeContent => 'Встреча начнется через 24 часа';
  @override
  String get meetupNotificationOneDayBeforeTitle => 'Осталось 24 часа';
  @override
  String get meetupNotificationOneHourBeforeContent => 'Встреча начнется через час';
  @override
  String get meetupNotificationOneHourBeforeTitle => 'Остался 1 час';
  @override
  String get showRouteMeetupLocation => 'Показать маршрут';
  @override
  String get registeringPhaseReminderContent => 'Регистрация на встречу началась.';
  @override
  String get registeringPhaseReminderTitle => 'Зарегистрируйтесь сейчас, не упустите шанс!';
  @override
  String get registeringLastDayOfRegisteringReminderContent =>
      'Регистрация на следующее собрание заканчивается сегодня';
  @override
  String get registeringLastDayOfRegisteringReminderTitle => 'Зарегистрируйтесь прямо сейчас!';
  @override
  String get offlineMessage =>
      'В настоящее время вы находитесь в оффлайн режиме. Ваши заявки можно будет отправить позже на главном экране.';
}
