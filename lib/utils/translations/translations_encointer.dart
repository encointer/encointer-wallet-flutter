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
}

class TranslationsEnEncointer implements TranslationsEncointer {
  @override
  get registerParticipant => 'Register';
  @override
  get claimsSubmit => 'Submit claims';
  @override
  get claimsSubmitN => 'Submit N_COUNT claims';
  @override
  get claimsPurge => 'Purge previously scanned claims';
  @override
  get claimsPurgeConfirm => 'Are you sure, you want to purge all scanned claims?';
  @override
  get keySigningCycle => 'Key-Signing Cycle';
  @override
  get nextCycleTimeLeft => 'Next cycle is in';
  @override
  get nextCycleDateLabel => 'Next cycle is on';
  @override
  get claimQr => 'My Claim of Attendance';
  @override
  get claimsScanned => 'You have scanned AMOUNT_PLACEHOLDER claims';
  @override
  get claimsScannedAlready => 'Updated previously scanned claim';
  @override
  get claimsScannedDecodeFailed => 'Could not decode scanned claim.';
  @override
  get claimsScannedNew => 'Scanned new claim';
  @override
  get claimsScannedNOfM => 'Scanned SCANNED_COUNT / TOTAL_COUNT Claims';
  @override
  get claimsSubmitDetail => 'Submitting AMOUNT claims for the recent gathering';
  @override
  get communities => 'Communities';
  @override
  get noCommunitiesAreYouOffline => 'No communities were found. You can choose one later. Are you offline?.';
  @override
  get meetupAttended => 'Attended last meetup';
  @override
  get meetupClaimantInvalid => 'This claimant is not part of the meetup. Claim is not stored.';
  @override
  get meetupLocation => 'Meetup Location';
  @override
  get startGathering => 'Start gathering';
  @override
  get alreadyRegistered => 'Already Registered';
  @override
  get registerUntil => 'Register before';
  @override
  get meetingPoint => 'Meeting Point';
  @override
  get gatheringIsOver => 'The gathering is over';
  @override
  get today => 'Today';
  @override
  get tomorrow => 'Tomorrow';
  @override
  get calendarEntryDescription => 'Gathering to get your community income';
  @override
  get youAreNotRegistered => 'You are not registered for a gathering for the selected community on:';
  @override
  get howManyParticipantsShowedUp => 'How many attendees are present including yourself?';
  @override
  get cycleWillTakePlaceOn => 'The key-signing cycle will take place on';
  @override
  get gatheringSuccessfullyCompleted => 'Gathering successfully completed';
  @override
  get fetchingReputations => 'Checking if you have reputation';
  @override
  get youAreRegisteredAs => 'You have registered for the next gathering as PARTICIPANT_TYPE.';
  @override
  get youAreNotRegisteredPleaseRegisterNextTime =>
      'You haven\'t been assigned for this key-signing cycle. Please join the next cycle to receive your community income.';
  @override
  get youAreAssignedToAGatheringWithNParticipants => 'You are assigned to a gathering with P_COUNT people.';
  @override
  get successfullySentNAttestations => 'You have successfully submitted attestations for P_COUNT other people.';
  @override
  get countParticipants => 'Count';
  @override
  get numberOfAttendees => 'Number of attendees';
  @override
  get next => 'Next';
  @override
  get closeGathering => 'Close meetup';
  @override
  get count => 'Count';
  @override
  get scan => 'Scan';
  @override
  get scanDescriptionForMeetup => 'Every attendee must scan and be scanned by everyone else.';
  @override
  get scanOthers => 'Scan others';
  @override
  get finish => 'Finish';
  @override
  get thankYou => 'Thank you';
  @override
  get weHopeToSeeYouAtTheNextGathering => 'We hope to see you at the next gathering.';
  @override
  get goToLeuZurich => 'Open leu.zuerich';
}

