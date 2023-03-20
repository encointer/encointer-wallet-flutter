import 'package:encointer_wallet/utils/translations/translations_account.dart';
import 'package:encointer_wallet/utils/translations/translations_assets.dart';
import 'package:encointer_wallet/utils/translations/translations_bazaar.dart';
import 'package:encointer_wallet/utils/translations/translations_encointer.dart';
import 'package:encointer_wallet/utils/translations/translations_home.dart';
import 'package:encointer_wallet/utils/translations/translations_profile.dart';
import 'package:encointer_wallet/utils/translations/translations_transaction.dart';

/// top level contains groups like 'account', 'profile' etc.
/// (when you add a new group the compiler will force you to add it in all implementations, too.)
abstract class Translations {
  TranslationsHome get home;
  TranslationsAccount get account;
  TranslationsAssets get assets;
  TranslationsProfile get profile;
  TranslationsEncointer get encointer;
  TranslationsBazaar get bazaar;
  TranslationsTx get tx;
}

/// for english translations
class TranslationsEn implements Translations {
  @override
  TranslationsHome get home => TranslationsEnHome();
  @override
  TranslationsAccount get account => TranslationsEnAccount();
  @override
  TranslationsAssets get assets => TranslationsEnAssets();
  @override
  TranslationsProfile get profile => TranslationsEnProfile();
  @override
  TranslationsEncointer get encointer => TranslationsEnEncointer();
  @override
  TranslationsBazaar get bazaar => TranslationsEnBazaar();
  @override
  TranslationsTx get tx => TranslationsEnTx();
}

/// for german translations
class TranslationsDe implements Translations {
  @override
  TranslationsHome get home => TranslationsDeHome();
  @override
  TranslationsAccount get account => TranslationsDeAccount();
  @override
  TranslationsAssets get assets => TranslationsDeAssets();
  @override
  TranslationsProfile get profile => TranslationsDeProfile();
  @override
  TranslationsEncointer get encointer => TranslationsDeEncointer();
  @override
  TranslationsBazaar get bazaar => TranslationsDeBazaar();
  @override
  TranslationsTx get tx => TranslationsDeTx();
}

/// for french translations
class TranslationsFr implements Translations {
  @override
  TranslationsHome get home => TranslationsFrHome();
  @override
  TranslationsAccount get account => TranslationsFrAccount();
  @override
  TranslationsAssets get assets => TranslationsFrAssets();
  @override
  TranslationsProfile get profile => TranslationsFrProfile();
  @override
  TranslationsEncointer get encointer => TranslationsFrEncointer();
  @override
  TranslationsBazaar get bazaar => TranslationsFrBazaar();
  @override
  TranslationsTx get tx => TranslationsFrTx();
}

/// for russian translations
class TranslationsRu implements Translations {
  @override
  TranslationsHome get home => TranslationsRuHome();
  @override
  TranslationsAccount get account => TranslationsRuAccount();
  @override
  TranslationsAssets get assets => TranslationsRuAssets();
  @override
  TranslationsProfile get profile => TranslationsRuProfile();
  @override
  TranslationsEncointer get encointer => TranslationsRuEncointer();
  @override
  TranslationsBazaar get bazaar => TranslationsRuBazaar();
  @override
  TranslationsTx get tx => TranslationsRuTx();
}
