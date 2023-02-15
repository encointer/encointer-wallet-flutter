import 'package:encointer_wallet/common/services/localization/lang_service.dart';
import 'package:encointer_wallet/common/services/preferences/local_data.dart';
import 'package:encointer_wallet/common/services/preferences/preferences_service.dart';
import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// init Service Locator modules
void init({bool? isTest = false}) {
  _prefsModule(isTest!);
  _dataSourceModule(isTest);
  _commonModule();
  _apiServiceModule();
  _repositoryModule();
  _useCaseModule();
}

void _prefsModule(bool isTest) {
  if (!isTest) {
    sl.registerSingleton(
      PreferencesService.instance,
    );
  }
}

void _dataSourceModule(bool isTest) {
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

void _commonModule() {}
void _apiServiceModule() {}
void _repositoryModule() {}
void _useCaseModule() {}