class TranslationsDeEncointer implements TranslationsEncointer {
  @override
  get registerParticipant => 'Registrieren';
  @override
  get claimsSubmit => 'Anträge einreichen';
  @override
  get claimsSubmitN => 'N_COUNT Anträge einreichen';
  @override
  get claimsPurge => 'Bereits gescannte Anträge löschen';
  @override
  get claimsPurgeConfirm => 'Bist du sicher, dass du alle gescannte Anträge löschen möchtest?';
  @override
  get keySigningCycle => 'Key-Signing Cycle';
  @override
  get nextCycleTimeLeft => 'Nächster Cycle ist in';
  @override
  get nextCycleDateLabel => 'Nächster Cycle:';
  @override
  get claimQr => 'Mein Antrag auf Anwesenheitsbestätigung';
  @override
  get claimsScanned => 'Du hast AMOUNT_PLACEHOLDER Anträge gescannt';
  @override
  get claimsScannedAlready => 'bereits gescannter Antrag wurde aktualisiert';
  @override
  get claimsScannedDecodeFailed => 'Gescannter Antrag konnte nicht dekodiert werden.';
  @override
  get claimsScannedNew => 'Neuer Antrag gescannt';
  @override
  get claimsScannedNOfM => 'SCANNED_COUNT / TOTAL_COUNT gescannte Anträge';
  @override
  get claimsSubmitDetail => 'Reiche AMOUNT Bezeugungen für diese Versammlung ein';
  @override
  get communities => 'Gemeinschaften';
  @override
  get noCommunitiesAreYouOffline => 'Keine Gemeinschaften gefunden. Du kannst später eine auswählen. Bist du offline?';
  @override
  get meetupAttended => 'An der letzen Versammlung teilgenommen';
  @override
  get meetupClaimantInvalid =>
      'Diese* Antragssteller*in gehört nicht zu deiner Versammlung. Antrag wurde nicht gespeichert.';
  @override
  get meetupLocation => 'Treffpunkt';
  @override
  get startGathering => 'Versammlung starten';
  @override
  get alreadyRegistered => 'Bereits registriert';
  @override
  get registerUntil => 'Registriere dich vor dem';
  @override
  get meetingPoint => 'Treffpunkt';
  @override
  get gatheringIsOver => 'Die Versammung ist vorbei';
  @override
  get today => 'Heute';
  @override
  get tomorrow => 'Morgen';
  @override
  get calendarEntryDescription => 'Nimm an der Versammlung teil um dein Einkommen zu erhalten';
  @override
  get youAreNotRegistered => 'Du bist leider keiner Versammlung zugewiesen worden am';
  @override
  get howManyParticipantsShowedUp => 'Wieviele Teilnehmende sind da inklusive dir?';
  @override
  get cycleWillTakePlaceOn => 'Der Key-Signing Cycle wird stattfinden am';
  @override
  get gatheringSuccessfullyCompleted => 'Versammlung erfolgreich durchgeführt';
  @override
  get fetchingReputations => 'Es wird überprüft, ob du bereits Reputation hast';
  @override
  get youAreRegisteredAs => 'Du hast dich für die nächste Versammlung als PARTICIPANT_TYPE registriert.';
  @override
  get youAreNotRegisteredPleaseRegisterNextTime =>
      'Du wurdest nicht für diesen Key-Signing Cycle zugewiesen. Bitte registriere dich für den nächsten Cycle um dein Gemeinschaftseinkommen zu erhalten.';
  @override
  get youAreAssignedToAGatheringWithNParticipants => 'Du bist einer Versammlung mit P_COUNT Leuten zugewiesen.';
  @override
  get successfullySentNAttestations => 'Du hast erfolgreich Bezeugungen für P_COUNT andere Leute eingereicht.';
  @override
  get countParticipants => 'Zähle';
  @override
  get numberOfAttendees => 'Anzahl Teilnehmende';
  @override
  get next => 'Weiter';
  @override
  get closeGathering => 'Versammlung schliessen';
  @override
  get count => 'Zähle';
  @override
  get scan => 'Scannen';
  @override
  get scanDescriptionForMeetup => 'Jede* Anwesende muss alle anderen scannen, und von allen gescannt werden.';
  @override
  get scanOthers => 'Andere scannen';
  @override
  get finish => 'Beenden';
  @override
  get thankYou => 'Danke';
  @override
  get weHopeToSeeYouAtTheNextGathering => 'Wir hoffen dich an der nächsten Versammlung wiederzusehen.';
  @override
  get goToLeuZurich => 'leu.zuerich öffnen';
}

