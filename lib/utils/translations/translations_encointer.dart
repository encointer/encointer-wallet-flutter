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
      'You haven\'t been assigned for this key-signing cycle. Please join the next cycle to receive your community income.';
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
}
