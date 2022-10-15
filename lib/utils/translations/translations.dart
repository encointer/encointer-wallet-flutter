import 'package:encointer_wallet/utils/translations/translations_account.dart';
import 'package:encointer_wallet/utils/translations/translations_assets.dart';
import 'package:encointer_wallet/utils/translations/translations_bazaar.dart';
import 'package:encointer_wallet/utils/translations/translations_encointer.dart';
import 'package:encointer_wallet/utils/translations/translations_home.dart';
import 'package:encointer_wallet/utils/translations/translations_profile.dart';

/// top level contains groups like 'account', 'profile' etc.
/// (when you add a new group the compiler will force you to add it in all implementations, too.)
abstract class Translations {
  TranslationsHome get home;
  TranslationsAccount get account;
  TranslationsAssets get assets;
  TranslationsProfile get profile;
  TranslationsEncointer get encointer;
  TranslationsBazaar get bazaar;
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
}

/// for chinese translations
class TranslationsZh implements Translations {
  @override
  TranslationsHome get home => TranslationsZhHome();
  @override
  TranslationsAccount get account => TranslationsZhAccount();
  @override
  TranslationsAssets get assets => TranslationsZhAssets();
  @override
  TranslationsProfile get profile => TranslationsZhProfile();
  @override
  TranslationsEncointer get encointer => TranslationsZhEncointer();
  @override
  TranslationsBazaar get bazaar => TranslationsZhBazaar();
}
