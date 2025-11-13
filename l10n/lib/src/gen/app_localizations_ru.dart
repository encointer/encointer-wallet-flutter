// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get about => 'О приложении';

  @override
  String get aboutBrief => 'Мобильный кошелек Encointer';

  @override
  String get aboutVersion => 'Версия';

  @override
  String get acceptancePoints => 'Точки Приема';

  @override
  String get accountDelete => 'Вы уверены, что хотите удалить аккаунт?';

  @override
  String get accountImport => 'Импортировать учетную запись';

  @override
  String get accountName => 'Имя Аккаунта';

  @override
  String get accountNameChoose => 'Выберите имя Аккаунта';

  @override
  String get accountNameChooseHint =>
      'Вы можете изменить его позже в настройках профиля';

  @override
  String get accounts => 'Учетные записи';

  @override
  String get accountsDelete => 'Вы уверены, что хотите удалить все аккаунты?';

  @override
  String get accountsDeleteAll => 'Удалить все аккаунты';

  @override
  String get accountShare => 'Поделиться аккаунтом';

  @override
  String get addAccount => 'Добавить аккаунт';

  @override
  String get addBusiness => 'Добавить бизнес';

  @override
  String get addContact => 'Добавить контакт';

  @override
  String get addInvoiceQrToAddress => 'Добавить QR-инвойс к адресу';

  @override
  String get address => 'Адрес';

  @override
  String get addressBook => 'Адресная книга';

  @override
  String get addToContactFromQrContact => 'Add Contact-Qr';

  @override
  String get alreadyEndorsedErrorBody =>
      'Этот аккаунт уже был подтвержден в этом цикле.';

  @override
  String get alreadyEndorsedErrorTitle => 'Уже подтверждено';

  @override
  String get authenticationNeeded => 'Необходима аутентификация';

  @override
  String get amountError => 'Недопустимая сумма';

  @override
  String get amountToBeTransferred => 'Отправить сумму';

  @override
  String get appSettings => 'Настройки приложения';

  @override
  String get attestNotificationBody =>
      'Если все участники отправили свои подтверждения, можно попробовать получить доход.';

  @override
  String get attestNotificationTitle => 'Фаза Аттестации успешно завершена';

  @override
  String get available => 'Доступно';

  @override
  String get balance => 'Баланс';

  @override
  String get balanceTooLowBody =>
      'У вас недостаточно средств на счету. Вы не можете отправить все свои деньги, так как часть нужна для оплаты комиссии.';

  @override
  String get balanceTooLowTitle => 'Недостаточно средств на счете';

  @override
  String get balanceTransferNotificationBody =>
      'Токены успешно переведены на счет получателя!';

  @override
  String get balanceTransferNotificationTitle => 'Транзакция завершена';

  @override
  String get benefits => 'Выгоды';

  @override
  String get biometricAuth => 'Биометрическая аутентификация';

  @override
  String get biometricAuthDescription =>
      'Биометрическая аутентификация использует биометрическую информацию, хранящуюся на вашем телефоне, для аутентификации вас, вместо использования пин-кода. Вы можете включать и отключать биометрическую аутентификацию в любое время в настройках.';

  @override
  String get biometricAuthEnableDisableDescription =>
      'Введите свой PIN-код, чтобы включить или отключить биометрическую аутентификацию.';

  @override
  String get block => 'Блокировать';

  @override
  String get bootstrapperContent =>
      'Рассмотрите возможность одобрения новичков, если у вас есть билеты на одобрение,это поможет сообществу расти.';

  @override
  String get bootstrapperTitle =>
      'Зарегистрирован в качестве Бутсреппера - место гарантировано.';

  @override
  String get calendarEntryDescription =>
      'Принять участие в собрании для получения дохода общины';

  @override
  String get cameraPermissionError =>
      'Произошла ошибка при получении разрешения камеры. Вы можете предоставить разрешение в настройках приложения.';

  @override
  String get cancel => 'Отмена';

  @override
  String get canEndorseInRegisteringPhaseOnly =>
      'Может быть одобрен только на этапе регистрации';

  @override
  String get cantEndorseBootstrapper => 'Бутсрепперы уже помечены как надежные';

  @override
  String get categories => 'Категории';

  @override
  String get canUseFaucetOnlyWithCurrentAccount =>
      'Кран можно использовать только в том случае, если отображаемый счет является текущим выбранным счетом.';

  @override
  String get changeYourPin => 'Изменить PIN-код';

  @override
  String get category_all => 'Все';

  @override
  String get category_art_music => 'Искусство и музыка';

  @override
  String get category_body_soul => 'Тело и душа';

  @override
  String get category_fashion_clothing => 'Мода и одежда';

  @override
  String get category_food_beverage_store => 'Магазин еды и напитков';

  @override
  String get category_restaurants_bars => 'Рестораны и бары';

  @override
  String get category_it_hardware => 'IT-оборудование';

  @override
  String get category_food => 'Еда';

  @override
  String get category_other => 'Другое';

  @override
  String get emailFailedToOpen => 'Не удалось открыть почтовое приложение.';

  @override
  String get chosenRightCommunity =>
      'Данные относятся к другому сообществу. Пожалуйста, измените сообщество, чтобы отправить средства.';

  @override
  String get claim => 'Заявление';

  @override
  String get claimRewardsNotificationBody =>
      'Ваш запрос на вознаграждение получен и будет обработан в кратчайшие сроки. Вы получили свой доход сообщества!';

  @override
  String get claimRewardsNotificationTitle => 'Доход сообщества запрошен';

  @override
  String get claimsScannedAlready =>
      'Ранее отсканированные заявления обновлены';

  @override
  String get claimsScannedDecodeFailed =>
      'Отсканированные заявления не удалось расшифровать.';

  @override
  String get claimsScannedNew => 'Отсканировать новое заявление';

  @override
  String get claimsSubmit => 'Подать заявление';

  @override
  String get closeGathering => 'Завершить встречу';

  @override
  String get communities => 'Сообщества';

  @override
  String get communityChoose => 'Выбрать общину:';

  @override
  String get communityDoChoose => 'Выберите сообщество:';

  @override
  String get communityNotSelected =>
      'Если община не выбрана, нажмите на иконку для выбора одной из них';

  @override
  String get confirmPin => 'Для подтверждения введите свой PIN-код';

  @override
  String get confirmThePayment => '3. Подтвердите платеж';

  @override
  String get contactAddress => 'Адрес';

  @override
  String get contactAddressError => 'Неправильный адрес';

  @override
  String get contactAlreadyExists => 'Адрес уже существует';

  @override
  String get contactDelete => 'Удалить';

  @override
  String get contactDeleteWarn => 'Вы уверены, что хотите удалить этот адрес?';

  @override
  String get contactEndorse => 'Одобрить как доверенный контакт';

  @override
  String get contactMemo => 'Контактная информация';

  @override
  String get contactName => 'Имя';

  @override
  String get contactNameAlreadyExists => 'Имя уже существует';

  @override
  String get contactNameError => 'Графа Имя не может быть пустой';

  @override
  String get contactSave => 'Сохранить';

  @override
  String get contactUs => 'Связаться с нами';

  @override
  String get copy => 'Копировать';

  @override
  String get count => 'Считать';

  @override
  String get create => 'Создать аккаунт';

  @override
  String get createError => 'При создании аккаунта произошла ошибка';

  @override
  String get createHint => '(Пример: Алиса)';

  @override
  String get createPassword => 'PIN-код';

  @override
  String get createPassword2 => 'Подтвердите PIN-код';

  @override
  String get createPassword2Error => 'PIN-коды не совпадают';

  @override
  String get createPasswordError =>
      'PIN должен содержать не менее 4 цифр и никаких других знаков';

  @override
  String get deleteAccount => 'Удалить';

  @override
  String get democracy => 'Демократия';

  @override
  String get democracyFaq => 'Как работает демократия?';

  @override
  String get democracyDiscussion => 'Обсудите предложения на форуме!';

  @override
  String get democracyVotedNotificationBody =>
      'Вы проголосовали за это предложение.';

  @override
  String get democracyVotedNotificationTitle => 'проголосовали';

  @override
  String get democracyUpdatedProposalStateNotificationBody =>
      'Вы обновили это предложение';

  @override
  String get democracyUpdatedProposalStateNotificationTitle =>
      'Предложение обновлено';

  @override
  String get democracySubmitProposalNotificationBody =>
      'Вы внесли предложение, за которое люди могут проголосовать прямо сейчас.';

  @override
  String get democracySubmitProposalNotificationTitle =>
      'Предложение отправлено';

  @override
  String get detail => 'Детали';

  @override
  String get detailsEnter => 'Введите свои данные';

  @override
  String get developer => 'Режим разработчика';

  @override
  String get done => 'Выполнено';

  @override
  String get doYouAlreadyHaveAnAccount => 'У вас уже есть аккаунт?';

  @override
  String get enable => 'Включить';

  @override
  String get enableBazaar => 'Включить Базар';

  @override
  String get endorseeContent =>
      'Вы былы одобрены, как заслуживающий доверия член общины. Следовательно, Вы гарантированно будете назначены на этот цикл.';

  @override
  String get endorseeTitle =>
      'Зарегистрирован в качестве Индоссанта - ваше место гарантировано';

  @override
  String get endorseNewcomerNotificationBody =>
      'Благодарим за одобрение новичка в нашем сообществе!';

  @override
  String get endorseNewcomerNotificationTitle => 'Новичок одобрен';

  @override
  String get enterAmount => 'Введите сумму';

  @override
  String get error => 'Ошибка';

  @override
  String get errorMessageNoCommunity => 'Пожалуйста, выберите сообщество.';

  @override
  String get errorOccurred => 'Возникла ошибка:';

  @override
  String get errorUserNameIsRequired => 'Имя пользователя не может быть пустым';

  @override
  String get event => 'ID события';

  @override
  String get export => 'Экпорт аккаунта';

  @override
  String get exportAccount => 'Экспорт';

  @override
  String get exportMnemonicOk => 'Мнемоника скопирована в буфер обмена';

  @override
  String get exportWarn =>
      'Запишите эти слова на бумаге. Храните бумагу в безопасном месте. Эти слова позволят восстановить этот аккаунт и получить доступ к его средствам';

  @override
  String get fail => 'Не удалось';

  @override
  String get fee => 'Платеж';

  @override
  String get finish => 'Завершить';

  @override
  String get from => 'Из';

  @override
  String get fundsReceived => 'Полученные средства';

  @override
  String get fundVoucher => 'Ваучер на средства';

  @override
  String get gatheringSuccessfullyCompleted => 'Встреча успешно завершена';

  @override
  String get hash => 'Хэш транзакции';

  @override
  String get hintEnterCurrentPin =>
      'Чтобы изменить PIN-код пожалуйста введите текущий';

  @override
  String get hintThenEnterANewPin => 'Вы можете выбрать новый, и все готово';

  @override
  String get home => 'Домой';

  @override
  String get howManyParticipantsShowedUp =>
      'Сколько участников присутствует, включая вас?';

  @override
  String get import => 'Импортировать';

  @override
  String get importDuplicate =>
      'Учетная запись существует, вы хотите аннулировать существующий аккаунт?';

  @override
  String get importedWithRawSeedHenceNoMnemonic =>
      'Аккаунт был импортирован с необработанным исходным кодом и поэтому не имеет мнемоники';

  @override
  String get importInvalidMnemonic => 'Предоставлена недопустимая мнемоника';

  @override
  String get importInvalidRawSeed => 'Предоставлен недопустимый raw seed';

  @override
  String get importMustNotBeEmpty => 'Входные данные не должны быть пустыми';

  @override
  String get importPrivateKeyUnsupported =>
      'Импорт аккаунта с помощью секретного ключа пока не поддерживается';

  @override
  String get incomeIssuance => 'Доход сообщества';

  @override
  String get insufficientBalance => 'Недостаточный баланс';

  @override
  String get insufficientFundsErrorBody =>
      'У вас недостаточно средств на этом аккаунте. Посмотрите на веб-сайте вашего местного сообщества, как их получить.';

  @override
  String get insufficientFundsErrorTitle => 'Недостаточно средств';

  @override
  String get invalidTransactionFormatErrorBody =>
      'У транзакции был неверный формат, возможно, это ошибка в приложении. Если ты считаешь, что это баг, просто нажми на соответствующее поле ниже.';

  @override
  String get invalidTransactionFormatErrorTitle => 'Неверный формат транзакции';

  @override
  String get invalidCommunity => 'Несоотвествующая община';

  @override
  String get invalidNetwork => 'Неправильная сеть';

  @override
  String get invoice => 'Инвойс';

  @override
  String get issuanceClaimed => 'Ожидаемого поступления общины нет';

  @override
  String get issuancePending =>
      'Требовать рассмотрения ожидаемого дохода общины';

  @override
  String get keySigningCycle => 'Цикл подписания ключей';

  @override
  String get keystore => 'Хранилище ключей (json)';

  @override
  String get kusamaFaucet => 'Kusama Faucet';

  @override
  String get lang => 'Язык';

  @override
  String get leuZurichFAQ => 'ЧЗВ leu.zuerich';

  @override
  String get like => 'Нравится';

  @override
  String get loading => 'Загружается...';

  @override
  String get meetingPoint => 'Место встречи';

  @override
  String get meetupClaimantEqualToSelf =>
      'Ошибка, адреса расчетного счета. Запрос не был сохранен.';

  @override
  String get meetupClaimantInvalid =>
      'Этот заявитель не является участником встречи. Заявление не сохраняется.';

  @override
  String get meetupLocation => 'Локация встречи';

  @override
  String meetupIndex(Object index) {
    return 'Встреча выпускников №: $index';
  }

  @override
  String get meetupIndexPopupExplanation =>
      'Используйте номер собрания, чтобы найти реальное место сбора. Ответственность за определение места сбора в вашей общине несет руководитель общины. Реальное место встречи может несколько отличаться от представленного здесь.';

  @override
  String get meetupNotificationOneDayBeforeContent =>
      'Встреча начнется через 24 часа';

  @override
  String get meetupNotificationOneDayBeforeTitle => 'Осталось 24 часа';

  @override
  String get meetupNotificationOneHourBeforeContent =>
      'Встреча начнется через час';

  @override
  String get meetupNotificationOneHourBeforeTitle => 'Остался 1 час';

  @override
  String get mnemonic => 'Мнемоническая фраза';

  @override
  String get newbieContent =>
      'При Вашем текущем статусе участие в предстоящем цикле не гарантировано. Пожалуйста, обратитесь к своим знакомым с просьбой об одобрении.';

  @override
  String get newbieTitle => 'Предварительное участие';

  @override
  String get next => 'Следующий';

  @override
  String get nextCycleDateLabel => 'Следующий цикл';

  @override
  String get nextCycleTimeLeft => 'Следующий цикл через ';

  @override
  String get noCommunitiesAreYouOffline =>
      'Сообщества не обнаружены. Позже вы можете выбрать одну из них. Вы в оффлайн режиме?';

  @override
  String get noInvoice => 'Без счета-фактуры';

  @override
  String get noItems => 'Элементы не найдены';

  @override
  String get noMnemonicFound => 'Мнемоника не найдена';

  @override
  String get notNow => 'Не сейчас';

  @override
  String get notifySubmittedQueued => 'Транзакция, в очереди, отправлена';

  @override
  String get noTransactions => 'Нет транзакций';

  @override
  String get noValidClaimsErrorBody =>
      'Вы не отправили никаких действительных требований. Вы проверили наличие других участников?';

  @override
  String get noValidClaimsErrorTitle => 'Нет действительных требований';

  @override
  String get numberOfAttendees => 'Количество участников';

  @override
  String get observe => 'Мониторинг';

  @override
  String get observeBrief =>
      'Отметьте это адрес как подлежащий мониторингу, позже вы сможете выбрать этот адрес на странице выбора аккаунта, для просмотра его активов и действий';

  @override
  String get observedPendingExtrinsic =>
      'Наблюдается незавершенная транзакция. Пожалуйста, дождитесь подтверждения!';

  @override
  String get offlineMessage =>
      'В настоящее время вы находитесь в оффлайн режиме. Ваши заявки можно будет отправить позже на главном экране.';

  @override
  String get ok => 'OK';

  @override
  String get onlyReputablesCanEndorseAttendGatheringToBecomeOne =>
      'Одобрять могут только люди со статусом Уважаемого. Для получения репутации, посетите собрание!';

  @override
  String get openMapApplication => 'Открыть приложение Карты';

  @override
  String get openTheEncointerApp =>
      '1. Откройте приложение \n«Encointer Wallet»';

  @override
  String get passOld => 'Текущий PIN-код';

  @override
  String get passSuccess => 'Успех';

  @override
  String get passSuccessTxt => 'PIN-код иземенен успешно';

  @override
  String get payHereWithLeu => 'Платите здесь с Leu';

  @override
  String get payment => 'Оплата';

  @override
  String get paymentDoYouWantToProceed => 'Продолжить оплату?';

  @override
  String get paymentError => 'Ошибка при совершении оплаты';

  @override
  String get paymentFinished => 'Оплата выполнена';

  @override
  String get paymentSubmitting => 'Производится оплата...';

  @override
  String get personalKey => 'Секретный ключ';

  @override
  String get personalKeyEnter =>
      'Пожалуйста, введите секретный ключ (из 12 слов), чтобы импортировать аккаунт';

  @override
  String get pinHint =>
      'Этот PIN-код понадобится вам для транзакций и добавления новой учетной записи';

  @override
  String get pinInfo =>
      'PIN-код должен состоять как минимум из 4 цифр. При утере PIN-кода, восстановить аккаунт невозможно, если только вы не сделали резервную копию в профиле';

  @override
  String get pinSecure => 'Защитите свой аккаунт с помощью PIN-кода';

  @override
  String get pleaseCommunityChoose => 'Пожалуйста выберите общину';

  @override
  String get pleaseConfirmYourNewPin => 'Подтвердите PIN-код';

  @override
  String get preview => 'Предпросмотр';

  @override
  String get print => 'Распечатать';

  @override
  String get proposal => 'Предложение';

  @override
  String get proposalAye => 'Aye';

  @override
  String get proposalNay => 'Nay';

  @override
  String get proposalNew => 'новое предложение';

  @override
  String get proposalExplainerAddLocation =>
      'Это предложение предлагает новое место встречи для вашего сообщества. Убедитесь, что оно находится не менее чем в 100 метрах и не более чем в 1 километре от существующих мест встреч.';

  @override
  String get proposalExplainerRemoveLocation =>
      'Это предложение предлагает удалить существующее место встречи для вашего сообщества.';

  @override
  String get proposalExplainerUpdateDemurrage =>
      'Это предложение предлагает новый ежемесячный демерредж для токена сообщества.';

  @override
  String get proposalExplainerUpdateNominalIncome =>
      'Это предложение предлагает новый номинальный доход в циклах встреч для вашего сообщества.';

  @override
  String get proposalExplainerSetInactivityTimeout =>
      'Это предложение предлагает новый глобальный тайм-аут неактивности. Если сообщество не проводит встречи в течение предложенного количества циклов, оно будет удалено.';

  @override
  String get proposalExplainerPetition =>
      'Это предложение служит петицией, либо на глобальном уровне, либо в вашем сообществе. Хотя оно не имеет прямого влияния на блокчейн, оно выражает намерение, позволяя сообществу его распознать и отреагировать.';

  @override
  String get proposalExplainerSpendNative =>
      'Это предложение предлагает потратить KSM для получателя из казны сообщества, либо через глобальное, либо через голосование внутри сообщества. Эти средства могут быть использованы для вознаграждения вкладов в сообщество или поддержки инициатив сообщества.';

  @override
  String proposalExplainerIssueSwapNativeOption(String currency) {
    return 'Это предложение позволяет получателю многократно обменивать токены сообщества на KSM по установленному курсу, но не превышая заданного лимита KSM. Получателем может быть местный бизнес, который принимает токены сообщества и может накапливать их избыток.\n\nПример с курсом 3 $currency/KSM и лимитом 2 KSM:\n\nПолучатель может обменять до 2 KSM по курсу 3 $currency/KSM. Таким образом, максимум составит 6 $currency => 2 KSM.';
  }

  @override
  String proposalExplainerSpendAsset(String asset) {
    return 'Это предложение предлагает потратить $asset из казны сообщества для получателя — через глобальное или локальное голосование. Эти средства могут вознаграждать участников сообщества или поддерживать инициативы.\n\nПримечание: Ты получишь $asset напрямую на Asset Hub Kusama.';
  }

  @override
  String proposalExplainerIssueSwapAssetOption(String cc, String asset) {
    return 'Это предложение позволяет получателю обменивать $cc на $asset по установленному курсу несколько раз, вплоть до определённого лимита $asset. Получателем может быть местный бизнес, который принимает $cc и может накапливать излишки.\n\nПример: курс 3 $cc/$asset, лимит 2 $asset:\n\nПолучатель может обменять до 2 $asset по курсу 3 $cc/$asset. Максимум составляет 6 $cc => 2 $asset.\n\nПримечание: Ты получишь $asset напрямую на Asset Hub Kusama.';
  }

  @override
  String get proposalExplainerCannotVoteYet =>
      'Ты сможешь начать голосовать с репутацией со следующего цикла!';

  @override
  String get proposalType => 'Тип предложения';

  @override
  String get proposalTypeAddLocation => 'Добавить местоположение';

  @override
  String get proposalTypeRemoveLocation => 'Удалить местоположение';

  @override
  String get proposalTypeUpdateDemurrage => 'Обновить демерредж';

  @override
  String get proposalTypeUpdateNominalIncome => 'Обновить номинальный доход';

  @override
  String get proposalTypeSetInactivityTimeout =>
      'Установить тайм-аут неактивности';

  @override
  String get proposalTypePetition => 'Петиция';

  @override
  String get proposalTypeSpendNative => 'Потратить KSM';

  @override
  String proposalTypeIssueSwapNativeOption(String cc) {
    return 'Обменять $cc на KSM';
  }

  @override
  String proposalTypeSpendAsset(String asset) {
    return 'Потратить $asset';
  }

  @override
  String proposalTypeIssueSwapAssetOption(String cc, String asset) {
    return 'Обменять $cc на $asset';
  }

  @override
  String get proposalScope => 'Область действия';

  @override
  String proposalScopeLocal(String community) {
    return 'Локальный ($community)';
  }

  @override
  String get proposalScopeGlobal => 'Глобальный';

  @override
  String get proposalFieldLatitude => 'Широта';

  @override
  String get proposalFieldLongitude => 'Долгота';

  @override
  String get proposalFieldDemurragePerMonth => 'Демерредж (% / месяц)';

  @override
  String get proposalFieldNominalIncome => 'Номинальный доход';

  @override
  String get proposalFieldInactivityTimeoutCycles =>
      'Тайм-аут неактивности (циклы встреч)';

  @override
  String get proposalFieldPetitionText => 'Текст петиции';

  @override
  String get proposalFieldAssetToSpend => 'Токен для траты';

  @override
  String proposalFieldAmount(String asset) {
    return 'Сумма ($asset)';
  }

  @override
  String get proposalFieldBeneficiary => 'Получатель';

  @override
  String proposalFieldAllowance(String asset) {
    return 'Лимит ($asset)';
  }

  @override
  String proposalFieldRate(String asset, String cc) {
    return 'Ставка ($cc/$asset)';
  }

  @override
  String get proposalFieldBurn => 'Сжигание';

  @override
  String get proposalFieldValidity => 'Срок действия';

  @override
  String get proposalFieldErrorEnterPetitionText => 'Введите текст петиции';

  @override
  String get proposalFieldErrorPetitionTextTooLong =>
      'Текст петиции слишком длинный';

  @override
  String get proposalFieldErrorEnterLatitude => 'Введите широту';

  @override
  String get proposalFieldErrorLatitudeRange =>
      'Широта должна быть от -90 до 90';

  @override
  String get proposalFieldErrorEnterLongitude => 'Введите долготу';

  @override
  String get proposalFieldErrorLongitudeRange =>
      'Долгота должна быть от -180 до 180';

  @override
  String get proposalFieldErrorEnterDemurrage => 'Введите демерредж';

  @override
  String get proposalFieldErrorDemurrageRange =>
      'Демерредж должен быть от 0 до 100';

  @override
  String get proposalFieldErrorEnterPositiveNumber =>
      'Введите положительное число';

  @override
  String get proposalFieldErrorPositiveNumberRange =>
      'Должно быть положительное число';

  @override
  String get proposalFieldErrorPositiveNumberTooBig => 'Число слишком большое';

  @override
  String get proposalFieldErrorEnterInactivityTimeout =>
      'Введите тайм-аут неактивности';

  @override
  String get proposalFieldErrorPositiveIntegerRange =>
      'Должно быть положительное целое число';

  @override
  String get proposalOnlyBootstrappersOrReputablesCanSubmit =>
      'Только бутстраперы или уважаемые участники могут подать предложение.';

  @override
  String get proposalCannotSubmitProposalTypePendingEnactment =>
      'Невозможно подать предложение этого типа, так как уже есть одно ожидающее принятия.';

  @override
  String get proposalClose => 'Закрыть';

  @override
  String get proposalUpdateState => 'Обновить';

  @override
  String get proposalUpdateExplanation =>
      'Это обновит статус предложения. Если оно слишком старое и не имеет достаточного количества голосов \'За\', оно будет отклонено. Если оно подтверждается достаточно долго, оно будет принято.';

  @override
  String get proposalSubmit => 'Подать предложение';

  @override
  String get proposalSuperseded => 'заменен';

  @override
  String get proposalRejected => 'Отменено';

  @override
  String get proposalEnacted => 'выполнено';

  @override
  String get proposalApproved => 'Принято';

  @override
  String get proposalTurnout => 'Явка избирателей';

  @override
  String get proposalHowVote => 'Как вы голосуете?';

  @override
  String get proposalsEmpty => 'Нет предложений';

  @override
  String get proposalsUpForVote => 'Предложения для голосования';

  @override
  String get proposalsPast => 'Предложения прошлых лет';

  @override
  String get proposalVote => 'голосовать';

  @override
  String get proposalVoted => 'проголосовали';

  @override
  String get proposalOngoingUntil => 'Продолжается до';

  @override
  String get proposalConfirmingUntil => 'В подтверждение до';

  @override
  String get proposalPendingEnactmentAt => 'Выполнено на';

  @override
  String get proposalFailedAndNeedsBump =>
      'Предложение не прошло и может быть закрыто.';

  @override
  String get proposalPassedAndNeedsBump =>
      'Предложение принято и может быть закрыто.';

  @override
  String get qrScan => 'Сканируйте QR-код';

  @override
  String get qrScanHintAccount =>
      'Попросите получателя отсканировать QR-код в приложении Еncointer';

  @override
  String get rawSeed => 'Raw Seed';

  @override
  String get receive => 'Получить';

  @override
  String get received => 'Получено';

  @override
  String get receiverAccount => 'Аккаунт получателя';

  @override
  String get redeemFailure =>
      'Возникла ошибка при использовании ваучера. Причина:';

  @override
  String get redeemSuccess => 'Ваучер успешно погашен.';

  @override
  String get redeemVoucher => 'Использовать ваучер';

  @override
  String get registeringPhaseReminderContent =>
      'Регистрация на встречу началась.';

  @override
  String get registeringPhaseReminderTitle =>
      'Зарегистрируйтесь сейчас, не упустите шанс!';

  @override
  String get registerParticipantNotificationBody =>
      'Спасибо за регистрацию. Вам будет отправлено напоминание за день до встречи.';

  @override
  String get registerParticipantNotificationTitle =>
      'Вы успешно зарегистрировались на следующую встречу!';

  @override
  String get registerUntil => 'Зарегистрируйтесь до';

  @override
  String get remainingNewbieTicketsAsBootStrapper =>
      'Оставшиеся билеты для новичков Бутстреппера:';

  @override
  String get remainingNewbieTicketsAsReputable =>
      'Оставшиеся билеты для новичков Уважаемого:';

  @override
  String get remarkNotificationBody => 'Вы отправили заметку.';

  @override
  String get remarkNotificationTitle => 'заметка отправлена';

  @override
  String get remarks => 'Замечания в блокчейне';

  @override
  String get remarksButton => 'отправить публичную заметку';

  @override
  String get remarksExplain =>
      'Вы можете отправить заметку в сеть. Эта заметка будет публичной и неизменяемой. Её могут прочитать и аутентифицировать все, так как она будет цифрово подписана вами.';

  @override
  String get remarksNote => 'Заметка';

  @override
  String get remarksSubmit => 'Отправить заметку';

  @override
  String get reputableContent =>
      'Вы воспользовались своей репутаций для получения гарантированного места. Внимание: Если вы зарегистрируетесь, но не явитесь на цикл, вы снова станете новичком.';

  @override
  String get reputableTitle =>
      'Зарегистрирован в качестве Уважаемого - ваше место гарантировано.';

  @override
  String get reputationAlreadyCommittedTitle => 'Репутация уже использована';

  @override
  String get reputationAlreadyCommittedContent =>
      'Вы уже использовали свою репутацию, чтобы капать из крана.';

  @override
  String get reputationOverall => 'Общая репутация';

  @override
  String get restartGathering => 'Рестарт собрание';

  @override
  String get retry => 'Повторить';

  @override
  String get rewardsAlreadyIssuedErrorBody =>
      'Другой участник инициировал выплату за это собрание. Вы уже должны были получить свой доход.';

  @override
  String get rewardsAlreadyIssuedErrorTitle => 'Вознаграждения уже выданы';

  @override
  String get scan => 'Сканировать';

  @override
  String get scanDescriptionForMeetup =>
      'Каждый участник должен сканировать и быть отсканированным всеми остальными.';

  @override
  String get scanOthers => 'Сканировать других';

  @override
  String get scanQrCodeOnTheLeft => '2. Отсканируйте QR-код \nслева';

  @override
  String get sendLink => 'Отправить ссылку';

  @override
  String get sent => 'Отправлено';

  @override
  String get setting => 'Настройки';

  @override
  String get settingLang => 'Язык';

  @override
  String get settingLangAuto => 'Авто-определение';

  @override
  String get settingNetwork => 'Выберите кошелек';

  @override
  String get settingNode => 'Дистанционный режим';

  @override
  String get settingNodeList => 'Доступные режимы';

  @override
  String get settingPrefix => 'Префикс адреса';

  @override
  String get settingPrefixList => 'Доступные префиксы';

  @override
  String get share => 'Поделиться';

  @override
  String get shareInvoice => 'Отправить инвойс';

  @override
  String get shareLinkHint => 'Или Вы можете поделиться ссылкой';

  @override
  String get showRouteMeetupLocation => 'Показать маршрут';

  @override
  String get startGathering => 'Старт собрание';

  @override
  String get submittedFaucetDripTitle => 'Faucet Выгоды';

  @override
  String get submittedFaucetDripBody =>
      'Вы успешно получили вознаграждение от Faucet.';

  @override
  String get success => 'Успешно';

  @override
  String get switchAccount => 'Сменить аккаунт';

  @override
  String get switchCommunity => 'Сменить сообщество';

  @override
  String get thankYou => 'Спасибо';

  @override
  String get title => 'Профиль';

  @override
  String get to => 'в';

  @override
  String get today => 'Сегодня';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get transactionError => 'Ошибка транзакции';

  @override
  String get transactionQueuedOffline =>
      'Приложение не подключено к блокчейну. Транзакция, которая в очереди (будет отправлена автоматически при подключении).';

  @override
  String get transfer => 'Отправить';

  @override
  String get transferHistory => 'Транзакции';

  @override
  String get transferHistoryEnd =>
      'Загрузка более старых транзакций пока не поддерживается';

  @override
  String get transferHistoryTop =>
      'Появление перевода может занять до 30 секунд';

  @override
  String treasuryGlobalBalance(String balance) {
    return 'Свободный баланс глобального казначейства: $balance KSM.';
  }

  @override
  String treasuryLocalBalance(String balance) {
    return 'Свободный баланс казначейства сообщества: $balance KSM.';
  }

  @override
  String treasuryLocalBalanceOnAHK(String balance, String asset) {
    return 'Свободный баланс казначейства сообщества на Asset Hub: $balance KSM.';
  }

  @override
  String treasuryPendingSpends(String spends) {
    return 'Ожидающие расходы: $spends KSM.';
  }

  @override
  String get txBroadcast => 'Транзакция передана в эфир';

  @override
  String get txError => 'Ошибка транзакции';

  @override
  String get txInBlock => 'Транзакция заблокирована';

  @override
  String get txQueued => 'Транзакция поставлена в очередь';

  @override
  String get txQueuedOffline =>
      'Вы находитесь в оффлайн режиме. Транзакция будет отправлена, когда вы снова подключитесь к сети.';

  @override
  String get txReady => 'Транзакция готова.';

  @override
  String get txTooLowPriorityErrorBody =>
      'Техническая ошибка приоритета транзакции. Это может произойти, если вы быстро дважды нажмете на кнопку отправки. Пожалуйста, подождите несколько секунд.';

  @override
  String get txTooLowPriorityErrorTitle =>
      'Техническая ошибка приоритета транзакции';

  @override
  String get unknown => 'Неизвестный';

  @override
  String get unknownAccount => 'Неизвестный аккаунт';

  @override
  String get unknownError =>
      'Извините, произошла ошибка. Пожалуйста, проверьте свое интернет-соединение и попробуйте еще раз.';

  @override
  String get unregister => 'Отменить регистрацию';

  @override
  String get unregisterDialogTitle =>
      'Отказаться от участия в следующем цикле?';

  @override
  String get unregisterParticipantNotificationBody =>
      'Ваша регистрация на следующий цикл была отменена. Если вы передумаете, вы можете зарегистрироваться снова.';

  @override
  String get unregisterParticipantNotificationTitle => 'Регистрация отменена';

  @override
  String get updatingAppState => 'Обновление приложения';

  @override
  String get value => 'Значимость';

  @override
  String get votesNotDependableErrorBody =>
      'Назначенных участников собрания подтвердили только половину или менее. Также возможно, что некоторые участники еще не представили свое подтверждение. Это мешает достижению ранней выплаты, и вам нужно подождать 48 часов.';

  @override
  String get votesNotDependableErrorTitle => 'Голоса недостоверны';

  @override
  String get voucher => 'Ваучер';

  @override
  String get voucherBalance => 'Баланс ваучера';

  @override
  String get voucherBalanceTooLow =>
      'На ваучере слишком мало денег, чтобы его можно было выкупить.';

  @override
  String get weHopeToSeeYouAtTheNextGathering =>
      'Мы надеемся увидеть Вас на следующей встрече.';

  @override
  String get wrongPin => 'Неправильный PIN-код';

  @override
  String get wrongPinHint =>
      'Не удалось разблокировать аккаунт, пожалуйста, проверьте PIN-код';

  @override
  String get youAreNotRegisteredPleaseRegisterNextTime =>
      'Вы не были записаны на этот цикл подписания ключей. Пожалуйста, присоединяйтесь к следующему циклу, для того, чтобы получить доход сообщества.';

  @override
  String get yourNewPin => 'Новый PIN-код';

  @override
  String unlockAccount(String currentAccountName) {
    return 'Разблокируйте учетную запись $currentAccountName с помощью PIN-кода';
  }

  @override
  String errorMessageWithStatusCode(String errorText) {
    return 'Что-то пошло не так. Пожалуйста, попробуйте еще раз! StatusCode: $errorText';
  }

  @override
  String yourBalanceFor(String accountName) {
    return 'Ваш баланс, $accountName';
  }

  @override
  String incomingConfirmed(num amount, String cidSymbol, String accountName) {
    return 'Поступающая сумма $amount $cidSymbol для $accountName подтверждена';
  }

  @override
  String voucherDifferentNetworkAndCommunity(String network, String community) {
    return 'Ваучер предназначен для другой сети. Вы хотите изменить на $network и $community? Вы можете изменить сеть в разделе «Профиль»> «Режим разработчика».';
  }

  @override
  String voucherDifferentCommunity(String community) {
    return 'Ваучер предназначен для другого сообщества. Изменить на $community?';
  }

  @override
  String doYouWantToRedeemThisVoucher(String accountName) {
    return 'Вы хотите обменять этот ваучер на $accountName?';
  }

  @override
  String claimsSubmitN(int count) {
    return 'Подать $count заявление';
  }

  @override
  String claimsScanned(num amount) {
    return 'Вы отсканировали заявление $amount';
  }

  @override
  String claimsScannedNOfM(int scannedCount, int totalCount) {
    return 'Отсканированные заявления $scannedCount / $totalCount';
  }

  @override
  String claimsSubmitDetail(num amount) {
    return 'Подача заявлений на сумму $amount за недавнее собрание';
  }

  @override
  String youAreRegisteredAs(String participantType) {
    return 'На следующую встречу вы зарегистрированы в качестве $participantType.';
  }

  @override
  String youAreAssignedToAGatheringWithNParticipants(int participantsCount) {
    return 'Вы записаны на встречу вместе с $participantsCount участниками.';
  }

  @override
  String successfullySentNAttestations(int participantsCount) {
    return 'Вы успешно отправили аттестации $participantsCount других людей.';
  }

  @override
  String tokenSend(String symbol) {
    return 'Отправить $symbol';
  }

  @override
  String communityWithName(String name) {
    return 'Сообщество $name';
  }

  @override
  String verifyAuthTitle(String useBioAuth) {
    String _temp0 = intl.Intl.selectLogic(
      useBioAuth,
      {
        'true': 'вашу личность',
        'false': 'ваш PIN-код',
        'other': '',
      },
    );
    return 'Пожалуйста подтвердите$_temp0.';
  }

  @override
  String offersForCommunity(String value) {
    return 'Предложения за $value';
  }

  @override
  String proposalApprovalThreshold(String percentage) {
    return 'Порог приемлемости: $percentage%';
  }

  @override
  String proposalPassed(String percentage) {
    return 'Отклонено, взято с $percentage% Aye';
  }

  @override
  String proposalFailed(String percentage) {
    return 'Отклонено с $percentage% Aye';
  }

  @override
  String proposalIsPassing(String percentage) {
    return 'Только что приняли с $percentage% Aye';
  }

  @override
  String proposalIsFailing(String percentage) {
    return 'В настоящее время отвергается с $percentage% Aye';
  }

  @override
  String proposalSetInactivityTimeoutTo(String value) {
    return 'Глобально: Установить новый тайм-аут неактивности на $value';
  }

  @override
  String proposalAddLocation(String cid) {
    return '$cid: Добавить новое местоположение';
  }

  @override
  String proposalRemoveLocation(String cid) {
    return '$cid: Удалить местоположение';
  }

  @override
  String proposalUpdateNominalIncome(String value, String currency) {
    return 'скорректировать доходы населения с учетом $value $currency';
  }

  @override
  String proposalUpdateDemurrage(String value) {
    return 'Обновить Demurrage до $value%/месяц';
  }

  @override
  String proposalPetition(String cid, String value) {
    return '$cid петиция: $value';
  }

  @override
  String proposalSpendNative(String cid, String amount, String beneficiary) {
    return '$cid Казначейство отправит $amount KSM $beneficiary';
  }

  @override
  String proposalSpendAsset(
      String asset, String cid, String amount, String beneficiary) {
    return '$cid Казначейство отправит $amount $asset $beneficiary';
  }

  @override
  String proposalIssueSwapNativeOption(
      String cid, String beneficiary, String allowance, String rate) {
    return '$cid: Разрешить $beneficiary обменять до $allowance KSM по курсу $rate $cid/KSM.';
  }

  @override
  String proposalIssueSwapAssetOption(String asset, String cid,
      String beneficiary, String allowance, String rate) {
    return '$cid: Разрешить $beneficiary обменять до $allowance $asset по курсу $rate $cid/$asset.';
  }

  @override
  String proposalSupersededBy(String id) {
    return 'заменен на: $id';
  }
}
