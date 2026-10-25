import 'package:flutter/widgets.dart';
import 'generated/app_localizations.dart';

/// Convenient extension on [BuildContext] to access [AppLocalizations].
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n {
    final localizations = AppLocalizations.of(this);
    assert(localizations != null, 'No AppLocalizations found in context');
    return localizations!;
  }
}