class TranslationsFrEncointer implements TranslationsEncointer {
  @override
  get registerParticipant => throw UnimplementedError();
  @override
  get claimsSubmit => throw UnimplementedError();
  @override
  get claimsSubmitN => throw UnimplementedError();
  @override
  get claimsPurge => throw UnimplementedError();
  @override
  get claimsPurgeConfirm => throw UnimplementedError();
  @override
  get keySigningCycle => throw UnimplementedError();
  @override
  get nextCycleTimeLeft => throw UnimplementedError();
  @override
  get nextCycleDateLabel => throw UnimplementedError();
  @override
  get claimQr => throw UnimplementedError();
  @override
  get claimsScanned => throw UnimplementedError();
  @override
  get claimsScannedAlready => throw UnimplementedError();
  @override
  get claimsScannedDecodeFailed => throw UnimplementedError();
  @override
  get claimsScannedNew => throw UnimplementedError();
  @override
  get claimsScannedNOfM => throw UnimplementedError();
  @override
  get claimsSubmitDetail => throw UnimplementedError();
  @override
  @override
  get meetupAttended => throw UnimplementedError();
  @override
  get meetupClaimantInvalid => throw UnimplementedError();
  @override
  get meetupLocation => throw UnimplementedError();
  @override
  get startGathering => throw UnimplementedError();
  @override
  get alreadyRegistered => throw UnimplementedError();
  @override
  get communities => throw UnimplementedError();
  @override
  get noCommunitiesAreYouOffline => throw UnimplementedError();
  @override
  get registerUntil => throw UnimplementedError();
  @override
  get meetingPoint => throw UnimplementedError();
  @override
  get gatheringIsOver => throw UnimplementedError();
  @override
  get today => throw UnimplementedError();
  @override
  get tomorrow => throw UnimplementedError();
  @override
  get calendarEntryDescription => throw UnimplementedError();
  @override
  get youAreNotRegistered => throw UnimplementedError();
  @override
  get howManyParticipantsShowedUp => throw UnimplementedError();
  @override
  get cycleWillTakePlaceOn => throw UnimplementedError();
  @override
  get gatheringSuccessfullyCompleted => throw UnimplementedError();
  @override
  get fetchingReputations => throw UnimplementedError();
  @override
  get youAreRegisteredAs => throw UnimplementedError();
  @override
  get youAreNotRegisteredPleaseRegisterNextTime => throw UnimplementedError();
  @override
  get youAreAssignedToAGatheringWithNParticipants => throw UnimplementedError();
  @override
  get successfullySentNAttestations => throw UnimplementedError();
  @override
  get countParticipants => throw UnimplementedError();
  @override
  get numberOfAttendees => throw UnimplementedError();
  @override
  get next => throw UnimplementedError();
  @override
  get closeGathering => throw UnimplementedError();
  @override
  get count => throw UnimplementedError();
  @override
  get scan => throw UnimplementedError();
  @override
  get scanDescriptionForMeetup => throw UnimplementedError();
  @override
  get scanOthers => throw UnimplementedError();
  @override
  get finish => throw UnimplementedError();
  @override
  get thankYou => throw UnimplementedError();
  @override
  get weHopeToSeeYouAtTheNextGathering => throw UnimplementedError();
  @override
  get goToLeuZurich => throw UnimplementedError();
}

