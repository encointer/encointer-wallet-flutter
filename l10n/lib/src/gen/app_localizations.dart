import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('ru'),
    Locale('sw')
  ];

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutBrief.
  ///
  /// In en, this message translates to:
  /// **'Mobile Wallet for Encointer'**
  String get aboutBrief;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// No description provided for @acceptancePoints.
  ///
  /// In en, this message translates to:
  /// **'Acceptance Points'**
  String get acceptancePoints;

  /// No description provided for @accountDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the account?'**
  String get accountDelete;

  /// No description provided for @accountImport.
  ///
  /// In en, this message translates to:
  /// **'Import account'**
  String get accountImport;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get accountName;

  /// No description provided for @accountNameChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose an account name.'**
  String get accountNameChoose;

  /// No description provided for @accountNameChooseHint.
  ///
  /// In en, this message translates to:
  /// **'You can change it later in your profile settings.'**
  String get accountNameChooseHint;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @accountsDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete all accounts?'**
  String get accountsDelete;

  /// No description provided for @accountsDeleteAll.
  ///
  /// In en, this message translates to:
  /// **'Remove all Accounts'**
  String get accountsDeleteAll;

  /// No description provided for @accountShare.
  ///
  /// In en, this message translates to:
  /// **'Share Account'**
  String get accountShare;

  /// No description provided for @addAccount.
  ///
  /// In en, this message translates to:
  /// **'Add account'**
  String get addAccount;

  /// No description provided for @addBusiness.
  ///
  /// In en, this message translates to:
  /// **'Add business'**
  String get addBusiness;

  /// No description provided for @addContact.
  ///
  /// In en, this message translates to:
  /// **'Add contact'**
  String get addContact;

  /// No description provided for @addInvoiceQrToAddress.
  ///
  /// In en, this message translates to:
  /// **'Add QR-invoice to Address'**
  String get addInvoiceQrToAddress;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressBook.
  ///
  /// In en, this message translates to:
  /// **'Address Book'**
  String get addressBook;

  /// No description provided for @addToContactFromQrContact.
  ///
  /// In en, this message translates to:
  /// **'Add Contact-Qr'**
  String get addToContactFromQrContact;

  /// No description provided for @alreadyEndorsedErrorBody.
  ///
  /// In en, this message translates to:
  /// **'This account has already been endorsed for this cycle.'**
  String get alreadyEndorsedErrorBody;

  /// No description provided for @alreadyEndorsedErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Already Endorsed'**
  String get alreadyEndorsedErrorTitle;

  /// No description provided for @authenticationNeeded.
  ///
  /// In en, this message translates to:
  /// **'Authentication Needed'**
  String get authenticationNeeded;

  /// No description provided for @amountError.
  ///
  /// In en, this message translates to:
  /// **'Invalid amount'**
  String get amountError;

  /// No description provided for @amountToBeTransferred.
  ///
  /// In en, this message translates to:
  /// **'Send amount'**
  String get amountToBeTransferred;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App settings'**
  String get appSettings;

  /// No description provided for @attestNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'If all participants have sent the attestations, you can try to claim the income.'**
  String get attestNotificationBody;

  /// No description provided for @attestNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Attested attendees'**
  String get attestNotificationTitle;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @balanceTooLowBody.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have sufficient funds in your account. You can\'t send all your money because you need some for the fees.'**
  String get balanceTooLowBody;

  /// No description provided for @balanceTooLowTitle.
  ///
  /// In en, this message translates to:
  /// **'Balance too low'**
  String get balanceTooLowTitle;

  /// No description provided for @balanceTransferNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'The recipient has received the tokens.'**
  String get balanceTransferNotificationBody;

  /// No description provided for @balanceTransferNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction completed'**
  String get balanceTransferNotificationTitle;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @biometricAuth.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication'**
  String get biometricAuth;

  /// No description provided for @biometricAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication uses the biometric information stored on your phone to authenticate you, instead of using your pin. You can enable and disable biometric authentication anytime in the settings.'**
  String get biometricAuthDescription;

  /// No description provided for @biometricAuthEnableDisableDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN to enable or disable biometric authentication.'**
  String get biometricAuthEnableDisableDescription;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @bootstrapperContent.
  ///
  /// In en, this message translates to:
  /// **'If you have endorsement tickets left, please consider endorsing newbies to help the community grow.'**
  String get bootstrapperContent;

  /// No description provided for @bootstrapperTitle.
  ///
  /// In en, this message translates to:
  /// **'Registered as bootstrapper - your seat is guaranteed.'**
  String get bootstrapperTitle;

  /// No description provided for @calendarEntryDescription.
  ///
  /// In en, this message translates to:
  /// **'Gathering to get your community income'**
  String get calendarEntryDescription;

  /// No description provided for @cameraPermissionError.
  ///
  /// In en, this message translates to:
  /// **'There was an error String getting the camera permission. Alternatively, you can grant permission in the app settings.'**
  String get cameraPermissionError;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @canEndorseInRegisteringPhaseOnly.
  ///
  /// In en, this message translates to:
  /// **'Can endorse in registering phase only'**
  String get canEndorseInRegisteringPhaseOnly;

  /// No description provided for @cantEndorseBootstrapper.
  ///
  /// In en, this message translates to:
  /// **'Bootstrappers are already marked as trusted'**
  String get cantEndorseBootstrapper;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @canUseFaucetOnlyWithCurrentAccount.
  ///
  /// In en, this message translates to:
  /// **'You can only use the faucet features if this account page shows the currently active account.'**
  String get canUseFaucetOnlyWithCurrentAccount;

  /// No description provided for @changeYourPin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get changeYourPin;

  /// No description provided for @category_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get category_all;

  /// No description provided for @category_art_music.
  ///
  /// In en, this message translates to:
  /// **'Art & Music'**
  String get category_art_music;

  /// No description provided for @category_body_soul.
  ///
  /// In en, this message translates to:
  /// **'Body & Soul'**
  String get category_body_soul;

  /// No description provided for @category_fashion_clothing.
  ///
  /// In en, this message translates to:
  /// **'Fashion & Clothing'**
  String get category_fashion_clothing;

  /// No description provided for @category_food_beverage_store.
  ///
  /// In en, this message translates to:
  /// **'Food & Beverage Store'**
  String get category_food_beverage_store;

  /// No description provided for @category_restaurants_bars.
  ///
  /// In en, this message translates to:
  /// **'Restaurants & Bars'**
  String get category_restaurants_bars;

  /// No description provided for @category_it_hardware.
  ///
  /// In en, this message translates to:
  /// **'IT Hardware'**
  String get category_it_hardware;

  /// No description provided for @category_food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get category_food;

  /// No description provided for @category_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get category_other;

  /// No description provided for @emailFailedToOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open email client.'**
  String get emailFailedToOpen;

  /// No description provided for @chosenRightCommunity.
  ///
  /// In en, this message translates to:
  /// **'The data is for a different community. Please change the community to send funds.'**
  String get chosenRightCommunity;

  /// No description provided for @claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get claim;

  /// No description provided for @claimRewardsNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'You have already received your community income!'**
  String get claimRewardsNotificationBody;

  /// No description provided for @claimRewardsNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Claimed the community income'**
  String get claimRewardsNotificationTitle;

  /// No description provided for @claimsScannedAlready.
  ///
  /// In en, this message translates to:
  /// **'Updated previously scanned claim'**
  String get claimsScannedAlready;

  /// No description provided for @claimsScannedDecodeFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not decode scanned claim. The other party needs to update the App.'**
  String get claimsScannedDecodeFailed;

  /// No description provided for @claimsScannedNew.
  ///
  /// In en, this message translates to:
  /// **'Scanned new claim'**
  String get claimsScannedNew;

  /// No description provided for @claimsSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit claims'**
  String get claimsSubmit;

  /// No description provided for @closeGathering.
  ///
  /// In en, this message translates to:
  /// **'Close gathering'**
  String get closeGathering;

  /// No description provided for @communities.
  ///
  /// In en, this message translates to:
  /// **'Communities'**
  String get communities;

  /// No description provided for @communityChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose community:'**
  String get communityChoose;

  /// No description provided for @communityDoChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose community'**
  String get communityDoChoose;

  /// No description provided for @communityNotSelected.
  ///
  /// In en, this message translates to:
  /// **'No community selected, hit the icon to select one'**
  String get communityNotSelected;

  /// No description provided for @confirmPin.
  ///
  /// In en, this message translates to:
  /// **'Input your PIN to confirm'**
  String get confirmPin;

  /// No description provided for @confirmThePayment.
  ///
  /// In en, this message translates to:
  /// **'3. Confirm the payment'**
  String get confirmThePayment;

  /// No description provided for @contactAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get contactAddress;

  /// No description provided for @contactAddressError.
  ///
  /// In en, this message translates to:
  /// **'Invalid address'**
  String get contactAddressError;

  /// No description provided for @contactAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Address exists already'**
  String get contactAlreadyExists;

  /// No description provided for @contactDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get contactDelete;

  /// No description provided for @contactDeleteWarn.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this address?'**
  String get contactDeleteWarn;

  /// No description provided for @contactEndorse.
  ///
  /// In en, this message translates to:
  /// **'Endorse as trusted contact'**
  String get contactEndorse;

  /// No description provided for @contactMemo.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get contactMemo;

  /// No description provided for @contactName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactName;

  /// No description provided for @contactNameAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Name exists already'**
  String get contactNameAlreadyExists;

  /// No description provided for @contactNameError.
  ///
  /// In en, this message translates to:
  /// **'Name can not be empty'**
  String get contactNameError;

  /// No description provided for @contactSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get contactSave;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create;

  /// No description provided for @createError.
  ///
  /// In en, this message translates to:
  /// **'There was an error creating your account'**
  String get createError;

  /// No description provided for @createHint.
  ///
  /// In en, this message translates to:
  /// **'(Example: Alice)'**
  String get createHint;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'PIN'**
  String get createPassword;

  /// No description provided for @createPassword2.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get createPassword2;

  /// No description provided for @createPassword2Error.
  ///
  /// In en, this message translates to:
  /// **'Inconsistent PINs'**
  String get createPassword2Error;

  /// No description provided for @createPasswordError.
  ///
  /// In en, this message translates to:
  /// **'PIN must contain at least 4 digits and no other signs'**
  String get createPasswordError;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'delete'**
  String get deleteAccount;

  /// No description provided for @democracy.
  ///
  /// In en, this message translates to:
  /// **'Democracy'**
  String get democracy;

  /// No description provided for @democracyFaq.
  ///
  /// In en, this message translates to:
  /// **'How does democracy work?'**
  String get democracyFaq;

  /// No description provided for @democracyDiscussion.
  ///
  /// In en, this message translates to:
  /// **'Discuss proposals in the Forum!'**
  String get democracyDiscussion;

  /// No description provided for @democracyVotedNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'You have voted for this proposal.'**
  String get democracyVotedNotificationBody;

  /// No description provided for @democracyVotedNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Voted'**
  String get democracyVotedNotificationTitle;

  /// No description provided for @democracyUpdatedProposalStateNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'You have updated this proposal'**
  String get democracyUpdatedProposalStateNotificationBody;

  /// No description provided for @democracyUpdatedProposalStateNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Proposal Updated'**
  String get democracyUpdatedProposalStateNotificationTitle;

  /// No description provided for @democracySubmitProposalNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'You made a proposal, which people can vote on now.'**
  String get democracySubmitProposalNotificationBody;

  /// No description provided for @democracySubmitProposalNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Proposal submitted'**
  String get democracySubmitProposalNotificationTitle;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detail;

  /// No description provided for @detailsEnter.
  ///
  /// In en, this message translates to:
  /// **'Enter your details.'**
  String get detailsEnter;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer mode'**
  String get developer;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'done'**
  String get done;

  /// No description provided for @doYouAlreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you already have an account?'**
  String get doYouAlreadyHaveAnAccount;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @endorseeContent.
  ///
  /// In en, this message translates to:
  /// **'You have been endorsed as a trustworthy community member. Hence, you are guaranteed to be assigned to a gathering this cycle.'**
  String get endorseeContent;

  /// No description provided for @endorseeTitle.
  ///
  /// In en, this message translates to:
  /// **'Registered as endorsee - your seat is guaranteed'**
  String get endorseeTitle;

  /// No description provided for @endorseNewcomerNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'Thanks for endorsing the newbie!'**
  String get endorseNewcomerNotificationBody;

  /// No description provided for @endorseNewcomerNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Newbie endorsed'**
  String get endorseNewcomerNotificationTitle;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorMessageNoCommunity.
  ///
  /// In en, this message translates to:
  /// **'Please choose a community.'**
  String get errorMessageNoCommunity;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred:'**
  String get errorOccurred;

  /// No description provided for @errorUserNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'User name cannot be blank'**
  String get errorUserNameIsRequired;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event ID'**
  String get event;

  /// No description provided for @swapOption.
  ///
  /// In en, this message translates to:
  /// **'Swap Option'**
  String get swapOption;

  /// No description provided for @swapOptionRate.
  ///
  /// In en, this message translates to:
  /// **'Rate {amount} {cc}/{asset}'**
  String swapOptionRate(String amount, String asset, String cc);

  /// No description provided for @swapOptionCcLimit.
  ///
  /// In en, this message translates to:
  /// **'{cc} Limit: {amount} {cc}'**
  String swapOptionCcLimit(String amount, String cc);

  /// No description provided for @swapOptionAssetToReceive.
  ///
  /// In en, this message translates to:
  /// **'You receive: {amount} {asset}'**
  String swapOptionAssetToReceive(String amount, String asset);

  /// No description provided for @swapOptionLimit.
  ///
  /// In en, this message translates to:
  /// **'Limit: {amount} {asset}'**
  String swapOptionLimit(String amount, String asset);

  /// No description provided for @exerciseSwapAssetOptionAvailable.
  ///
  /// In en, this message translates to:
  /// **'Swap Option Available'**
  String exerciseSwapAssetOptionAvailable(String asset);

  /// No description provided for @exerciseSwapNativeOptionAvailable.
  ///
  /// In en, this message translates to:
  /// **'KSM Swap Option Available'**
  String get exerciseSwapNativeOptionAvailable;

  /// No description provided for @exerciseSwapOption.
  ///
  /// In en, this message translates to:
  /// **'Exercise Swap Option'**
  String get exerciseSwapOption;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export Account'**
  String get export;

  /// No description provided for @exportAccount.
  ///
  /// In en, this message translates to:
  /// **'export'**
  String get exportAccount;

  /// No description provided for @exportMnemonicOk.
  ///
  /// In en, this message translates to:
  /// **'Mnemonic was copied to clipboard.'**
  String get exportMnemonicOk;

  /// No description provided for @exportWarn.
  ///
  /// In en, this message translates to:
  /// **'Write these words down on paper. Keep the backup paper safe. These words allows anyone to recover this account and access its funds.'**
  String get exportWarn;

  /// No description provided for @fail.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get fail;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fee;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @fundsReceived.
  ///
  /// In en, this message translates to:
  /// **'funds received'**
  String get fundsReceived;

  /// No description provided for @fundVoucher.
  ///
  /// In en, this message translates to:
  /// **'Fund voucher'**
  String get fundVoucher;

  /// No description provided for @gatheringSuccessfullyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Gathering successfully completed'**
  String get gatheringSuccessfullyCompleted;

  /// No description provided for @hash.
  ///
  /// In en, this message translates to:
  /// **'transaction hash'**
  String get hash;

  /// No description provided for @hintEnterCurrentPin.
  ///
  /// In en, this message translates to:
  /// **'To change your PIN please enter the current one.'**
  String get hintEnterCurrentPin;

  /// No description provided for @hintThenEnterANewPin.
  ///
  /// In en, this message translates to:
  /// **'Then you can choose a new one and you’re all set.'**
  String get hintThenEnterANewPin;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @howManyParticipantsShowedUp.
  ///
  /// In en, this message translates to:
  /// **'How many attendees are present including yourself?'**
  String get howManyParticipantsShowedUp;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @importDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Account exists, do you want to override the existing account?'**
  String get importDuplicate;

  /// No description provided for @importedWithRawSeedHenceNoMnemonic.
  ///
  /// In en, this message translates to:
  /// **'Account was imported with a raw seed and therefore does not have a mnemonic'**
  String get importedWithRawSeedHenceNoMnemonic;

  /// No description provided for @importInvalidMnemonic.
  ///
  /// In en, this message translates to:
  /// **'Invalid mnemonic supplied'**
  String get importInvalidMnemonic;

  /// No description provided for @importInvalidRawSeed.
  ///
  /// In en, this message translates to:
  /// **'Invalid raw seed supplied'**
  String get importInvalidRawSeed;

  /// No description provided for @importMustNotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Input must not be empty'**
  String get importMustNotBeEmpty;

  /// No description provided for @importPrivateKeyUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Private key account import is not yet supported.'**
  String get importPrivateKeyUnsupported;

  /// No description provided for @incomeIssuance.
  ///
  /// In en, this message translates to:
  /// **'Community income'**
  String get incomeIssuance;

  /// No description provided for @insufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance'**
  String get insufficientBalance;

  /// No description provided for @insufficientFundsErrorBody.
  ///
  /// In en, this message translates to:
  /// **'You do not have sufficient funds on this account. See on the website of your local community how to get some.'**
  String get insufficientFundsErrorBody;

  /// No description provided for @insufficientFundsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Insufficient Funds'**
  String get insufficientFundsErrorTitle;

  /// No description provided for @invalidTransactionFormatErrorBody.
  ///
  /// In en, this message translates to:
  /// **'The transaction had an invalid format, which might be a bug. If you think this is a bug, please tap the corresponding field below.'**
  String get invalidTransactionFormatErrorBody;

  /// No description provided for @invalidTransactionFormatErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid Transaction Format'**
  String get invalidTransactionFormatErrorTitle;

  /// No description provided for @invalidCommunity.
  ///
  /// In en, this message translates to:
  /// **'Invalid Community'**
  String get invalidCommunity;

  /// No description provided for @invalidNetwork.
  ///
  /// In en, this message translates to:
  /// **'Invalid Network'**
  String get invalidNetwork;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @issuanceClaimed.
  ///
  /// In en, this message translates to:
  /// **'No pending community income'**
  String get issuanceClaimed;

  /// No description provided for @issuancePending.
  ///
  /// In en, this message translates to:
  /// **'Claim pending community income'**
  String get issuancePending;

  /// No description provided for @keySigningCycle.
  ///
  /// In en, this message translates to:
  /// **'Key-Signing Cycle'**
  String get keySigningCycle;

  /// No description provided for @keystore.
  ///
  /// In en, this message translates to:
  /// **'Keystore (json)'**
  String get keystore;

  /// No description provided for @kusamaFaucet.
  ///
  /// In en, this message translates to:
  /// **'Kusama Faucet'**
  String get kusamaFaucet;

  /// No description provided for @lang.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get lang;

  /// No description provided for @leuZurichFAQ.
  ///
  /// In en, this message translates to:
  /// **'leu.zuerich FAQ'**
  String get leuZurichFAQ;

  /// No description provided for @like.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get like;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @meetingPoint.
  ///
  /// In en, this message translates to:
  /// **'Meeting Point'**
  String get meetingPoint;

  /// No description provided for @meetupClaimantEqualToSelf.
  ///
  /// In en, this message translates to:
  /// **'Error: Claimant is equal to self. Claim is not stored.'**
  String get meetupClaimantEqualToSelf;

  /// No description provided for @meetupClaimantInvalid.
  ///
  /// In en, this message translates to:
  /// **'This claimant is not part of the gathering. Claim is not stored.'**
  String get meetupClaimantInvalid;

  /// No description provided for @meetupLocation.
  ///
  /// In en, this message translates to:
  /// **'Gathering location'**
  String get meetupLocation;

  /// No description provided for @meetupIndex.
  ///
  /// In en, this message translates to:
  /// **'Gathering Number: {index}'**
  String meetupIndex(Object index);

  /// No description provided for @meetupIndexPopupExplanation.
  ///
  /// In en, this message translates to:
  /// **'Use the gathering number to find your real gathering location. The community leader is responsible in your community for specifying the gathering locations. The real location could be slightly different from the one displayed here.'**
  String get meetupIndexPopupExplanation;

  /// No description provided for @meetupNotificationOneDayBeforeContent.
  ///
  /// In en, this message translates to:
  /// **'Gathering starts in 24 hours'**
  String get meetupNotificationOneDayBeforeContent;

  /// No description provided for @meetupNotificationOneDayBeforeTitle.
  ///
  /// In en, this message translates to:
  /// **'24 hours left'**
  String get meetupNotificationOneDayBeforeTitle;

  /// No description provided for @meetupNotificationOneHourBeforeContent.
  ///
  /// In en, this message translates to:
  /// **'Gathering starts in one hour'**
  String get meetupNotificationOneHourBeforeContent;

  /// No description provided for @meetupNotificationOneHourBeforeTitle.
  ///
  /// In en, this message translates to:
  /// **'1 hour left'**
  String get meetupNotificationOneHourBeforeTitle;

  /// No description provided for @mnemonic.
  ///
  /// In en, this message translates to:
  /// **'Mnemonic'**
  String get mnemonic;

  /// No description provided for @newbieContent.
  ///
  /// In en, this message translates to:
  /// **'With your current status the participation for the upcoming cycle is not guaranteed. Please ask your contacts for an Endorsement.'**
  String get newbieContent;

  /// No description provided for @newbieTitle.
  ///
  /// In en, this message translates to:
  /// **'Tentative Participation'**
  String get newbieTitle;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @nextCycleDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Next cycle is on'**
  String get nextCycleDateLabel;

  /// No description provided for @nextCycleTimeLeft.
  ///
  /// In en, this message translates to:
  /// **'Next cycle is in'**
  String get nextCycleTimeLeft;

  /// No description provided for @noCommunitiesAreYouOffline.
  ///
  /// In en, this message translates to:
  /// **'No communities were found. You can choose one later. Are you offline?.'**
  String get noCommunitiesAreYouOffline;

  /// No description provided for @noInvoice.
  ///
  /// In en, this message translates to:
  /// **'No invoice'**
  String get noInvoice;

  /// No description provided for @noItems.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItems;

  /// No description provided for @noMnemonicFound.
  ///
  /// In en, this message translates to:
  /// **'No Mnemonic found'**
  String get noMnemonicFound;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @notifySubmittedQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued transaction Submitted'**
  String get notifySubmittedQueued;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No Transactions'**
  String get noTransactions;

  /// No description provided for @noValidClaimsErrorBody.
  ///
  /// In en, this message translates to:
  /// **'You did not send any valid claims. Did you scan the other attendees?'**
  String get noValidClaimsErrorBody;

  /// No description provided for @noValidClaimsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'No Valid Claims'**
  String get noValidClaimsErrorTitle;

  /// No description provided for @numberOfAttendees.
  ///
  /// In en, this message translates to:
  /// **'Number of attendees'**
  String get numberOfAttendees;

  /// No description provided for @observe.
  ///
  /// In en, this message translates to:
  /// **'Observation'**
  String get observe;

  /// No description provided for @observeBrief.
  ///
  /// In en, this message translates to:
  /// **'Mark this address as observation, then you can select this address in account select page, to watch its assets and actions'**
  String get observeBrief;

  /// No description provided for @observedPendingExtrinsic.
  ///
  /// In en, this message translates to:
  /// **'Pending transaction observed. Please wait for confirmation!'**
  String get observedPendingExtrinsic;

  /// No description provided for @offlineMessage.
  ///
  /// In en, this message translates to:
  /// **'You are currently offline. Your claims can be submitted later on the Home Screen.'**
  String get offlineMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @onlyReputablesCanEndorseAttendGatheringToBecomeOne.
  ///
  /// In en, this message translates to:
  /// **'Only reputables can endorse. Attend a gathering to get reputation!'**
  String get onlyReputablesCanEndorseAttendGatheringToBecomeOne;

  /// No description provided for @openMapApplication.
  ///
  /// In en, this message translates to:
  /// **'Open Map Application'**
  String get openMapApplication;

  /// No description provided for @openTheEncointerApp.
  ///
  /// In en, this message translates to:
  /// **'1. Open the app \n«Encointer Wallet»'**
  String get openTheEncointerApp;

  /// No description provided for @passOld.
  ///
  /// In en, this message translates to:
  /// **'Current PIN'**
  String get passOld;

  /// No description provided for @passSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get passSuccess;

  /// No description provided for @passSuccessTxt.
  ///
  /// In en, this message translates to:
  /// **'PIN changed successfully'**
  String get passSuccessTxt;

  /// No description provided for @payHereWithLeu.
  ///
  /// In en, this message translates to:
  /// **'Pay here with Leu'**
  String get payHereWithLeu;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @paymentDoYouWantToProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed with payment?'**
  String get paymentDoYouWantToProceed;

  /// No description provided for @paymentError.
  ///
  /// In en, this message translates to:
  /// **'Payment error'**
  String get paymentError;

  /// No description provided for @paymentFinished.
  ///
  /// In en, this message translates to:
  /// **'Payment complete'**
  String get paymentFinished;

  /// No description provided for @paymentSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Payment is being submitted...'**
  String get paymentSubmitting;

  /// No description provided for @personalKey.
  ///
  /// In en, this message translates to:
  /// **'Personal key'**
  String get personalKey;

  /// No description provided for @personalKeyEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter your personal key (12 words) to import the new account.'**
  String get personalKeyEnter;

  /// No description provided for @pinHint.
  ///
  /// In en, this message translates to:
  /// **'You will need this PIN for transactions and adding a new account.'**
  String get pinHint;

  /// No description provided for @pinInfo.
  ///
  /// In en, this message translates to:
  /// **'PIN should consist of at least 4 digits. If the PIN is lost, there is no option to restore the account unless you made a backup via the profile page.'**
  String get pinInfo;

  /// No description provided for @pinSecure.
  ///
  /// In en, this message translates to:
  /// **'Secure your account with a PIN.'**
  String get pinSecure;

  /// No description provided for @pleaseCommunityChoose.
  ///
  /// In en, this message translates to:
  /// **'Please choose a community'**
  String get pleaseCommunityChoose;

  /// No description provided for @pleaseConfirmYourNewPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm New PIN'**
  String get pleaseConfirmYourNewPin;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @proposal.
  ///
  /// In en, this message translates to:
  /// **'Proposal'**
  String get proposal;

  /// No description provided for @proposalAye.
  ///
  /// In en, this message translates to:
  /// **'Aye'**
  String get proposalAye;

  /// No description provided for @proposalNay.
  ///
  /// In en, this message translates to:
  /// **'Nay'**
  String get proposalNay;

  /// No description provided for @proposalNew.
  ///
  /// In en, this message translates to:
  /// **'New Proposal'**
  String get proposalNew;

  /// No description provided for @proposalExplainerAddLocation.
  ///
  /// In en, this message translates to:
  /// **'This proposal suggests a new gathering location for your community. Make sure it’s at least 100m away and no more than 1km from existing locations.'**
  String get proposalExplainerAddLocation;

  /// No description provided for @proposalExplainerRemoveLocation.
  ///
  /// In en, this message translates to:
  /// **'This proposal suggests to remove an existing gathering location for your community.'**
  String get proposalExplainerRemoveLocation;

  /// No description provided for @proposalExplainerUpdateDemurrage.
  ///
  /// In en, this message translates to:
  /// **'This proposal suggest a new monthly demurrage for your community token.'**
  String get proposalExplainerUpdateDemurrage;

  /// No description provided for @proposalExplainerUpdateNominalIncome.
  ///
  /// In en, this message translates to:
  /// **'This proposal suggests a new nominal income in the gathering cycles for your community.'**
  String get proposalExplainerUpdateNominalIncome;

  /// No description provided for @proposalExplainerSetInactivityTimeout.
  ///
  /// In en, this message translates to:
  /// **'This proposal suggests a new global inactivity timeout. If a community has not been performing gatherings for the suggested number of gathering cycles, the community will be deleted.'**
  String get proposalExplainerSetInactivityTimeout;

  /// No description provided for @proposalExplainerPetition.
  ///
  /// In en, this message translates to:
  /// **'This proposal serves as a petition, either globally or within your community. While it has no direct on-chain effect, it signals intent, allowing the community to recognize and act upon it.'**
  String get proposalExplainerPetition;

  /// No description provided for @proposalExplainerSpendNative.
  ///
  /// In en, this message translates to:
  /// **'This proposal suggests spending KSM for a beneficiary from the community treasury, either through a global or community vote. These funds can reward community contributions or support community initiatives.'**
  String get proposalExplainerSpendNative;

  /// No description provided for @proposalExplainerIssueSwapNativeOption.
  ///
  /// In en, this message translates to:
  /// **'This proposal allows the beneficiary to exchange {cc} for KSM at a defined rate multiple times up to a set KSM limit. The beneficiary might be a local business that accepts {cc} and may accumulate a surplus.\n\nExample with rate 3 {cc}/KSM and limit 2 KSM:\n\nThe beneficiary can exchange up to 2 KSM at a rate of 3 {cc}/KSM. Hence, the maximum is 6 {cc} => 2 KSM.'**
  String proposalExplainerIssueSwapNativeOption(String cc);

  /// No description provided for @proposalExplainerSpendAsset.
  ///
  /// In en, this message translates to:
  /// **'This proposal suggests spending {asset} for a beneficiary from the community treasury, either through a global or community vote. These funds can reward community contributions or support community initiatives.\n\nNote: You will receive the {asset} on Asset Hub Kusama directly.'**
  String proposalExplainerSpendAsset(String asset);

  /// No description provided for @proposalExplainerIssueSwapAssetOption.
  ///
  /// In en, this message translates to:
  /// **'This proposal allows the beneficiary to exchange {cc} for {asset} at a defined rate multiple times up to a set {asset} limit. The beneficiary might be a local business that accepts {cc} and may accumulate a surplus.\n\nExample with rate 3 {cc}/{asset} and limit 2 {asset}:\n\nThe beneficiary can exchange up to 2 {asset} at a rate of 3 {cc}/{asset}. Hence, the maximum is 6 {cc} => 2 {asset}.\n\nNote: You will receive the {asset} on Asset Hub Kusama directly.'**
  String proposalExplainerIssueSwapAssetOption(String cc, String asset);

  /// No description provided for @proposalExplainerCannotVoteYet.
  ///
  /// In en, this message translates to:
  /// **'You can start voting with your reputation as of the next cycle!'**
  String get proposalExplainerCannotVoteYet;

  /// No description provided for @proposalType.
  ///
  /// In en, this message translates to:
  /// **'Proposal Type'**
  String get proposalType;

  /// No description provided for @proposalTypeAddLocation.
  ///
  /// In en, this message translates to:
  /// **'Add location'**
  String get proposalTypeAddLocation;

  /// No description provided for @proposalTypeRemoveLocation.
  ///
  /// In en, this message translates to:
  /// **'Remove location'**
  String get proposalTypeRemoveLocation;

  /// No description provided for @proposalTypeUpdateDemurrage.
  ///
  /// In en, this message translates to:
  /// **'Update Demurrage'**
  String get proposalTypeUpdateDemurrage;

  /// No description provided for @proposalTypeUpdateNominalIncome.
  ///
  /// In en, this message translates to:
  /// **'Update Nominal Income'**
  String get proposalTypeUpdateNominalIncome;

  /// No description provided for @proposalTypeSetInactivityTimeout.
  ///
  /// In en, this message translates to:
  /// **'Set Inactivity Timeout'**
  String get proposalTypeSetInactivityTimeout;

  /// No description provided for @proposalTypePetition.
  ///
  /// In en, this message translates to:
  /// **'Petition'**
  String get proposalTypePetition;

  /// No description provided for @proposalTypeSpendNative.
  ///
  /// In en, this message translates to:
  /// **'Spend KSM'**
  String get proposalTypeSpendNative;

  /// No description provided for @proposalTypeIssueSwapNativeOption.
  ///
  /// In en, this message translates to:
  /// **'Swap {cc} for KSM'**
  String proposalTypeIssueSwapNativeOption(String cc);

  /// No description provided for @proposalTypeSpendAsset.
  ///
  /// In en, this message translates to:
  /// **'Spend {asset}'**
  String proposalTypeSpendAsset(String asset);

  /// No description provided for @proposalTypeIssueSwapAssetOption.
  ///
  /// In en, this message translates to:
  /// **'Swap {cc} for {asset}'**
  String proposalTypeIssueSwapAssetOption(String cc, String asset);

  /// No description provided for @proposalScope.
  ///
  /// In en, this message translates to:
  /// **'Scope'**
  String get proposalScope;

  /// No description provided for @proposalScopeLocal.
  ///
  /// In en, this message translates to:
  /// **'Local ({community})'**
  String proposalScopeLocal(String community);

  /// No description provided for @proposalScopeGlobal.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get proposalScopeGlobal;

  /// No description provided for @proposalFieldLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get proposalFieldLatitude;

  /// No description provided for @proposalFieldLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get proposalFieldLongitude;

  /// No description provided for @proposalFieldDemurragePerMonth.
  ///
  /// In en, this message translates to:
  /// **'Demurrage (% / month)'**
  String get proposalFieldDemurragePerMonth;

  /// No description provided for @proposalFieldNominalIncome.
  ///
  /// In en, this message translates to:
  /// **'Nominal Income'**
  String get proposalFieldNominalIncome;

  /// No description provided for @proposalFieldInactivityTimeoutCycles.
  ///
  /// In en, this message translates to:
  /// **'Inactivity Timeout (gathering cycles)'**
  String get proposalFieldInactivityTimeoutCycles;

  /// No description provided for @proposalFieldPetitionText.
  ///
  /// In en, this message translates to:
  /// **'Petition Text'**
  String get proposalFieldPetitionText;

  /// No description provided for @proposalFieldAssetToSpend.
  ///
  /// In en, this message translates to:
  /// **'Asset to spend'**
  String get proposalFieldAssetToSpend;

  /// No description provided for @proposalFieldAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount ({asset})'**
  String proposalFieldAmount(String asset);

  /// No description provided for @proposalFieldBeneficiary.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary'**
  String get proposalFieldBeneficiary;

  /// No description provided for @proposalFieldAllowance.
  ///
  /// In en, this message translates to:
  /// **'Limit ({asset})'**
  String proposalFieldAllowance(String asset);

  /// No description provided for @proposalFieldRate.
  ///
  /// In en, this message translates to:
  /// **'Rate ({cc}/{asset})'**
  String proposalFieldRate(String asset, String cc);

  /// No description provided for @proposalFieldBurn.
  ///
  /// In en, this message translates to:
  /// **'Burn'**
  String get proposalFieldBurn;

  /// No description provided for @proposalFieldValidity.
  ///
  /// In en, this message translates to:
  /// **'Validity'**
  String get proposalFieldValidity;

  /// No description provided for @proposalFieldErrorEnterPetitionText.
  ///
  /// In en, this message translates to:
  /// **'Enter Petition Text'**
  String get proposalFieldErrorEnterPetitionText;

  /// No description provided for @proposalFieldErrorPetitionTextTooLong.
  ///
  /// In en, this message translates to:
  /// **'Petition Text is too long'**
  String get proposalFieldErrorPetitionTextTooLong;

  /// No description provided for @proposalFieldErrorEnterLatitude.
  ///
  /// In en, this message translates to:
  /// **'Enter Latitude'**
  String get proposalFieldErrorEnterLatitude;

  /// No description provided for @proposalFieldErrorLatitudeRange.
  ///
  /// In en, this message translates to:
  /// **'Latitude must be between -90 and 90'**
  String get proposalFieldErrorLatitudeRange;

  /// No description provided for @proposalFieldErrorEnterLongitude.
  ///
  /// In en, this message translates to:
  /// **'Enter Longitude'**
  String get proposalFieldErrorEnterLongitude;

  /// No description provided for @proposalFieldErrorLongitudeRange.
  ///
  /// In en, this message translates to:
  /// **'Longitude must be between -180 and 180'**
  String get proposalFieldErrorLongitudeRange;

  /// No description provided for @proposalFieldErrorEnterDemurrage.
  ///
  /// In en, this message translates to:
  /// **'Enter Demurrage'**
  String get proposalFieldErrorEnterDemurrage;

  /// No description provided for @proposalFieldErrorDemurrageRange.
  ///
  /// In en, this message translates to:
  /// **'Demurrage must be between 0 and 100'**
  String get proposalFieldErrorDemurrageRange;

  /// No description provided for @proposalFieldErrorEnterPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter positive number'**
  String get proposalFieldErrorEnterPositiveNumber;

  /// No description provided for @proposalFieldErrorPositiveNumberRange.
  ///
  /// In en, this message translates to:
  /// **'Must be a positive number'**
  String get proposalFieldErrorPositiveNumberRange;

  /// No description provided for @proposalFieldErrorPositiveNumberTooBig.
  ///
  /// In en, this message translates to:
  /// **'Number is too big (Limit: {amount})'**
  String proposalFieldErrorPositiveNumberTooBig(String amount);

  /// No description provided for @proposalFieldErrorEnterInactivityTimeout.
  ///
  /// In en, this message translates to:
  /// **'Enter inactivity timeout'**
  String get proposalFieldErrorEnterInactivityTimeout;

  /// No description provided for @proposalFieldErrorPositiveIntegerRange.
  ///
  /// In en, this message translates to:
  /// **'Must be a positive integer'**
  String get proposalFieldErrorPositiveIntegerRange;

  /// No description provided for @proposalOnlyBootstrappersOrReputablesCanSubmit.
  ///
  /// In en, this message translates to:
  /// **'Only bootstrappers or reputables can submit a proposal.'**
  String get proposalOnlyBootstrappersOrReputablesCanSubmit;

  /// No description provided for @proposalOnlyBusinessOwnersCanSubmit.
  ///
  /// In en, this message translates to:
  /// **'Only business owners can submit this proposal.'**
  String get proposalOnlyBusinessOwnersCanSubmit;

  /// No description provided for @proposalCannotSubmitProposalTypePendingEnactment.
  ///
  /// In en, this message translates to:
  /// **'Cannot submit a proposal of this type, as there is already one pending enactment.'**
  String get proposalCannotSubmitProposalTypePendingEnactment;

  /// No description provided for @proposalClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get proposalClose;

  /// No description provided for @proposalUpdateState.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get proposalUpdateState;

  /// No description provided for @proposalUpdateExplanation.
  ///
  /// In en, this message translates to:
  /// **'This will update the proposal state. If it is too old and does not have enough Aye votes, it will be rejected. If it has been confirming long enough, it will pass.'**
  String get proposalUpdateExplanation;

  /// No description provided for @proposalSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit Proposal'**
  String get proposalSubmit;

  /// No description provided for @proposalSuperseded.
  ///
  /// In en, this message translates to:
  /// **'Superseded'**
  String get proposalSuperseded;

  /// No description provided for @proposalRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get proposalRejected;

  /// No description provided for @proposalEnacted.
  ///
  /// In en, this message translates to:
  /// **'Enacted'**
  String get proposalEnacted;

  /// No description provided for @proposalApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get proposalApproved;

  /// No description provided for @proposalTurnout.
  ///
  /// In en, this message translates to:
  /// **'Turnout'**
  String get proposalTurnout;

  /// No description provided for @proposalHowVote.
  ///
  /// In en, this message translates to:
  /// **'How do you vote?'**
  String get proposalHowVote;

  /// No description provided for @proposalsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No proposals'**
  String get proposalsEmpty;

  /// No description provided for @proposalsUpForVote.
  ///
  /// In en, this message translates to:
  /// **'Proposals up for vote'**
  String get proposalsUpForVote;

  /// No description provided for @proposalsPast.
  ///
  /// In en, this message translates to:
  /// **'Past Proposals'**
  String get proposalsPast;

  /// No description provided for @proposalVote.
  ///
  /// In en, this message translates to:
  /// **'Vote'**
  String get proposalVote;

  /// No description provided for @proposalVoted.
  ///
  /// In en, this message translates to:
  /// **'Voted'**
  String get proposalVoted;

  /// No description provided for @proposalOngoingUntil.
  ///
  /// In en, this message translates to:
  /// **'Ongoing until'**
  String get proposalOngoingUntil;

  /// No description provided for @proposalConfirmingUntil.
  ///
  /// In en, this message translates to:
  /// **'Confirming until'**
  String get proposalConfirmingUntil;

  /// No description provided for @proposalPendingEnactmentAt.
  ///
  /// In en, this message translates to:
  /// **'Pending enactment at'**
  String get proposalPendingEnactmentAt;

  /// No description provided for @proposalFailedAndNeedsBump.
  ///
  /// In en, this message translates to:
  /// **'The proposal has failed and can be closed.'**
  String get proposalFailedAndNeedsBump;

  /// No description provided for @proposalPassedAndNeedsBump.
  ///
  /// In en, this message translates to:
  /// **'The proposal has passed and can be closed.'**
  String get proposalPassedAndNeedsBump;

  /// No description provided for @qrScan.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get qrScan;

  /// No description provided for @qrScanHintAccount.
  ///
  /// In en, this message translates to:
  /// **'Ask the recipient to scan the QR-code in the encointer app.'**
  String get qrScanHintAccount;

  /// No description provided for @rawSeed.
  ///
  /// In en, this message translates to:
  /// **'Raw Seed'**
  String get rawSeed;

  /// No description provided for @receive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get receive;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @receiverAccount.
  ///
  /// In en, this message translates to:
  /// **'Receiving account:'**
  String get receiverAccount;

  /// No description provided for @redeemFailure.
  ///
  /// In en, this message translates to:
  /// **'There was an error while redeeming the voucher. Cause:'**
  String get redeemFailure;

  /// No description provided for @redeemSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully redeemed voucher.'**
  String get redeemSuccess;

  /// No description provided for @redeemVoucher.
  ///
  /// In en, this message translates to:
  /// **'Redeem voucher'**
  String get redeemVoucher;

  /// No description provided for @registeringPhaseReminderContent.
  ///
  /// In en, this message translates to:
  /// **'Registration for the next gathering has started.'**
  String get registeringPhaseReminderContent;

  /// No description provided for @registeringPhaseReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Register now!'**
  String get registeringPhaseReminderTitle;

  /// No description provided for @registerParticipantNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'You will receive a reminder one day before.'**
  String get registerParticipantNotificationBody;

  /// No description provided for @registerParticipantNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Registered for the next cycle!'**
  String get registerParticipantNotificationTitle;

  /// No description provided for @registerUntil.
  ///
  /// In en, this message translates to:
  /// **'Register before'**
  String get registerUntil;

  /// No description provided for @remainingNewbieTicketsAsBootStrapper.
  ///
  /// In en, this message translates to:
  /// **'Remaining newbie tickets as bootsrapper:'**
  String get remainingNewbieTicketsAsBootStrapper;

  /// No description provided for @remainingNewbieTicketsAsReputable.
  ///
  /// In en, this message translates to:
  /// **'Remaining newbie tickets as reputable:'**
  String get remainingNewbieTicketsAsReputable;

  /// No description provided for @remarkNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'You have submitted a note.'**
  String get remarkNotificationBody;

  /// No description provided for @remarkNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'note submitted'**
  String get remarkNotificationTitle;

  /// No description provided for @remarks.
  ///
  /// In en, this message translates to:
  /// **'Onchain Remarks'**
  String get remarks;

  /// No description provided for @remarksButton.
  ///
  /// In en, this message translates to:
  /// **'submit public note'**
  String get remarksButton;

  /// No description provided for @remarksExplain.
  ///
  /// In en, this message translates to:
  /// **'You can submit a note to the network. This note will be public and immutable. It can be read and authenticated by everyone as it will be digitally signed by you.'**
  String get remarksExplain;

  /// No description provided for @remarksNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get remarksNote;

  /// No description provided for @remarksSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit note'**
  String get remarksSubmit;

  /// No description provided for @reputableContent.
  ///
  /// In en, this message translates to:
  /// **'You used your reputation to get a guaranteed seat. Caution: Should you register, but not show up at the cycle, you become a newbie again.'**
  String get reputableContent;

  /// No description provided for @reputableTitle.
  ///
  /// In en, this message translates to:
  /// **'Registered as reputable - your seat is guaranteed'**
  String get reputableTitle;

  /// No description provided for @reputationAlreadyCommittedTitle.
  ///
  /// In en, this message translates to:
  /// **'Reputation already used'**
  String get reputationAlreadyCommittedTitle;

  /// No description provided for @reputationAlreadyCommittedContent.
  ///
  /// In en, this message translates to:
  /// **'You have already used your reputation to drip the faucet.'**
  String get reputationAlreadyCommittedContent;

  /// No description provided for @reputationOverall.
  ///
  /// In en, this message translates to:
  /// **'Overall reputation'**
  String get reputationOverall;

  /// No description provided for @restartGathering.
  ///
  /// In en, this message translates to:
  /// **'Restart gathering'**
  String get restartGathering;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @rewardsAlreadyIssuedErrorBody.
  ///
  /// In en, this message translates to:
  /// **'Another attendee has triggered the payout for this gathering. You should have received your income already.'**
  String get rewardsAlreadyIssuedErrorBody;

  /// No description provided for @rewardsAlreadyIssuedErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Rewards already issued'**
  String get rewardsAlreadyIssuedErrorTitle;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @scanDescriptionForMeetup.
  ///
  /// In en, this message translates to:
  /// **'Every attendee must scan and be scanned by everyone else.'**
  String get scanDescriptionForMeetup;

  /// No description provided for @scanOthers.
  ///
  /// In en, this message translates to:
  /// **'Scan others'**
  String get scanOthers;

  /// No description provided for @scanQrCodeOnTheLeft.
  ///
  /// In en, this message translates to:
  /// **'2. Scan the QR code \non the left'**
  String get scanQrCodeOnTheLeft;

  /// No description provided for @sendLink.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get sendLink;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get setting;

  /// No description provided for @settingLang.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingLang;

  /// No description provided for @settingLangAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto Detect'**
  String get settingLangAuto;

  /// No description provided for @settingNetwork.
  ///
  /// In en, this message translates to:
  /// **'Select Wallet'**
  String get settingNetwork;

  /// No description provided for @settingNode.
  ///
  /// In en, this message translates to:
  /// **'Remote Node'**
  String get settingNode;

  /// No description provided for @settingNodeList.
  ///
  /// In en, this message translates to:
  /// **'Available Nodes'**
  String get settingNodeList;

  /// No description provided for @settingPrefix.
  ///
  /// In en, this message translates to:
  /// **'Address Prefix'**
  String get settingPrefix;

  /// No description provided for @settingPrefixList.
  ///
  /// In en, this message translates to:
  /// **'Available Prefixes'**
  String get settingPrefixList;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @shareInvoice.
  ///
  /// In en, this message translates to:
  /// **'Share Invoice'**
  String get shareInvoice;

  /// No description provided for @shareLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Or you can share a link:'**
  String get shareLinkHint;

  /// No description provided for @showRouteMeetupLocation.
  ///
  /// In en, this message translates to:
  /// **'Show route'**
  String get showRouteMeetupLocation;

  /// No description provided for @startGathering.
  ///
  /// In en, this message translates to:
  /// **'Start gathering'**
  String get startGathering;

  /// No description provided for @submittedFaucetDripTitle.
  ///
  /// In en, this message translates to:
  /// **'Faucet rewards'**
  String get submittedFaucetDripTitle;

  /// No description provided for @submittedFaucetDripBody.
  ///
  /// In en, this message translates to:
  /// **'You have successfully claimed your faucet rewards.'**
  String get submittedFaucetDripBody;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @switchAccount.
  ///
  /// In en, this message translates to:
  /// **'Switch Account'**
  String get switchAccount;

  /// No description provided for @switchCommunity.
  ///
  /// In en, this message translates to:
  /// **'Switch Community'**
  String get switchCommunity;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you'**
  String get thankYou;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get title;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @transactionError.
  ///
  /// In en, this message translates to:
  /// **'Transaction error'**
  String get transactionError;

  /// No description provided for @transactionQueuedOffline.
  ///
  /// In en, this message translates to:
  /// **'App is not connected to the blockchain. Queued transaction (will be sent automatically upon reconnection).'**
  String get transactionQueuedOffline;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get transfer;

  /// No description provided for @transferHistory.
  ///
  /// In en, this message translates to:
  /// **'Transfers'**
  String get transferHistory;

  /// No description provided for @transferHistoryEnd.
  ///
  /// In en, this message translates to:
  /// **'Loading older transactions is not yet supported'**
  String get transferHistoryEnd;

  /// No description provided for @transferHistoryTop.
  ///
  /// In en, this message translates to:
  /// **'It may take up to 30 seconds for a transfer to appear here'**
  String get transferHistoryTop;

  /// No description provided for @treasuryBalanceTooLow.
  ///
  /// In en, this message translates to:
  /// **'Treasury Balance too low'**
  String get treasuryBalanceTooLow;

  /// No description provided for @treasuryGlobalBalance.
  ///
  /// In en, this message translates to:
  /// **'Free global treasury balance: {balance} KSM.'**
  String treasuryGlobalBalance(String balance);

  /// No description provided for @treasuryLocalBalance.
  ///
  /// In en, this message translates to:
  /// **'Free community treasury balance: {balance} KSM.'**
  String treasuryLocalBalance(String balance);

  /// No description provided for @treasuryLocalBalanceOnAHK.
  ///
  /// In en, this message translates to:
  /// **'Free community treasury balance on Asset Hub: {balance} {asset}.'**
  String treasuryLocalBalanceOnAHK(String balance, String asset);

  /// No description provided for @treasuryPendingSpends.
  ///
  /// In en, this message translates to:
  /// **'Pending spends: {spends} KSM.'**
  String treasuryPendingSpends(String spends);

  /// No description provided for @txBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Transaction has been broadcast.'**
  String get txBroadcast;

  /// No description provided for @txError.
  ///
  /// In en, this message translates to:
  /// **'Transaction error'**
  String get txError;

  /// No description provided for @txInBlock.
  ///
  /// In en, this message translates to:
  /// **'Transaction is in a block.'**
  String get txInBlock;

  /// No description provided for @txQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued Transaction'**
  String get txQueued;

  /// No description provided for @txQueuedOffline.
  ///
  /// In en, this message translates to:
  /// **'You are offline. Transaction will be sent when you are back online.'**
  String get txQueuedOffline;

  /// No description provided for @txReady.
  ///
  /// In en, this message translates to:
  /// **'Transaction is ready.'**
  String get txReady;

  /// No description provided for @txTooLowPriorityErrorBody.
  ///
  /// In en, this message translates to:
  /// **'Technical transaction priority error. This can happen if you tap twice on a submit button very quickly. Please wait for a few seconds.'**
  String get txTooLowPriorityErrorBody;

  /// No description provided for @txTooLowPriorityErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction priority error'**
  String get txTooLowPriorityErrorTitle;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @unknownAccount.
  ///
  /// In en, this message translates to:
  /// **'Unknown account'**
  String get unknownAccount;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please check your internet connection and try again.'**
  String get unknownError;

  /// No description provided for @unregister.
  ///
  /// In en, this message translates to:
  /// **'Unregister'**
  String get unregister;

  /// No description provided for @unregisterDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Unregister from the next cycle?'**
  String get unregisterDialogTitle;

  /// No description provided for @unregisterParticipantNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'Your registration for the next cycle has been cancelled. If you change your mind, you can register again.'**
  String get unregisterParticipantNotificationBody;

  /// No description provided for @unregisterParticipantNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration cancelled'**
  String get unregisterParticipantNotificationTitle;

  /// No description provided for @updatingAppState.
  ///
  /// In en, this message translates to:
  /// **'Updating the app state...'**
  String get updatingAppState;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @votesNotDependableErrorBody.
  ///
  /// In en, this message translates to:
  /// **'Only half or less of the assigned participants were attested for this gathering. It could also be that some attendees haven\'t submitted their attestation yet. This prevents the early payout, and you need to wait for 48 hours.'**
  String get votesNotDependableErrorBody;

  /// No description provided for @votesNotDependableErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Votes not dependable'**
  String get votesNotDependableErrorTitle;

  /// No description provided for @voucher.
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get voucher;

  /// No description provided for @voucherBalance.
  ///
  /// In en, this message translates to:
  /// **'Voucher Balance'**
  String get voucherBalance;

  /// No description provided for @voucherBalanceTooLow.
  ///
  /// In en, this message translates to:
  /// **'The voucher has insufficient funds to be redeemed.'**
  String get voucherBalanceTooLow;

  /// No description provided for @weHopeToSeeYouAtTheNextGathering.
  ///
  /// In en, this message translates to:
  /// **'We hope to see you at the next gathering.'**
  String get weHopeToSeeYouAtTheNextGathering;

  /// No description provided for @wrongPin.
  ///
  /// In en, this message translates to:
  /// **'Wrong PIN'**
  String get wrongPin;

  /// No description provided for @wrongPinHint.
  ///
  /// In en, this message translates to:
  /// **'Failed to unlock account, please check PIN.'**
  String get wrongPinHint;

  /// No description provided for @youAreNotRegisteredPleaseRegisterNextTime.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t been assigned for this key-signing cycle. Please join the next cycle to receive your community income.'**
  String get youAreNotRegisteredPleaseRegisterNextTime;

  /// No description provided for @yourNewPin.
  ///
  /// In en, this message translates to:
  /// **'New PIN'**
  String get yourNewPin;

  /// No description provided for @unlockAccount.
  ///
  /// In en, this message translates to:
  /// **'Unlock account {currentAccountName} with PIN'**
  String unlockAccount(String currentAccountName);

  /// No description provided for @errorMessageWithStatusCode.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again! StatusCode: {errorText}'**
  String errorMessageWithStatusCode(String errorText);

  /// No description provided for @yourBalanceFor.
  ///
  /// In en, this message translates to:
  /// **'Your balance, {accountName}'**
  String yourBalanceFor(String accountName);

  /// No description provided for @incomingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'incoming {amount} {cidSymbol} for {accountName} confirmed'**
  String incomingConfirmed(num amount, String cidSymbol, String accountName);

  /// No description provided for @voucherDifferentNetworkAndCommunity.
  ///
  /// In en, this message translates to:
  /// **'The voucher is for a different network. Do you want to change to {network} and {community}? You can change the network back under Profile > Developer mode'**
  String voucherDifferentNetworkAndCommunity(String network, String community);

  /// No description provided for @voucherDifferentCommunity.
  ///
  /// In en, this message translates to:
  /// **'The voucher is for a different community. Do you want to change to {community}?'**
  String voucherDifferentCommunity(String community);

  /// No description provided for @doYouWantToRedeemThisVoucher.
  ///
  /// In en, this message translates to:
  /// **'Do you want to redeem this voucher to {accountName}?'**
  String doYouWantToRedeemThisVoucher(String accountName);

  /// No description provided for @claimsSubmitN.
  ///
  /// In en, this message translates to:
  /// **'Submit {count} claims'**
  String claimsSubmitN(int count);

  /// No description provided for @claimsScanned.
  ///
  /// In en, this message translates to:
  /// **'You have scanned {amount} claims'**
  String claimsScanned(num amount);

  /// No description provided for @claimsScannedNOfM.
  ///
  /// In en, this message translates to:
  /// **'Scanned {scannedCount} / {totalCount} Claims'**
  String claimsScannedNOfM(int scannedCount, int totalCount);

  /// No description provided for @claimsSubmitDetail.
  ///
  /// In en, this message translates to:
  /// **'Submitting {amount} claims for the recent gathering'**
  String claimsSubmitDetail(num amount);

  /// No description provided for @youAreRegisteredAs.
  ///
  /// In en, this message translates to:
  /// **'You have registered for the next gathering as {participantType}.'**
  String youAreRegisteredAs(String participantType);

  /// No description provided for @youAreAssignedToAGatheringWithNParticipants.
  ///
  /// In en, this message translates to:
  /// **'You are assigned to a gathering with {participantsCount} people.'**
  String youAreAssignedToAGatheringWithNParticipants(int participantsCount);

  /// No description provided for @successfullySentNAttestations.
  ///
  /// In en, this message translates to:
  /// **'You have successfully submitted attestations for {participantsCount} other people.'**
  String successfullySentNAttestations(int participantsCount);

  /// No description provided for @tokenSend.
  ///
  /// In en, this message translates to:
  /// **'Send {symbol}'**
  String tokenSend(String symbol);

  /// No description provided for @communityWithName.
  ///
  /// In en, this message translates to:
  /// **'{name} Community'**
  String communityWithName(String name);

  /// No description provided for @verifyAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Please verify {useBioAuth, select, true{your identity} false{your PIN} other{ }}.'**
  String verifyAuthTitle(String useBioAuth);

  /// No description provided for @offersForCommunity.
  ///
  /// In en, this message translates to:
  /// **'Offers for {value}'**
  String offersForCommunity(String value);

  /// No description provided for @proposalApprovalThreshold.
  ///
  /// In en, this message translates to:
  /// **'Approval Threshold: {percentage}%'**
  String proposalApprovalThreshold(String percentage);

  /// No description provided for @proposalPassed.
  ///
  /// In en, this message translates to:
  /// **'Passed with {percentage}% Aye'**
  String proposalPassed(String percentage);

  /// No description provided for @proposalFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed with {percentage}% Aye'**
  String proposalFailed(String percentage);

  /// No description provided for @proposalIsPassing.
  ///
  /// In en, this message translates to:
  /// **'Currently passing with {percentage}% Aye'**
  String proposalIsPassing(String percentage);

  /// No description provided for @proposalIsFailing.
  ///
  /// In en, this message translates to:
  /// **'Currently failing with {percentage}% Aye'**
  String proposalIsFailing(String percentage);

  /// No description provided for @proposalSetInactivityTimeoutTo.
  ///
  /// In en, this message translates to:
  /// **'Global: Set the new inactivity timeout to {value}'**
  String proposalSetInactivityTimeoutTo(String value);

  /// No description provided for @proposalAddLocation.
  ///
  /// In en, this message translates to:
  /// **'{cid}: Add a new location'**
  String proposalAddLocation(String cid);

  /// No description provided for @proposalRemoveLocation.
  ///
  /// In en, this message translates to:
  /// **'{cid} Remove a location'**
  String proposalRemoveLocation(String cid);

  /// No description provided for @proposalUpdateNominalIncome.
  ///
  /// In en, this message translates to:
  /// **'Update community income to {value} {currency}'**
  String proposalUpdateNominalIncome(String value, String currency);

  /// No description provided for @proposalUpdateDemurrage.
  ///
  /// In en, this message translates to:
  /// **'Update demurrage to {value}%/month'**
  String proposalUpdateDemurrage(String value);

  /// No description provided for @proposalPetition.
  ///
  /// In en, this message translates to:
  /// **'{cid} petition: {value}'**
  String proposalPetition(String cid, String value);

  /// No description provided for @proposalSpendNative.
  ///
  /// In en, this message translates to:
  /// **'{cid} treasury shall spend {amount} KSM to {beneficiary}'**
  String proposalSpendNative(String cid, String amount, String beneficiary);

  /// No description provided for @proposalSpendAsset.
  ///
  /// In en, this message translates to:
  /// **'{cid} treasury shall spend {amount} {asset} to {beneficiary}'**
  String proposalSpendAsset(
      String asset, String cid, String amount, String beneficiary);

  /// No description provided for @proposalIssueSwapNativeOption.
  ///
  /// In en, this message translates to:
  /// **'{cid}: Let {beneficiary} exchange up to {allowance} KSM at a rate of {rate} {cid}/KSM'**
  String proposalIssueSwapNativeOption(
      String cid, String beneficiary, String allowance, String rate);

  /// No description provided for @proposalIssueSwapOptionCCLimit.
  ///
  /// In en, this message translates to:
  /// **'You can exchange up to {allowance} {cc} to reach your defined {asset} limit.'**
  String proposalIssueSwapOptionCCLimit(
      String asset, String cc, String allowance);

  /// No description provided for @proposalIssueSwapAssetOption.
  ///
  /// In en, this message translates to:
  /// **'{cid}: Let {beneficiary} exchange up to {allowance} {asset} at a rate of {rate} {cid}/{asset}'**
  String proposalIssueSwapAssetOption(String asset, String cid,
      String beneficiary, String allowance, String rate);

  /// No description provided for @proposalSupersededBy.
  ///
  /// In en, this message translates to:
  /// **'Superseded by: {id}'**
  String proposalSupersededBy(String id);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'fr', 'ru', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ru':
      return AppLocalizationsRu();
    case 'sw':
      return AppLocalizationsSw();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
