import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gere la langue active de l'application (fr | en). La preference est
/// persistee localement (disponible immediatement au demarrage, avant meme
/// que le profil serveur soit charge) et peut aussi etre synchronisee avec le
/// champ `preferredLanguage` du profil utilisateur (voir ProfileScreen).
class LocaleProvider extends ChangeNotifier {
  static const _prefsKey = 'app_locale';
  static const supportedLanguageCodes = ['fr', 'en'];

  Locale _locale = const Locale('fr');
  Locale get locale => _locale;

  Future<void> loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);
    if (saved != null && supportedLanguageCodes.contains(saved)) {
      _locale = Locale(saved);
      notifyListeners();
    }
  }

  Future<void> setLanguageCode(String code) async {
    if (!supportedLanguageCodes.contains(code)) return;
    _locale = Locale(code);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, code);
  }
}
