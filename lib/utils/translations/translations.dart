import 'package:encointer_wallet/utils/translations/translationsHome.dart';

abstract class Translations {
  TranslationsHome get home;
// TranslationsAccount get account;
// TranslationsAssets get assets;
// TranslationsProfile get profile;
// TranslationsEcointer get encointer;
// TranslationsBazaar get bazaar;
}

class TranslationsEn implements Translations {
  TranslationsHome get home => TranslationsEnHome();
// TranslationsAccount get account;
// TranslationsAssets get assets;
// TranslationsProfile get profile;
// TranslationsEcointer get encointer;
// TranslationsBazaar get bazaar;
}

class TranslationsDe implements Translations {
  TranslationsHome get home => TranslationsEnHome();
}





