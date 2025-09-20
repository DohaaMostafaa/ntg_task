import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'language';

  static Future<void> changeLanguage(BuildContext context, Locale newLocale) async {
    try {
      await context.setLocale(newLocale);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, newLocale.languageCode);
    } catch (error) {
      throw Exception('Failed to change language: $error');
    }
  }

  static Future<Locale> getSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageKey) ?? 'en'; // Default to English
      return Locale(languageCode);
    } catch (error) {
      throw Exception('Failed to get saved language: $error');
    }
  }

  static Future<void> toggleLanguage(BuildContext context) async {
    final currentLocale = context.locale;
    final newLocale = currentLocale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar');

    await changeLanguage(context, newLocale);
  }

  static bool isRTL(Locale locale) {
    return locale.languageCode == 'ar';
  }

}