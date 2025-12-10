import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_preferences.dart';

/// Serviço para gerenciar as preferências do aplicativo
class PreferencesService {
  static const String _vibrationKey = 'vibrationEnabled';
  static const String _soundKey = 'soundEnabled';
  static const String _bannerKey = 'bannerEnabled';
  static const String _criticalModeKey = 'criticalMode';
  static const String _systemEnabledKey = 'systemEnabled';

  /// Salva as preferências do aplicativo
  Future<bool> savePreferences(AppPreferences preferences) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_vibrationKey, preferences.vibrationEnabled);
      await prefs.setBool(_soundKey, preferences.soundEnabled);
      await prefs.setBool(_bannerKey, preferences.bannerEnabled);
      await prefs.setBool(_criticalModeKey, preferences.criticalMode);
      await prefs.setBool(_systemEnabledKey, preferences.systemEnabled);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Carrega as preferências do aplicativo
  Future<AppPreferences> loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return AppPreferences(
        vibrationEnabled: prefs.getBool(_vibrationKey) ?? true,
        soundEnabled: prefs.getBool(_soundKey) ?? true,
        bannerEnabled: prefs.getBool(_bannerKey) ?? true,
        criticalMode: prefs.getBool(_criticalModeKey) ?? false,
        systemEnabled: prefs.getBool(_systemEnabledKey) ?? false,
      );
    } catch (e) {
      return AppPreferences();
    }
  }

  /// Limpa todas as preferências
  Future<bool> clearPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      return false;
    }
  }

  /// Salva uma preferência individual
  Future<bool> setSinglePreference(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setBool(key, value);
    } catch (e) {
      return false;
    }
  }

  /// Obtém uma preferência individual
  Future<bool?> getSinglePreference(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(key);
    } catch (e) {
      return null;
    }
  }
}

