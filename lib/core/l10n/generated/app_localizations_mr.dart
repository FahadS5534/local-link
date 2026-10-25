// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'लोकल-लिंक';

  @override
  String get appTagline => 'मुंबई लोकल ट्रेन सोबती';

  @override
  String get navSearch => 'शोधा';

  @override
  String get navLines => 'मार्गांची यादी';

  @override
  String get navAlerts => 'अलार्म';

  @override
  String get navSettings => 'सेटिंग्ज';

  @override
  String get searchScreenTitle => 'गाड्या शोधा';

  @override
  String get searchButtonLabel => 'मार्ग शोधा';

  @override
  String get originPlaceholder => 'प्रारंभिक स्टेशन निवडा';

  @override
  String get destinationPlaceholder => 'गंतव्य स्टेशन निवडा';

  @override
  String get swapStationsTooltip => 'स्टेशने बदला';

  @override
  String get linesScreenTitle => 'उपनगरीय मार्ग';

  @override
  String get westernLineTitle => 'पश्चिम रेल्वे (वेस्टर्न)';

  @override
  String get centralLineTitle => 'मध्य रेल्वे (सेंट्रल मेन)';

  @override
  String get harbourLineTitle => 'हार्बर मार्ग';

  @override
  String get transHarbourLineTitle => 'ट्रान्स-हार्बर मार्ग';

  @override
  String get alertsScreenTitle => 'स्टेशन अलार्म';

  @override
  String get noActiveAlerts => 'कोणतेही सक्रिय अलार्म नाहीत';

  @override
  String get alertsDescription =>
      'आपल्या गंतव्य स्टेशनसाठी अलार्म सेट करा जेणेकरून उतरण्यापूर्वी तुम्हाला पूर्वसूचना मिळेल.';

  @override
  String get settingsScreenTitle => 'प्राधान्ये';

  @override
  String get languageSetting => 'अ‍ॅप भाषा';

  @override
  String get english => 'English (इंग्रजी)';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get marathi => 'मराठी';

  @override
  String get themeSetting => 'थीम स्वरूप';

  @override
  String get themeSystem => 'प्रणाली डीफॉल्ट';

  @override
  String get themeLight => 'लाइट मोड';

  @override
  String get themeDark => 'डार्क मोड';

  @override
  String get aboutTitle => 'लोकल-लिंक विषयी';

  @override
  String get offlineBadge => '१००% ऑफलाइन उपलब्ध';

  @override
  String get versionLabel => 'आवृत्ती';

  @override
  String get stationSearchPlaceholder => 'नाव किंवा कोडने शोधा...';

  @override
  String get fastTrainBadge => 'जलद';

  @override
  String get slowTrainBadge => 'धीमी';

  @override
  String get directRouteBadge => 'थेट';

  @override
  String get transferRouteBadge => 'बदला';

  @override
  String transferAt(String station) {
    return '$station येथे बदला';
  }

  @override
  String stopsCount(int count) {
    return '$count थांबे';
  }

  @override
  String durationFormat(int minutes) {
    return '$minutes मिनिटे';
  }

  @override
  String platformLabel(String platform) {
    return 'प्लॅटफॉर्म $platform';
  }

  @override
  String get viewIntermediateStops => 'सर्व थांबे पहा';

  @override
  String get hideIntermediateStops => 'थांबे लपवा';

  @override
  String get skippedStation => 'थांबा नाही';

  @override
  String get noTrainsFound => 'या मार्गावर कोणतीही गाडी उपलब्ध नाही';

  @override
  String get filterAll => 'सर्व';

  @override
  String get filterFast => 'जलद';

  @override
  String get filterSlow => 'धीमी';

  @override
  String get selectStationTitle => 'स्टेशन निवडा';

  @override
  String get majorJunctions => 'महत्त्वाची जंक्शन स्टेशने';

  @override
  String get crowdReportTitle => 'डब्यातील गर्दी';

  @override
  String get reportCrowdButton => 'गर्दी नोंदवा';

  @override
  String get crowdDisclaimer => 'प्रवाशांचा अंदाज • अधिकृत रेल्वे माहिती नाही';

  @override
  String get coachSecondClass => 'द्वितीय वर्ग (सेकंड क्लास)';

  @override
  String get coachFirstClass => 'प्रथम वर्ग (फर्स्ट क्लास)';

  @override
  String get coachLadies => 'महिला डबा';

  @override
  String get coachDivyang => 'दिव्यांग डबा';

  @override
  String get densityLow => 'जागा उपलब्ध';

  @override
  String get densityMedium => 'उभे राहण्यास जागा';

  @override
  String get densityHeavy => 'गर्दी (पॅक)';

  @override
  String get densitySuperDense => 'प्रचंड गर्दी';

  @override
  String get freshBadge => 'ताजी माहिती';

  @override
  String get expiringBadge => 'जुनी माहिती';

  @override
  String get submitReport => 'नोंदवा';

  @override
  String get reportSuccess => 'इतर प्रवाशांना मदत केल्याबद्दल धन्यवाद!';

  @override
  String get setStationAlert => 'स्थानक अलार्म सेट करा';

  @override
  String get addAlert => 'अलार्म जोडा';

  @override
  String get deleteAlert => 'अलार्म हटवा';

  @override
  String get alertRadius => 'अलार्म अंतर';

  @override
  String get radius500m => '५०० मीटर';

  @override
  String get radius1000m => '१ किमी';

  @override
  String get radius2000m => '२ किमी';

  @override
  String alertTriggered(String station) {
    return '$station वर आगमन होत आहे!';
  }

  @override
  String get alertActive => 'सक्रिय';

  @override
  String get alertMuted => 'म्यूट';

  @override
  String get alertCreatedSuccess => 'स्थानक अलार्म यशस्वीरित्या सेट केला';

  @override
  String get alertDeletedSuccess => 'अलार्म काढला';
}
