// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'लोकल-लिंक';

  @override
  String get appTagline => 'मुंबई लोकल ट्रेन साथी';

  @override
  String get navSearch => 'खोजें';

  @override
  String get navLines => 'लाइन्स';

  @override
  String get navAlerts => 'अलार्म';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get searchScreenTitle => 'ट्रेनें खोजें';

  @override
  String get searchButtonLabel => 'मार्ग खोजें';

  @override
  String get originPlaceholder => 'शुरुआती स्टेशन चुनें';

  @override
  String get destinationPlaceholder => 'गंतव्य स्टेशन चुनें';

  @override
  String get swapStationsTooltip => 'स्टेशनों को आपस में बदलें';

  @override
  String get linesScreenTitle => 'उपनगरीय कॉरिडोर';

  @override
  String get westernLineTitle => 'पश्चिम रेलवे (वेस्टर्न)';

  @override
  String get centralLineTitle => 'मध्य रेलवे (सेंट्रल मेन)';

  @override
  String get harbourLineTitle => 'हार्बर लाइन';

  @override
  String get transHarbourLineTitle => 'ट्रांस-हार्बर लाइन';

  @override
  String get alertsScreenTitle => 'स्टेशन अलार्म';

  @override
  String get noActiveAlerts => 'कोई सक्रिय अलार्म नहीं';

  @override
  String get alertsDescription =>
      'अपने गंतव्य स्टेशन के लिए अलार्म सेट करें ताकि उतरने से पहले आपको सतर्क किया जा सके।';

  @override
  String get settingsScreenTitle => 'प्राथमिकताएं';

  @override
  String get languageSetting => 'ऐप भाषा';

  @override
  String get english => 'English (अंग्रेज़ी)';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get marathi => 'मराठी';

  @override
  String get themeSetting => 'थीम रूप-रंग';

  @override
  String get themeSystem => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get themeLight => 'लाइट मोड';

  @override
  String get themeDark => 'डार्क मोड';

  @override
  String get aboutTitle => 'लोकल-लिंक के बारे में';

  @override
  String get offlineBadge => '100% ऑफ़लाइन सक्षम';

  @override
  String get versionLabel => 'संस्करण';

  @override
  String get stationSearchPlaceholder => 'नाम या कोड द्वारा खोजें...';

  @override
  String get fastTrainBadge => 'तेज';

  @override
  String get slowTrainBadge => 'धीमी';

  @override
  String get directRouteBadge => 'सीधी';

  @override
  String get transferRouteBadge => 'बदलें';

  @override
  String transferAt(String station) {
    return '$station पर बदलें';
  }

  @override
  String stopsCount(int count) {
    return '$count स्टेशन';
  }

  @override
  String durationFormat(int minutes) {
    return '$minutes मिनट';
  }

  @override
  String platformLabel(String platform) {
    return 'प्लेटफ़ॉर्म $platform';
  }

  @override
  String get viewIntermediateStops => 'सभी स्टॉप देखें';

  @override
  String get hideIntermediateStops => 'स्टॉप छिपाएं';

  @override
  String get skippedStation => 'स्टॉप नहीं';

  @override
  String get noTrainsFound => 'इस मार्ग पर कोई ट्रेन उपलब्ध नहीं है';

  @override
  String get filterAll => 'सभी';

  @override
  String get filterFast => 'तेज';

  @override
  String get filterSlow => 'धीमी';

  @override
  String get selectStationTitle => 'स्टेशन चुनें';

  @override
  String get majorJunctions => 'प्रमुख जंक्शन स्टेशन';

  @override
  String get crowdReportTitle => 'डिब्बे में भीड़';

  @override
  String get reportCrowdButton => 'भीड़ दर्ज करें';

  @override
  String get crowdDisclaimer =>
      'यात्रियों का अनुमान • आधिकारिक रेलवे जानकारी नहीं';

  @override
  String get coachSecondClass => 'द्वितीय श्रेणी (सेकंड क्लास)';

  @override
  String get coachFirstClass => 'प्रथम श्रेणी (फर्स्ट क्लास)';

  @override
  String get coachLadies => 'महिला डिब्बा';

  @override
  String get coachDivyang => 'दिव्यांग डिब्बा';

  @override
  String get densityLow => 'सीट उपलब्ध';

  @override
  String get densityMedium => 'खड़े होने की जगह';

  @override
  String get densityHeavy => 'भीड़ (पैक)';

  @override
  String get densitySuperDense => 'अत्यधिक भीड़';

  @override
  String get freshBadge => 'ताज़ा रिपोर्ट';

  @override
  String get expiringBadge => 'पुरानी रिपोर्ट';

  @override
  String get submitReport => 'दर्ज करें';

  @override
  String get reportSuccess => 'साथी यात्रियों की मदद करने के लिए धन्यवाद!';

  @override
  String get setStationAlert => 'स्टेशन अलार्म सेट करें';

  @override
  String get addAlert => 'अलार्म जोड़ें';

  @override
  String get deleteAlert => 'अलार्म हटाएं';

  @override
  String get alertRadius => 'अलार्म दूरी';

  @override
  String get radius500m => '500 मीटर';

  @override
  String get radius1000m => '1 किमी';

  @override
  String get radius2000m => '2 किमी';

  @override
  String alertTriggered(String station) {
    return '$station पर आगमन हो रहा है!';
  }

  @override
  String get alertActive => 'सक्रिय';

  @override
  String get alertMuted => 'म्यूट';

  @override
  String get alertCreatedSuccess => 'स्टेशन अलार्म सफलतापूर्वक सेट किया गया';

  @override
  String get alertDeletedSuccess => 'अलार्म हटाया गया';
}
