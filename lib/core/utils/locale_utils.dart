import 'package:flutter/material.dart';

class LocaleUtils {
  const LocaleUtils._();

  static bool isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }

  static Locale toggledLocale(BuildContext context) {
    return isEnglish(context) ? const Locale('ar') : const Locale('en');
  }

  static String toggleButtonText(BuildContext context) {
    return isEnglish(context) ? 'AR' : 'EN';
  }
}
