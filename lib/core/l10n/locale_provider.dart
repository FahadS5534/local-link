import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Supported application locales for Mumbai Suburban Railway commuters.
abstract final class SupportedLocales {
  static const english = Locale('en');
  static const hindi = Locale('hi');
  static const marathi = Locale('mr');

  static const all = [english, hindi, marathi];
}

/// State notifier managing the user's selected application [Locale].
class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    return SupportedLocales.english;
  }

  void setLocale(Locale newLocale) {
    if (SupportedLocales.all.contains(newLocale)) {
      state = newLocale;
    }
  }
}

/// Global provider for application [Locale].
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);
