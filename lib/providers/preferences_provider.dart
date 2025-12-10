import 'package:flutter/material.dart';
import '../models/app_preferences.dart';
import '../services/preferences_service.dart';

/// Provider para gerenciar as preferências do aplicativo
class PreferencesProvider with ChangeNotifier {
  final PreferencesService _preferencesService = PreferencesService();
  AppPreferences _preferences = AppPreferences();

  AppPreferences get preferences => _preferences;

  /// Carrega as preferências salvas
  Future<void> loadPreferences() async {
    _preferences = await _preferencesService.loadPreferences();
    notifyListeners();
  }

  /// Atualiza as preferências
  Future<void> updatePreferences(AppPreferences newPreferences) async {
    _preferences = newPreferences;
    await _preferencesService.savePreferences(_preferences);
    notifyListeners();
  }

  /// Alterna o estado da vibração
  Future<void> toggleVibration(bool value) async {
    _preferences = _preferences.copyWith(vibrationEnabled: value);
    await _preferencesService.savePreferences(_preferences);
    notifyListeners();
  }

  /// Alterna o estado do som
  Future<void> toggleSound(bool value) async {
    _preferences = _preferences.copyWith(soundEnabled: value);
    await _preferencesService.savePreferences(_preferences);
    notifyListeners();
  }

  /// Alterna o estado do banner
  Future<void> toggleBanner(bool value) async {
    _preferences = _preferences.copyWith(bannerEnabled: value);
    await _preferencesService.savePreferences(_preferences);
    notifyListeners();
  }

  /// Alterna o modo crítico
  Future<void> toggleCriticalMode(bool value) async {
    _preferences = _preferences.copyWith(criticalMode: value);
    await _preferencesService.savePreferences(_preferences);
    notifyListeners();
  }

  /// Alterna o estado do sistema
  Future<void> toggleSystem(bool value) async {
    _preferences = _preferences.copyWith(systemEnabled: value);
    await _preferencesService.savePreferences(_preferences);
    notifyListeners();
  }

  /// Reseta as preferências para os valores padrão
  Future<void> resetPreferences() async {
    _preferences = AppPreferences();
    await _preferencesService.savePreferences(_preferences);
    notifyListeners();
  }
}

