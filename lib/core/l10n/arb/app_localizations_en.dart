// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'LocalLink';

  @override
  String get appTagline => 'Mumbai Local Train Companion';

  @override
  String get navSearch => 'Search';

  @override
  String get navLines => 'Lines';

  @override
  String get navAlerts => 'Alerts';

  @override
  String get navSettings => 'Settings';

  @override
  String get searchScreenTitle => 'Find Trains';

  @override
  String get originPlaceholder => 'Select Origin Station';

  @override
  String get destinationPlaceholder => 'Select Destination Station';

  @override
  String get swapStationsTooltip => 'Swap Origin and Destination';

  @override
  String get linesScreenTitle => 'Suburban Corridors';

  @override
  String get westernLineTitle => 'Western Line';

  @override
  String get centralLineTitle => 'Central Line (Main)';

  @override
  String get harbourLineTitle => 'Harbour Line';

  @override
  String get transHarbourLineTitle => 'Trans-Harbour Line';

  @override
  String get alertsScreenTitle => 'Station Alarms';

  @override
  String get noActiveAlerts => 'No active alarms';

  @override
  String get alertsDescription =>
      'Set an alarm for your destination station to alert you before your stop.';

  @override
  String get settingsScreenTitle => 'Preferences';

  @override
  String get languageSetting => 'App Language';

  @override
  String get english => 'English';

  @override
  String get hindi => 'हिन्दी (Hindi)';

  @override
  String get marathi => 'मराठी (Marathi)';

  @override
  String get themeSetting => 'Theme Appearance';

  @override
  String get themeSystem => 'System Default';

  @override
  String get themeLight => 'Light Mode';

  @override
  String get themeDark => 'Dark Mode';

  @override
  String get aboutTitle => 'About LocalLink';

  @override
  String get offlineBadge => '100% Offline Ready';

  @override
  String get versionLabel => 'Version';
}
