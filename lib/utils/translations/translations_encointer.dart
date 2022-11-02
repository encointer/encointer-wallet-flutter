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
  String get encointerCeremony => 'Encointer Ceremony';
  @override
  String get nextCeremonyTimeLeft => 'Next ceremony is in';
  @override
  String get nextCeremonyDateLabel => 'Next ceremony is on';
  @override
  String get claimQr => 'My Claim of Attendance';
  @override
  String get claimsScanned => 'You have scanned AMOUNT_PLACEHOLDER claims';
  @override
  String get claimsScannedAlready => 'Updated previously scanned claim';
  @override
  String get claimsScannedDecodeFailed => 'Could not decode scanned claim.';
  @override
  String get claimsScannedNew => 'Scanned new claim';
  @override
  String get claimsScannedNOfM => 'Scanned SCANNED_COUNT / TOTAL_COUNT Claims';
  @override
  String get claimsSubmitDetail => 'Submitting AMOUNT claims for the recent ceremony';
  @override
  String get communities => 'Communities';
  @override
  String get noCommunitiesAreYouOffline => 'No communities were found. You can choose one later. Are you offline?.';
  @override
  String get encointer => 'Encointer Ceremony';
  @override
  String get meetupAttended => 'Attended last meetup';
  @override
  String get meetupClaimantInvalid => 'This claimant is not part of the meetup. Claim is not stored.';
  @override
  String get meetupLocation => 'Meetup Location';
  @override
  String get timeUntilCeremonyStarts => 'Time to meetup:';
  @override
  String get startCeremony => 'Start ceremony';
  @override
  String get alreadyRegistered => 'Already Registered';
  @override
  String get registerUntil => 'Register before';
  @override
  String get showCeremonyLocation => 'Ceremony location';
  @override
  String get ceremonyIsOver => 'The ceremony is over';
  @override
  String get today => 'Today';
  @override
  String get tomorrow => 'Tomorrow';
  @override
  String get calendarEntryDescription => 'Meetup toString get your community income';
  @override
  String get youAreNotRegistered => 'You are not registered for a ceremony for the selected community on:';
  @override
  String get howManyParticipantsShowedUp => 'How many attendees are present including yourself?';
  @override
  String get ceremonyWillTakePlaceOn => 'The ceremony will take place on';
  @override
  String get ceremonySuccessfullyCompleted => 'Ceremony successfully completed';
  @override
  String get fetchingReputations => 'Checking if you have reputation';
  @override
  String get youAreRegisteredAs => 'You have registered for the next ceremony as PARTICIPANT_TYPE.';
  @override
  String get youAreNotRegisteredPleaseRegisterNextTime =>
      'You haven\'t been assigned for this ceremony. Please join a later ceremony to receive your community income.';
  @override
  String get youAreAssignedToAMeetupWithNParticipants => 'You are assigned to a meetup with P_COUNT people.';
  @override
  String get successfullySentNAttestations => 'You have successfully submitted attestations for P_COUNT other people.';
  @override
  String get countParticipants => 'Count';
  @override
  String get numberOfAttendees => 'Number of attendees';
  @override
  String get next => 'Next';
  @override
  String get closeMeetup => 'Close meetup';
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
  String get weHopeToSeeYouAtTheNextMeetup => 'We hope to see you at the next meetup.';
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
  String get encointerCeremony => 'Encointer Zeremonie';
  @override
  String get nextCeremonyTimeLeft => 'Nächste Zeremonie ist in';
  @override
  String get nextCeremonyDateLabel => 'Nächste Zeremonie:';
  @override
  String get claimQr => 'Mein Antrag auf Anwesenheitsbestätigung';
  @override
  String get claimsScanned => 'Du hast AMOUNT_PLACEHOLDER Anträge gescannt';
  @override
  String get claimsScannedAlready => 'bereits gescannter Antrag wurde aktualisiert';
  @override
  String get claimsScannedDecodeFailed => 'Gescannter Antrag konnte nicht dekodiert werden.';
  @override
  String get claimsScannedNew => 'Neuer Antrag gescannt';
  @override
  String get claimsScannedNOfM => 'SCANNED_COUNT / TOTAL_COUNT gescannte Anträge';
  @override
  String get claimsSubmitDetail => 'Reiche AMOUNT Bezeugungen für die aktuelle Zeremonie ein';
  @override
  String get communities => 'Gemeinschaften';
  @override
  String get noCommunitiesAreYouOffline =>
      'Keine Gemeinschaften gefunden. Du kannst später eine auswählen. Bist du offline?';
  @override
  String get encointer => 'Encointer Zeremonie';
  @override
  String get meetupAttended => 'An der letzen Versammlung teilgenommen';
  @override
  String get meetupClaimantInvalid =>
      'Diese* Antragssteller*in gehört nicht zu deiner Versammlung. Antrag wurde nicht gespeichert.';
  @override
  String get meetupLocation => 'Treffpunkt';
  @override
  String get timeUntilCeremonyStarts => 'Zeit bis zur Versammlung:';
  @override
  String get startCeremony => 'Versammlung starten';
  @override
  String get alreadyRegistered => 'Bereits registriert';
  @override
  String get registerUntil => 'Registriere dich vor dem';
  @override
  String get showCeremonyLocation => 'Treffpunkt';
  @override
  String get ceremonyIsOver => 'Die Zeremonie ist vorbei';
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
  String get ceremonyWillTakePlaceOn => 'Die Zeremonie wird stattfinden am';
  @override
  String get ceremonySuccessfullyCompleted => 'Zeremonie erfolgreich durchgeführt';
  @override
  String get fetchingReputations => 'Es wird überprüft, ob du bereits Reputation hast';
  @override
  String get youAreRegisteredAs => 'Du hast dich für die nächste Zeremonie als PARTICIPANT_TYPE registriert.';
  @override
  String get youAreNotRegisteredPleaseRegisterNextTime =>
      'Du wurdest nicht für diese Zeremonie zugewiesen. Bitte registriere dich für eine kommende Zeremonie um dein Gemeinschaftseinkommen zu erhalten.';
  @override
  String get youAreAssignedToAMeetupWithNParticipants => 'Du bist einer Versammlung mit P_COUNT Leuten zugewiesen.';
  @override
  String get successfullySentNAttestations => 'Du hast erfolgreich Bezeugungen für P_COUNT andere Leute eingereicht.';
  @override
  String get countParticipants => 'Zähle';
  @override
  String get numberOfAttendees => 'Anzahl Teilnehmende';
  @override
  String get next => 'Weiter';
  @override
  String get closeMeetup => 'Treffen schliessen';
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
  String get weHopeToSeeYouAtTheNextMeetup => 'Wir hoffen, dass wir dich am nächsten Treffen wieder sehen.';
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
  String get encointerCeremony => throw UnimplementedError();
  @override
  String get nextCeremonyTimeLeft => throw UnimplementedError();
  @override
  String get nextCeremonyDateLabel => throw UnimplementedError();
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
  String get encointer => throw UnimplementedError();
  @override
  String get meetupAttended => throw UnimplementedError();
  @override
  String get meetupClaimantInvalid => throw UnimplementedError();
  @override
  String get meetupLocation => throw UnimplementedError();
  @override
  String get timeUntilCeremonyStarts => throw UnimplementedError();
  @override
  String get startCeremony => throw UnimplementedError();
  @override
  String get alreadyRegistered => throw UnimplementedError();
  @override
  String get communities => throw UnimplementedError();
  @override
  String get noCommunitiesAreYouOffline => throw UnimplementedError();
  @override
  String get registerUntil => throw UnimplementedError();
  @override
  String get showCeremonyLocation => throw UnimplementedError();
  @override
  String get ceremonyIsOver => throw UnimplementedError();
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
  String get ceremonyWillTakePlaceOn => throw UnimplementedError();
  @override
  String get ceremonySuccessfullyCompleted => throw UnimplementedError();
  @override
  String get fetchingReputations => throw UnimplementedError();
  @override
  String get youAreRegisteredAs => throw UnimplementedError();
  @override
  String get youAreNotRegisteredPleaseRegisterNextTime => throw UnimplementedError();
  @override
  String get youAreAssignedToAMeetupWithNParticipants => throw UnimplementedError();
  @override
  String get successfullySentNAttestations => throw UnimplementedError();
  @override
  String get countParticipants => throw UnimplementedError();
  @override
  String get numberOfAttendees => throw UnimplementedError();
  @override
  String get next => throw UnimplementedError();
  @override
  String get closeMeetup => throw UnimplementedError();
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
  String get weHopeToSeeYouAtTheNextMeetup => throw UnimplementedError();
  @override
  String get goToLeuZurich => throw UnimplementedError();
}
