import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @registerSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Register successful!'**
  String get registerSuccessful;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @getCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **' get current location'**
  String get getCurrentLocation;

  /// No description provided for @pleasegetyourcurrentlocationfirst.
  ///
  /// In en, this message translates to:
  /// **'Please get your current location first'**
  String get pleasegetyourcurrentlocationfirst;

  /// No description provided for @alreadyhaveanaccount.
  ///
  /// In en, this message translates to:
  /// **' Already have an account?'**
  String get alreadyhaveanaccount;

  /// No description provided for @locationfetched.
  ///
  /// In en, this message translates to:
  /// **'Location fetched!'**
  String get locationfetched;

  /// No description provided for @thisfieldisrequired.
  ///
  /// In en, this message translates to:
  /// **'this field is required'**
  String get thisfieldisrequired;

  /// No description provided for @enternumbersonly.
  ///
  /// In en, this message translates to:
  /// **'enter numbers only'**
  String get enternumbersonly;

  /// No description provided for @entervaluemustequal11digit.
  ///
  /// In en, this message translates to:
  /// **'enter value must equal 11 digit'**
  String get entervaluemustequal11digit;

  /// No description provided for @enteryourfullname.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enteryourfullname;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enteryourmobilenumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get enteryourmobilenumber;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @enteryourcarmodel.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Car Model'**
  String get enteryourcarmodel;

  /// No description provided for @enteryourcarNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your car Number'**
  String get enteryourcarNumber;

  /// No description provided for @selectDestinationfirst.
  ///
  /// In en, this message translates to:
  /// **'Select a destination first'**
  String get selectDestinationfirst;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get confirmLocation;

  /// No description provided for @searchdestination.
  ///
  /// In en, this message translates to:
  /// **'Search destination'**
  String get searchdestination;

  /// No description provided for @tripSummary.
  ///
  /// In en, this message translates to:
  /// **'Trip Summary'**
  String get tripSummary;

  /// No description provided for @createTrip.
  ///
  /// In en, this message translates to:
  /// **'Create Trip'**
  String get createTrip;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End: '**
  String get end;

  /// No description provided for @charactersMinimum.
  ///
  /// In en, this message translates to:
  /// **'8 characters Minimum '**
  String get charactersMinimum;

  /// No description provided for @atleast1uppercaseletter.
  ///
  /// In en, this message translates to:
  /// **'At least 1 uppercase letter'**
  String get atleast1uppercaseletter;

  /// No description provided for @atleast1lowercaseletter.
  ///
  /// In en, this message translates to:
  /// **'At least 1 lowercase letter'**
  String get atleast1lowercaseletter;

  /// No description provided for @onespecialcharacterandnumber.
  ///
  /// In en, this message translates to:
  /// **'One special character and number'**
  String get onespecialcharacterandnumber;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start: '**
  String get start;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @eGP.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get eGP;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @searchingforDriver.
  ///
  /// In en, this message translates to:
  /// **'Searching for Driver'**
  String get searchingforDriver;

  /// No description provided for @nodriversavailable.
  ///
  /// In en, this message translates to:
  /// **'No drivers available'**
  String get nodriversavailable;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @carModel.
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get carModel;

  /// No description provided for @carNumber.
  ///
  /// In en, this message translates to:
  /// **'Car Number'**
  String get carNumber;

  /// No description provided for @pleaseselectadriverfirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a driver first'**
  String get pleaseselectadriverfirst;

  /// No description provided for @myrequests.
  ///
  /// In en, this message translates to:
  /// **'MyRequests'**
  String get myrequests;

  /// No description provided for @requestcar.
  ///
  /// In en, this message translates to:
  /// **'Requestcar'**
  String get requestcar;

  /// No description provided for @mytrip.
  ///
  /// In en, this message translates to:
  /// **'My Trips'**
  String get mytrip;

  /// No description provided for @thelastTrips.
  ///
  /// In en, this message translates to:
  /// **' The Last Trips'**
  String get thelastTrips;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers '**
  String get offers;

  /// No description provided for @paidManaged.
  ///
  /// In en, this message translates to:
  /// **' paidManaged'**
  String get paidManaged;

  /// No description provided for @tripsFollow.
  ///
  /// In en, this message translates to:
  /// **'  tripsFollow'**
  String get tripsFollow;

  /// No description provided for @riders.
  ///
  /// In en, this message translates to:
  /// **'  riders '**
  String get riders;

  /// No description provided for @offersmanage.
  ///
  /// In en, this message translates to:
  /// **' offersmanage '**
  String get offersmanage;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @welcom.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcom;

  /// No description provided for @welcomeCustomer.
  ///
  /// In en, this message translates to:
  /// **'welcome Guest'**
  String get welcomeCustomer;

  /// No description provided for @startyourjourney.
  ///
  /// In en, this message translates to:
  /// **'start your journey'**
  String get startyourjourney;

  /// No description provided for @areyouready.
  ///
  /// In en, this message translates to:
  /// **'are you ready?'**
  String get areyouready;

  /// No description provided for @subtitle1.
  ///
  /// In en, this message translates to:
  /// **'request your car'**
  String get subtitle1;

  /// No description provided for @subtitle2.
  ///
  /// In en, this message translates to:
  /// **'and join with good trip'**
  String get subtitle2;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile '**
  String get profile;

  /// No description provided for @darkmode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode '**
  String get darkmode;

  /// No description provided for @lightmode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode '**
  String get lightmode;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login '**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout '**
  String get logout;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back '**
  String get welcomeBack;

  /// No description provided for @pleasesigninwithyourmail.
  ///
  /// In en, this message translates to:
  /// **'Please sign in with your mail '**
  String get pleasesigninwithyourmail;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account '**
  String get createAccount;

  /// No description provided for @donotHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have An A ccount '**
  String get donotHaveAnAccount;

  /// No description provided for @questionMark.
  ///
  /// In en, this message translates to:
  /// **'  ?  '**
  String get questionMark;

  /// No description provided for @enteryouremail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enteryouremail;

  /// No description provided for @enteryourpassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enteryourpassword;

  /// No description provided for @tripsPage.
  ///
  /// In en, this message translates to:
  /// **'TripsPage'**
  String get tripsPage;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @enternewname.
  ///
  /// In en, this message translates to:
  /// **'enter your new name'**
  String get enternewname;

  /// No description provided for @editname.
  ///
  /// In en, this message translates to:
  /// **' edit name'**
  String get editname;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get canceled;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'save'**
  String get saved;

  /// No description provided for @myboket.
  ///
  /// In en, this message translates to:
  /// **'myboket'**
  String get myboket;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
