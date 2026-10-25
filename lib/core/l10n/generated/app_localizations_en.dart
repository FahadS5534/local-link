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
  String get searchButtonLabel => 'Search Routes';

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

  @override
  String get stationSearchPlaceholder => 'Search by name or code...';

  @override
  String get fastTrainBadge => 'FAST';

  @override
  String get slowTrainBadge => 'SLOW';

  @override
  String get directRouteBadge => 'Direct';

  @override
  String get transferRouteBadge => 'Transfer';

  @override
  String transferAt(String station) {
    return 'Transfer at $station';
  }

  @override
  String stopsCount(int count) {
    return '$count stops';
  }

  @override
  String durationFormat(int minutes) {
    return '$minutes min';
  }

  @override
  String platformLabel(String platform) {
    return 'Platform $platform';
  }

  @override
  String get viewIntermediateStops => 'View All Stops';

  @override
  String get hideIntermediateStops => 'Hide Stops';

  @override
  String get skippedStation => 'Skipped';

  @override
  String get noTrainsFound => 'No trains scheduled for this route';

  @override
  String get filterAll => 'All';

  @override
  String get filterFast => 'Fast';

  @override
  String get filterSlow => 'Slow';

  @override
  String get selectStationTitle => 'Select Station';

  @override
  String get majorJunctions => 'Major Junction Stations';

  @override
  String get crowdReportTitle => 'Coach Crowding';

  @override
  String get reportCrowdButton => 'Report Crowding';

  @override
  String get crowdDisclaimer =>
      'Crowdsourced commuter estimate • Not an official railway feed';

  @override
  String get coachSecondClass => 'Second Class';

  @override
  String get coachFirstClass => 'First Class';

  @override
  String get coachLadies => 'Ladies';

  @override
  String get coachDivyang => 'Divyang';

  @override
  String get densityLow => 'Seats Available';

  @override
  String get densityMedium => 'Standing Room';

  @override
  String get densityHeavy => 'Packed';

  @override
  String get densitySuperDense => 'Super-Dense';

  @override
  String get freshBadge => 'Fresh';

  @override
  String get expiringBadge => 'Expiring';

  @override
  String get submitReport => 'Submit Report';

  @override
  String get reportSuccess => 'Thank you for helping fellow commuters!';

  @override
  String get setStationAlert => 'Set Station Alarm';

  @override
  String get addAlert => 'Add Alarm';

  @override
  String get deleteAlert => 'Delete Alarm';

  @override
  String get alertRadius => 'Alarm Distance';

  @override
  String get radius500m => '500 meters';

  @override
  String get radius1000m => '1 kilometer';

  @override
  String get radius2000m => '2 kilometers';

  @override
  String alertTriggered(String station) {
    return 'Arriving at $station!';
  }

  @override
  String get alertActive => 'Active';

  @override
  String get alertMuted => 'Muted';

  @override
  String get alertCreatedSuccess => 'Station alarm set successfully';

  @override
  String get alertDeletedSuccess => 'Alarm removed';
}
