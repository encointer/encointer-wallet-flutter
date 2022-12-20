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
}

class TranslationsFrEncointer implements TranslationsEncointer {
  @override
  String get registerParticipant => throw UnimplementedError();
  @override
  String get claimsSubmit => throw UnimplementedError();
  @override
  String get claimsSubmitN => throw UnimplementedError();
  @override
  String get claimsPurge => throw UnimplementedError();
  @override
  String get claimsPurgeConfirm => throw UnimplementedError();
  @override
  String get keySigningCycle => throw UnimplementedError();
  @override
  String get nextCycleTimeLeft => throw UnimplementedError();
  @override
  String get nextCycleDateLabel => throw UnimplementedError();
  @override
  String get claimQr => throw UnimplementedError();
  @override
  String get claimsScanned => throw UnimplementedError();
  @override
  String get claimsScannedAlready => throw UnimplementedError();
  @override
  String get claimsScannedDecodeFailed => throw UnimplementedError();
  @override
  String get claimsScannedNew => throw UnimplementedError();
  @override
  String get claimsScannedNOfM => throw UnimplementedError();
  @override
  String get claimsSubmitDetail => throw UnimplementedError();
  @override
  String get meetupAttended => throw UnimplementedError();
  @override
  String get meetupClaimantInvalid => throw UnimplementedError();
  @override
  String get meetupClaimantEqualToSelf => throw UnimplementedError();
  @override
  String get meetupLocation => throw UnimplementedError();
  @override
  String get startGathering => throw UnimplementedError();
  @override
  String get alreadyRegistered => throw UnimplementedError();
  @override
  String get communities => throw UnimplementedError();
  @override
  String get noCommunitiesAreYouOffline => throw UnimplementedError();
  @override
  String get registerUntil => throw UnimplementedError();
  @override
  String get meetingPoint => throw UnimplementedError();
  @override
  String get gatheringIsOver => throw UnimplementedError();
  @override
  String get today => throw UnimplementedError();
  @override
  String get tomorrow => throw UnimplementedError();
  @override
  String get calendarEntryDescription => throw UnimplementedError();
  @override
  String get youAreNotRegistered => throw UnimplementedError();
  @override
  String get howManyParticipantsShowedUp => throw UnimplementedError();
  @override
  String get cycleWillTakePlaceOn => throw UnimplementedError();
  @override
  String get gatheringSuccessfullyCompleted => throw UnimplementedError();
  @override
  String get fetchingReputations => throw UnimplementedError();
  @override
  String get youAreRegisteredAs => throw UnimplementedError();
  @override
  String get youAreNotRegisteredPleaseRegisterNextTime => throw UnimplementedError();
  @override
  String get youAreAssignedToAGatheringWithNParticipants => throw UnimplementedError();
  @override
  String get successfullySentNAttestations => throw UnimplementedError();
  @override
  String get countParticipants => throw UnimplementedError();
  @override
  String get numberOfAttendees => throw UnimplementedError();
  @override
  String get next => throw UnimplementedError();
  @override
  String get closeGathering => throw UnimplementedError();
  @override
  String get count => throw UnimplementedError();
  @override
  String get scan => throw UnimplementedError();
  @override
  String get scanDescriptionForMeetup => throw UnimplementedError();
  @override
  String get scanOthers => throw UnimplementedError();
  @override
  String get finish => throw UnimplementedError();
  @override
  String get thankYou => throw UnimplementedError();
  @override
  String get weHopeToSeeYouAtTheNextGathering => throw UnimplementedError();
  @override
  String get goToLeuZurich => throw UnimplementedError();
  @override
  String get leuZurichFAQ => throw UnimplementedError();
  @override
  String get bootstrapperContent => throw UnimplementedError();
  @override
  String get bootstrapperTitle => throw UnimplementedError();
  @override
  String get endorseeContent => throw UnimplementedError();
  @override
  String get endorseeTitle => throw UnimplementedError();
  @override
  String get newbieContent => throw UnimplementedError();
  @override
  String get newbieTitle => throw UnimplementedError();
  @override
  String get reputableContent => throw UnimplementedError();
  @override
  String get reputableTitle => throw UnimplementedError();
  @override
  String get remainingNewbieTicketsAsReputable => throw UnimplementedError();
  @override
  String get remainingNewbieTicketsAsBootStrapper => throw UnimplementedError();
  @override
  String get onlyReputablesCanEndorseAttendGatheringToBecomeOne => throw UnimplementedError();
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
  String get nextCycleTimeLeft => 'Следующий цикл в';
  @override
  String get nextCycleDateLabel => 'Следующий цикл в процессе';
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
  String get communities => 'Общины';
  @override
  String get noCommunitiesAreYouOffline =>
      'Общины не обнаружены. Позже вы можете выбрать одну из них. Вы в оффлайн режиме?';
  @override
  String get meetupAttended => 'Присутствовал на последней встрече';
  @override
  String get meetupClaimantInvalid => 'Этот заявитель не является участником встречи. Заявление не сохраняется.';
  @override
  String get meetupClaimantEqualToSelf => ' Ошибка, адрес расчетного счета. Запрос не был сохранен.';
  @override
  String get meetupLocation => 'Локция встречи';
  @override
  String get startGathering => 'Начинайте собираться';
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
  String get successfullySentNAttestations => 'Вы успешно отправили атестации P_COUNT других людей.';
  @override
  String get countParticipants => 'Считать';
  @override
  String get numberOfAttendees => 'Количество участников';
  @override
  String get next => 'Следующий';
  @override
  String get closeGathering => 'Завершить всречу';
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
  String get weHopeToSeeYouAtTheNextGathering => 'Мы надеемся увидить Вас на следующей встрече.';
  @override
  String get goToLeuZurich => 'Открыть leu.zuerich';
  @override
  String get leuZurichFAQ => 'Часто заваемые вопросы leu.zuerich';
  @override
  String get bootstrapperContent =>
      'Рассмотрите возможность одобрения новичков, если у вас есть билеты на одобрение,это поможет общине расти.';
  @override
  String get bootstrapperTitle => 'Зарегистрирован в качестве бутсреппера - место гарантировано.';
  @override
  String get endorseeContent =>
      'Вы былы одобрены, как заслуживающий доверия член общины. Следовательно, Вы гарантированно будете назначены '
      'на этот цикл.';
  @override
  String get endorseeTitle => 'Зарегистрирован в качестве индоссанта - ваше место гарантировано';
  @override
  String get newbieContent =>
      'Вы зарегистрировались в качестве новичка без репутации. Нет гарантии, что Вас назначат на '
      'это собрание цикла, если в нем будет участвовать большое количество новичков. Пожалуйста, проверьте статус вашего назначения за день до цикла '
      'чтобы узнать, состоится ли ваше собрание и где оно будет проходить.';
  @override
  String get newbieTitle => 'Зарегистрирован в качестве новичка - место не гарантировано.';
  @override
  String get reputableContent =>
      'Вы воспользовались своей репутаций для получения гарантированного места. Внимание: Если вы зарегистрируетесь, но не явитесь на цикл,'
      ' вы снова станете новичком.';
  @override
  String get reputableTitle => 'Зарегистрирован в качестве уважаемого - ваше место гарантировано.';
  @override
  String get remainingNewbieTicketsAsReputable => 'Оставшиеся билеты для новичков заслуживающие доверие:';
  @override
  String get remainingNewbieTicketsAsBootStrapper => 'Оставшиеся билеты для новичков заслуживающие доверие:';
  @override
  String get onlyReputablesCanEndorseAttendGatheringToBecomeOne =>
      'Одобрять могут только люди со статусом уважаемого. Для получения репутации, посетите собрание!';
}
