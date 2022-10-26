/// contains translations for Encointer
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsEncointer {
  String get registerParticipant;
  String get claimsSubmit;
  String get claimsSubmitN;
  String get claimsPurge;
  String get claimsPurgeConfirm;
  String get encointerCeremony;
  String get countParticipants;
  String get nextCeremonyTimeLeft;
  String get nextCeremonyDateLabel;
  String get claimQr;
  String get claimsScanned;
  String get claimsScannedAlready;
  String get claimsScannedDecodeFailed;
  String get claimsScannedNew;
  String get claimsScannedNOfM;
  String get claimsSubmitDetail;
  String get communities;
  String get noCommunitiesAreYouOffline;
  String get encointer;
  String get meetupAttended;
  String get meetupClaimantInvalid;
  String get meetupLocation;
  String get timeUntilCeremonyStarts;
  String get startCeremony;
  String get alreadyRegistered;
  String get registerUntil;
  String get showCeremonyLocation;
  String get ceremonyIsOver;
  String get today;
  String get tomorrow;
  String get calendarEntryDescription;
  String get youAreNotRegistered;
  String get howManyParticipantsShowedUp;
  String get ceremonyWillTakePlaceOn;
  String get ceremonySuccessfullyCompleted;
  String get fetchingReputations;
  String get youAreRegisteredAs;
  String get youAreNotRegisteredPleaseRegisterNextTime;
  String get youAreAssignedToAMeetupWithNParticipants;
  String get successfullySentNAttestations;
  String get numberOfAttendees;
  String get next;
  String get closeMeetup;
  String get count;
  String get scan;
  String get scanDescriptionForMeetup;
  String get scanOthers;
  String get finish;
  String get thankYou;
  String get weHopeToSeeYouAtTheNextMeetup;
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
  get encointerCeremony => 'Encointer Ceremony';
  @override
  get nextCeremonyTimeLeft => 'Next ceremony is in';
  @override
  get nextCeremonyDateLabel => 'Next ceremony is on';
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
  get claimsSubmitDetail => 'Submitting AMOUNT claims for the recent ceremony';
  @override
  get communities => 'Communities';
  @override
  get noCommunitiesAreYouOffline => 'No communities were found. You can choose one later. Are you offline?.';
  @override
  get encointer => 'Encointer Ceremony';
  @override
  get meetupAttended => 'Attended last meetup';
  @override
  get meetupClaimantInvalid => 'This claimant is not part of the meetup. Claim is not stored.';
  @override
  get meetupLocation => 'Meetup Location';
  @override
  get timeUntilCeremonyStarts => 'Time to meetup:';
  @override
  get startCeremony => 'Start ceremony';
  @override
  get alreadyRegistered => 'Already Registered';
  @override
  get registerUntil => 'Register before';
  @override
  get showCeremonyLocation => 'Ceremony location';
  @override
  get ceremonyIsOver => 'The ceremony is over';
  @override
  get today => 'Today';
  @override
  get tomorrow => 'Tomorrow';
  @override
  get calendarEntryDescription => 'Meetup to get your community income';
  @override
  get youAreNotRegistered => 'You are not registered for a ceremony for the selected community on:';
  @override
  get howManyParticipantsShowedUp => 'How many attendees are present including yourself?';
  @override
  get ceremonyWillTakePlaceOn => 'The ceremony will take place on';
  @override
  get ceremonySuccessfullyCompleted => 'Ceremony successfully completed';
  @override
  get fetchingReputations => 'Checking if you have reputation';
  @override
  get youAreRegisteredAs => 'You have registered for the next ceremony as PARTICIPANT_TYPE.';
  @override
  get youAreNotRegisteredPleaseRegisterNextTime =>
      'You haven\'t been assigned for this ceremony. Please join a later ceremony to receive your community income.';
  @override
  get youAreAssignedToAMeetupWithNParticipants => 'You are assigned to a meetup with P_COUNT people.';
  @override
  get successfullySentNAttestations => 'You have successfully submitted attestations for P_COUNT other people.';
  @override
  get countParticipants => 'Count';
  @override
  get numberOfAttendees => 'Number of attendees';
  @override
  get next => 'Next';
  @override
  get closeMeetup => 'Close meetup';
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
  get weHopeToSeeYouAtTheNextMeetup => 'We hope to see you at the next meetup.';
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
  get encointerCeremony => 'Encointer Zeremonie';
  @override
  get nextCeremonyTimeLeft => 'Nächste Zeremonie ist in';
  @override
  get nextCeremonyDateLabel => 'Nächste Zeremonie:';
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
  get claimsSubmitDetail => 'Reiche AMOUNT Bezeugungen für die aktuelle Zeremonie ein';
  @override
  get communities => 'Gemeinschaften';
  @override
  get noCommunitiesAreYouOffline => 'Keine Gemeinschaften gefunden. Du kannst später eine auswählen. Bist du offline?';
  @override
  get encointer => 'Encointer Zeremonie';
  @override
  get meetupAttended => 'An der letzen Versammlung teilgenommen';
  @override
  get meetupClaimantInvalid =>
      'Diese* Antragssteller*in gehört nicht zu deiner Versammlung. Antrag wurde nicht gespeichert.';
  @override
  get meetupLocation => 'Treffpunkt';
  @override
  get timeUntilCeremonyStarts => 'Zeit bis zur Versammlung:';
  @override
  get startCeremony => 'Versammlung starten';
  @override
  get alreadyRegistered => 'Bereits registriert';
  @override
  get registerUntil => 'Registriere dich vor dem';
  @override
  get showCeremonyLocation => 'Treffpunkt';
  @override
  get ceremonyIsOver => 'Die Zeremonie ist vorbei';
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
  get ceremonyWillTakePlaceOn => 'Die Zeremonie wird stattfinden am';
  @override
  get ceremonySuccessfullyCompleted => 'Zeremonie erfolgreich durchgeführt';
  @override
  get fetchingReputations => 'Es wird überprüft, ob du bereits Reputation hast';
  @override
  get youAreRegisteredAs => 'Du hast dich für die nächste Zeremonie als PARTICIPANT_TYPE registriert.';
  @override
  get youAreNotRegisteredPleaseRegisterNextTime =>
      'Du wurdest nicht für diese Zeremonie zugewiesen. Bitte registriere dich für eine kommende Zeremonie um dein Gemeinschaftseinkommen zu erhalten.';
  @override
  get youAreAssignedToAMeetupWithNParticipants => 'Du bist einer Versammlung mit P_COUNT Leuten zugewiesen.';
  @override
  get successfullySentNAttestations => 'Du hast erfolgreich Bezeugungen für P_COUNT andere Leute eingereicht.';
  @override
  get countParticipants => 'Zähle';
  @override
  get numberOfAttendees => 'Anzahl Teilnehmende';
  @override
  get next => 'Weiter';
  @override
  get closeMeetup => 'Treffen schliessen';
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
  get weHopeToSeeYouAtTheNextMeetup => 'Wir hoffen, dass wir dich am nächsten Treffen wieder sehen.';
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
  get encointerCeremony => throw UnimplementedError();
  @override
  get nextCeremonyTimeLeft => throw UnimplementedError();
  @override
  get nextCeremonyDateLabel => throw UnimplementedError();
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
  get encointer => throw UnimplementedError();
  @override
  get meetupAttended => throw UnimplementedError();
  @override
  get meetupClaimantInvalid => throw UnimplementedError();
  @override
  get meetupLocation => throw UnimplementedError();
  @override
  get timeUntilCeremonyStarts => throw UnimplementedError();
  @override
  get startCeremony => throw UnimplementedError();
  @override
  get alreadyRegistered => throw UnimplementedError();
  @override
  get communities => throw UnimplementedError();
  @override
  get noCommunitiesAreYouOffline => throw UnimplementedError();
  @override
  get registerUntil => throw UnimplementedError();
  @override
  get showCeremonyLocation => throw UnimplementedError();
  @override
  get ceremonyIsOver => throw UnimplementedError();
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
  get ceremonyWillTakePlaceOn => throw UnimplementedError();
  @override
  get ceremonySuccessfullyCompleted => throw UnimplementedError();
  @override
  get fetchingReputations => throw UnimplementedError();
  @override
  get youAreRegisteredAs => throw UnimplementedError();
  @override
  get youAreNotRegisteredPleaseRegisterNextTime => throw UnimplementedError();
  @override
  get youAreAssignedToAMeetupWithNParticipants => throw UnimplementedError();
  @override
  get successfullySentNAttestations => throw UnimplementedError();
  @override
  get countParticipants => throw UnimplementedError();
  @override
  get numberOfAttendees => throw UnimplementedError();
  @override
  get next => throw UnimplementedError();
  @override
  get closeMeetup => throw UnimplementedError();
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
  get weHopeToSeeYouAtTheNextMeetup => throw UnimplementedError();
  @override
  get goToLeuZurich => throw UnimplementedError();
}
