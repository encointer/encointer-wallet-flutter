import 'package:encointer_wallet/common/services/localization/lang_service.dart';
import 'package:encointer_wallet/common/services/preferences/local_data.dart';
import 'package:encointer_wallet/common/services/preferences/preferences_service.dart';
import 'package:encointer_wallet/common/stores/language/app_language_store.dart';
import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:get_it/get_it.dart';

const _tag = 'service_locator';

final sl = GetIt.instance;

/// init Service Locator modules
void init({bool? isTest = false}) {
  Log.d('init()', _tag);
  _prefsModule(isTest!);
  _dataSourceModule(isTest);
  _commonStores();
  _commonModule();
  _apiServiceModule();
  _repositoryModule();
  _useCaseModule();
}

void _prefsModule(bool isTest) {
  Log.d('_prefsModule(): isTest = $isTest', _tag);
  if (!isTest) {
    sl.registerSingleton(
      PreferencesService.instance,
    );
  }
}

void _dataSourceModule(bool isTest) {
  Log.d('_dataSourceModule(): isTest = $isTest', _tag);

  /// [PreferencesService] can be accessed globally from anywhere now
  /// if [isTest] we set [MockLocalStorage] for testing
  /// if not we set [PreferencesService.instance]
  if (isTest) {
    sl.registerFactory(
      () => LocalData(MockLocalStorage()),
    );
  } else {
    sl.registerSingleton(
      LocalData(PreferencesService.instance),
    );
  }

  sl.registerSingleton(LangService());
}

void _commonStores() {
  sl
    ..registerSingleton<AppLanguageStore>(AppLanguageStore())
    ..registerSingleton<AppStore>(AppStore());
}

void _commonModule() {}
void _apiServiceModule() {}
void _repositoryModule() {}
void _useCaseModule() {}
