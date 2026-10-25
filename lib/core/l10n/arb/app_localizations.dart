import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
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
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'LocalLink'**
  String get appTitle;

  /// The subtitle/tagline of the application
  ///
  /// In en, this message translates to:
  /// **'Mumbai Local Train Companion'**
  String get appTagline;

  /// Bottom navigation label for search screen
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// Bottom navigation label for lines screen
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get navLines;

  /// Bottom navigation label for alerts screen
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get navAlerts;

  /// Bottom navigation label for settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Title of the search and route finder screen
  ///
  /// In en, this message translates to:
  /// **'Find Trains'**
  String get searchScreenTitle;

  /// Placeholder for origin station selector
  ///
  /// In en, this message translates to:
  /// **'Select Origin Station'**
  String get originPlaceholder;

  /// Placeholder for destination station selector
  ///
  /// In en, this message translates to:
  /// **'Select Destination Station'**
  String get destinationPlaceholder;

  /// Accessibility tooltip for swapping stations
  ///
  /// In en, this message translates to:
  /// **'Swap Origin and Destination'**
  String get swapStationsTooltip;

  /// Title for the lines screen
  ///
  /// In en, this message translates to:
  /// **'Suburban Corridors'**
  String get linesScreenTitle;

  /// Name of the Western railway line
  ///
  /// In en, this message translates to:
  /// **'Western Line'**
  String get westernLineTitle;

  /// Name of the Central railway line
  ///
  /// In en, this message translates to:
  /// **'Central Line (Main)'**
  String get centralLineTitle;

  /// Name of the Harbour railway line
  ///
  /// In en, this message translates to:
  /// **'Harbour Line'**
  String get harbourLineTitle;

  /// Name of the Trans-Harbour line
  ///
  /// In en, this message translates to:
  /// **'Trans-Harbour Line'**
  String get transHarbourLineTitle;

  /// Title for the station proximity alerts screen
  ///
  /// In en, this message translates to:
  /// **'Station Alarms'**
  String get alertsScreenTitle;

  /// Empty state label for alerts
  ///
  /// In en, this message translates to:
  /// **'No active alarms'**
  String get noActiveAlerts;

  /// Description of proximity alarms
  ///
  /// In en, this message translates to:
  /// **'Set an alarm for your destination station to alert you before your stop.'**
  String get alertsDescription;

  /// Title for the settings screen
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsScreenTitle;

  /// Setting label for language
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get languageSetting;

  /// Language name for English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Language name for Hindi
  ///
  /// In en, this message translates to:
  /// **'हिन्दी (Hindi)'**
  String get hindi;

  /// Language name for Marathi
  ///
  /// In en, this message translates to:
  /// **'मराठी (Marathi)'**
  String get marathi;

  /// Setting label for theme mode
  ///
  /// In en, this message translates to:
  /// **'Theme Appearance'**
  String get themeSetting;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeSystem;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get themeLight;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get themeDark;

  /// Label for about app section
  ///
  /// In en, this message translates to:
  /// **'About LocalLink'**
  String get aboutTitle;

  /// Badge showing app operates offline
  ///
  /// In en, this message translates to:
  /// **'100% Offline Ready'**
  String get offlineBadge;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;
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
      <String>['en', 'hi', 'mr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