class TranslationsRuEncointer implements TranslationsEncointer {
  @override
  get registerParticipant => 'Регистрация';
  @override
  get claimsSubmit => 'Подавать заявки';
  @override
  get claimsSubmitN => 'Подать N_COUNT заявки';
  @override
  get claimsPurge => 'Очистить ранее отсканированные заявки';
  @override
  get claimsPurgeConfirm => 'Вы уверены, что хотите удалить все ранее отсканированные заявки?';
  @override
  get keySigningCycle => 'Цикл подписания ключей';
  @override
  get nextCycleTimeLeft => 'Следующий цикл в';
  @override
  get nextCycleDateLabel => 'Следующий цикл в процессе';
  @override
  get claimQr => 'Моя заявка на участие';
  @override
  get claimsScanned => 'Вы отсканировали заявки AMOUNT_PLACEHOLDER ';
  @override
  get claimsScannedAlready => 'Ранее отсканированные заявки обновлены';
  @override
  get claimsScannedDecodeFailed => 'Отсканированные заявки не удалось расшифровать.';
  @override
  get claimsScannedNew => 'Отсканировать новую заявку';
  @override
  get claimsScannedNOfM => 'Отсканированные заявки SCANNED_COUNT / TOTAL_COUNT';
  @override
  get claimsSubmitDetail => 'Подача заявок на сумму AMOUNT за недавнее собрание';
  @override
  get communities => 'Сообщества';
  @override
  get noCommunitiesAreYouOffline => 'No communities were found. You can choose one later. Are you offline?.';
  @override
  get meetupAttended => 'Принимал участвие на последней встрече';
  @override
  get meetupClaimantInvalid => 'Этот заявитель не является участником встречи. Заявка не сохраняется.';
  @override
  get meetupLocation => 'Локция встречи';
  @override
  get startGathering => 'Начинайте собираться';
  @override
  get alreadyRegistered => 'Уже зарегистрирован';
  @override
  get registerUntil => 'Зарегистрируйтесь до';
  @override
  get meetingPoint => 'Место встречи';
  @override
  get gatheringIsOver => 'Встреча завершена';
  @override
  get today => 'Сегодня';
  @override
  get tomorrow => 'Завтра';
  @override
  get calendarEntryDescription => 'Собрание для получения дохода сообщества';
  @override
  get youAreNotRegistered => 'Вы не зарегистрированы для участия в собрании выбранного сообщества:';
  @override
  get howManyParticipantsShowedUp => 'Сколько участников присутствует, включая вас?';
  @override
  get cycleWillTakePlaceOn => 'Цикл подписания ключей будет проходить';
  @override
  get gatheringSuccessfullyCompleted => 'Встреча успешно завершена';
  @override
  get fetchingReputations => 'Идет проверка Вашей репутации';
  @override
  get youAreRegisteredAs => 'На следующую встречу вы зарегистрированы в качестве PARTICIPANT_TYPE.';
  @override
  get youAreNotRegisteredPleaseRegisterNextTime =>
      'Вас не назначили на этотYou haven\'t been assigned for this key-signing cycle. Please join the next cycle to receive your community income.';
  @override
  get youAreAssignedToAGatheringWithNParticipants => 'You are assigned to a gathering with P_COUNT people.';
  @override
  get successfullySentNAttestations => 'You have successfully submitted attestations for P_COUNT other people.';
  @override
  get countParticipants => 'Count';
  @override
  get numberOfAttendees => 'Number of attendees';
  @override
  get next => 'Next';
  @override
  get closeGathering => 'Close meetup';
  @override
  get count => 'Count';
  @override
  get scan => 'Scan';
  @override
  get scanDescriptionForMeetup => 'Every attendee must scan and be scanned by everyone else.';
  @override
  get scanOthers => 'Scan others';
  @override
  get finish => 'Finish';
  @override
  get thankYou => 'Thank you';
  @override
  get weHopeToSeeYouAtTheNextGathering => 'We hope to see you at the next gathering.';
  @override
  get goToLeuZurich => 'Open leu.zuerich';
}
