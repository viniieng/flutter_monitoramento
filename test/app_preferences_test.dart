import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_monitoramento/models/app_preferences.dart';

/// Testes unitários para o modelo AppPreferences
void main() {
  group('AppPreferences Model Tests', () {
    test('Deve criar AppPreferences com valores padrão', () {
      // Arrange & Act
      final prefs = AppPreferences();

      // Assert
      expect(prefs.vibrationEnabled, true);
      expect(prefs.soundEnabled, true);
      expect(prefs.bannerEnabled, true);
      expect(prefs.criticalMode, false);
      expect(prefs.systemEnabled, false);
    });

    test('Deve criar AppPreferences com valores customizados', () {
      // Arrange & Act
      final prefs = AppPreferences(
        vibrationEnabled: false,
        soundEnabled: false,
        bannerEnabled: false,
        criticalMode: true,
        systemEnabled: true,
      );

      // Assert
      expect(prefs.vibrationEnabled, false);
      expect(prefs.soundEnabled, false);
      expect(prefs.bannerEnabled, false);
      expect(prefs.criticalMode, true);
      expect(prefs.systemEnabled, true);
    });

    test('Deve converter AppPreferences para Map corretamente', () {
      // Arrange
      final prefs = AppPreferences(
        vibrationEnabled: true,
        soundEnabled: false,
        bannerEnabled: true,
        criticalMode: true,
        systemEnabled: false,
      );

      // Act
      final map = prefs.toMap();

      // Assert
      expect(map['vibrationEnabled'], true);
      expect(map['soundEnabled'], false);
      expect(map['bannerEnabled'], true);
      expect(map['criticalMode'], true);
      expect(map['systemEnabled'], false);
    });

    test('Deve criar AppPreferences a partir de Map corretamente', () {
      // Arrange
      final map = {
        'vibrationEnabled': false,
        'soundEnabled': true,
        'bannerEnabled': false,
        'criticalMode': true,
        'systemEnabled': true,
      };

      // Act
      final prefs = AppPreferences.fromMap(map);

      // Assert
      expect(prefs.vibrationEnabled, false);
      expect(prefs.soundEnabled, true);
      expect(prefs.bannerEnabled, false);
      expect(prefs.criticalMode, true);
      expect(prefs.systemEnabled, true);
    });

    test('Deve usar valores padrão quando Map tem valores null', () {
      // Arrange
      final map = {
        'vibrationEnabled': null,
        'soundEnabled': null,
        'bannerEnabled': null,
        'criticalMode': null,
        'systemEnabled': null,
      };

      // Act
      final prefs = AppPreferences.fromMap(map);

      // Assert
      expect(prefs.vibrationEnabled, true);
      expect(prefs.soundEnabled, true);
      expect(prefs.bannerEnabled, true);
      expect(prefs.criticalMode, false);
      expect(prefs.systemEnabled, false);
    });

    test('Deve criar cópia de AppPreferences com copyWith', () {
      // Arrange
      final originalPrefs = AppPreferences(
        vibrationEnabled: true,
        soundEnabled: true,
        bannerEnabled: true,
        criticalMode: false,
        systemEnabled: false,
      );

      // Act
      final copiedPrefs = originalPrefs.copyWith(
        criticalMode: true,
        systemEnabled: true,
      );

      // Assert
      expect(copiedPrefs.vibrationEnabled, true);
      expect(copiedPrefs.soundEnabled, true);
      expect(copiedPrefs.bannerEnabled, true);
      expect(copiedPrefs.criticalMode, true);
      expect(copiedPrefs.systemEnabled, true);
      
      // Original não modificado
      expect(originalPrefs.criticalMode, false);
      expect(originalPrefs.systemEnabled, false);
    });

    test('Deve retornar toString corretamente', () {
      // Arrange
      final prefs = AppPreferences(
        vibrationEnabled: true,
        soundEnabled: false,
        bannerEnabled: true,
        criticalMode: true,
        systemEnabled: false,
      );

      // Act
      final result = prefs.toString();

      // Assert
      expect(result, contains('AppPreferences'));
      expect(result, contains('vibration: true'));
      expect(result, contains('sound: false'));
      expect(result, contains('banner: true'));
      expect(result, contains('critical: true'));
      expect(result, contains('enabled: false'));
    });

    test('Deve preservar valores ao fazer conversão Map -> Model -> Map', () {
      // Arrange
      final originalMap = {
        'vibrationEnabled': false,
        'soundEnabled': true,
        'bannerEnabled': false,
        'criticalMode': true,
        'systemEnabled': true,
      };

      // Act
      final prefs = AppPreferences.fromMap(originalMap);
      final resultMap = prefs.toMap();

      // Assert
      expect(resultMap['vibrationEnabled'], originalMap['vibrationEnabled']);
      expect(resultMap['soundEnabled'], originalMap['soundEnabled']);
      expect(resultMap['bannerEnabled'], originalMap['bannerEnabled']);
      expect(resultMap['criticalMode'], originalMap['criticalMode']);
      expect(resultMap['systemEnabled'], originalMap['systemEnabled']);
    });
  });
}

