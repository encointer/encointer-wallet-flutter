/// contains translations for Encointer
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsEncointer {
  String get registerParticipant;
  String get claimsSubmit;
  String get claimsPurge;
  String get claimsPurgeConfirm;
  String get encointerCeremony;
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
  String get youAreRegistered;
  String get registerUntil;
  String get showCeremonyLocation;
  String get ceremonyIsOver;
  String get today;
  String get tomorrow;
  String get calendarEntryDescription;
  String get youAreNotRegistered;
  String get howManyParticipantsShowedUp;
  String get ceremonyWillTakePlaceOn;
  String get fetchingReputations;
}

class TranslationsEnEncointer implements TranslationsEncointer {
  get registerParticipant => 'Register';
  get claimsSubmit => 'Submit claims';
  get claimsPurge => 'Purge previously scanned claims';
  get claimsPurgeConfirm => 'Are you sure, you want to purge all scanned claims?';
  get encointerCeremony => 'Encointer Ceremony';
  get nextCeremonyTimeLeft => 'Next ceremony is in';
  get nextCeremonyDateLabel => 'Next ceremony is on';
  get claimQr => 'My Claim of Attendance';
  get claimsScanned => 'You have scanned AMOUNT_PLACEHOLDER claims';
  get claimsScannedAlready => 'Updated previously scanned claim';
  get claimsScannedDecodeFailed => 'Could not decode scanned claim.';
  get claimsScannedNew => 'Scanned new claim';
  get claimsScannedNOfM => "Scanned SCANNED_COUNT / TOTAL_COUNT Claims";
  get claimsSubmitDetail => 'Submitting AMOUNT claims for the recent ceremony';
  get communities => 'Communities';
  get noCommunitiesAreYouOffline => 'No communities were found. You can choose one later. Are you offline?.';
  get encointer => 'Encointer Ceremony';
  get meetupAttended => 'Attended last meetup';
  get meetupClaimantInvalid => 'This claimant is not part of the meetup. Claim is not stored.';
  get meetupLocation => 'Meetup Location';
  get timeUntilCeremonyStarts => 'Time to meetup:';
  get startCeremony => 'Start ceremony';
  get youAreRegistered => 'Already Registered';
  get registerUntil => 'Register until';
  get showCeremonyLocation => 'Ceremony location';
  get ceremonyIsOver => 'The ceremony is over';
  get today => 'Today';
  get tomorrow => 'Tomorrow';
  get calendarEntryDescription => 'Meetup to get your community income';
  get youAreNotRegistered => 'You are not registered for a ceremony for the selected community on:';
  get howManyParticipantsShowedUp => 'How many attendees are present?';
  get ceremonyWillTakePlaceOn => 'The ceremony will take place on';
  get fetchingReputations => 'Checking if you have reputation';
}

class TranslationsDeEncointer implements TranslationsEncointer {
  get registerParticipant => 'Registeriere';
  get claimsSubmit => 'Anträge einreichen';
  get claimsPurge => 'Bereits gescannte Anträge löschen';
  get claimsPurgeConfirm => 'Bist du sicher, dass du alle gescannte Anträge löschen möchtest?';
  get encointerCeremony => 'Encointer Zeremonie';
  get nextCeremonyTimeLeft => 'Nächste Zeremonie ist in';
  get nextCeremonyDateLabel => 'Nächste Zeremonie:';
  get claimQr => 'Mein Antrag auf Anwesenheitsbestätigung';
  get claimsScanned => 'Du hast AMOUNT_PLACEHOLDER Anträge gescannt';
  get claimsScannedAlready => 'bereits gescannter Antrag wurde aktualisiert';
  get claimsScannedDecodeFailed => 'Gescannter Antrag konnte nicht dekodiert werden.';
  get claimsScannedNew => 'Neuer Antrag gescannt';
  get claimsScannedNOfM => "SCANNED_COUNT / TOTAL_COUNT gescannte Anträge";
  get claimsSubmitDetail => 'Reiche AMOUNT Anträge für die aktuelle Zeremonie ein';
  get communities => 'Gemeinschaften';
  get noCommunitiesAreYouOffline => 'Keine Gemeinschaften gefunden. Du kannst später eine auswählen. Bist du offline?';
  get encointer => 'Encointer Zeremonie';
  get meetupAttended => 'An der letzen Versammlung teilgenommen';
  get meetupClaimantInvalid =>
      'Diese* Antragssteller*in gehört nicht zu deiner Versammlung. Antrag wurde nicht gespeichert.';
  get meetupLocation => 'Treffpunkt der Versammlung';
  get timeUntilCeremonyStarts => 'Zeit bis zur Versammlung:';
  get startCeremony => 'Versammlung starten';
  get youAreRegistered => 'Bereits registriert';
  get registerUntil => 'Registriere dich bis am';
  get showCeremonyLocation => 'Ort der Versammlung';
  get ceremonyIsOver => 'Die Zeremonie ist vorbei';
  get today => 'Heute';
  get tomorrow => 'Morgen';
  get calendarEntryDescription => 'Nimm an der Versammlung teil um dein Einkommen zu erhalten';
  get youAreNotRegistered => 'Du bist leider keiner Versammlung zugewiesen worden am';
  get howManyParticipantsShowedUp => 'Wieviele Teilnehmende sind da?';
  get ceremonyWillTakePlaceOn => 'Die Zeremonie wird stattfinden am';
  get fetchingReputations => 'Es wird überprüft, ob du bereits Reputation hast';
}

class TranslationsZhEncointer implements TranslationsEncointer {
  get registerParticipant => '注册参与者';
  get claimsSubmit => '提交证明';
  get claimsPurge => throw UnimplementedError();
  get claimsPurgeConfirm => throw UnimplementedError();
  get encointerCeremony => 'Encointer 仪式';
  get nextCeremonyTimeLeft => throw UnimplementedError();
  get nextCeremonyDateLabel => throw UnimplementedError();
  get claimQr => '我的出席声明';
  get claimsScanned => '您已扫描 AMOUNT_PLACEHOLDER 声明';
  get claimsScannedAlready => '更新了之前扫描的声明';
  get claimsScannedDecodeFailed => '无法解码扫描的声明。';
  get claimsScannedNew => '扫描的新声​​明';
  get claimsScannedNOfM => "扫描的 SCANNED_COUNT / TOTAL_COUNT 个索赔";
  get claimsSubmitDetail => '为最近的仪式提交 AMOUNT 索赔';
  get encointer => 'Encointer 仪式';
  get meetupAttended => '参加了上次聚会';
  get meetupClaimantInvalid => '此索赔人不是聚会的一部分。声明未存储。';
  get meetupLocation => throw UnimplementedError();
  get timeUntilCeremonyStarts => '聚会时间：';
  get startCeremony => throw UnimplementedError();
  get youAreRegistered => '已经注册';
  get communities => throw UnimplementedError();
  get noCommunitiesAreYouOffline => throw UnimplementedError();
  get registerUntil => throw UnimplementedError();
  get showCeremonyLocation => throw UnimplementedError();
  get ceremonyIsOver => throw UnimplementedError();
  get today => throw UnimplementedError();
  get tomorrow => throw UnimplementedError();
  get calendarEntryDescription => throw UnimplementedError();
  get youAreNotRegistered => throw UnimplementedError();
  get howManyParticipantsShowedUp => throw UnimplementedError();
  get ceremonyWillTakePlaceOn => throw UnimplementedError();
  get fetchingReputations => throw UnimplementedError();
}
