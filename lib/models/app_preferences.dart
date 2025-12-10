/// Modelo para representar as preferências do aplicativo
class AppPreferences {
  final bool vibrationEnabled;
  final bool soundEnabled;
  final bool bannerEnabled;
  final bool criticalMode;
  final bool systemEnabled;

  AppPreferences({
    this.vibrationEnabled = true,
    this.soundEnabled = true,
    this.bannerEnabled = true,
    this.criticalMode = false,
    this.systemEnabled = false,
  });

  /// Converte o objeto para Map para armazenamento
  Map<String, dynamic> toMap() {
    return {
      'vibrationEnabled': vibrationEnabled,
      'soundEnabled': soundEnabled,
      'bannerEnabled': bannerEnabled,
      'criticalMode': criticalMode,
      'systemEnabled': systemEnabled,
    };
  }

  /// Cria um objeto AppPreferences a partir de um Map
  factory AppPreferences.fromMap(Map<String, dynamic> map) {
    return AppPreferences(
      vibrationEnabled: map['vibrationEnabled'] as bool? ?? true,
      soundEnabled: map['soundEnabled'] as bool? ?? true,
      bannerEnabled: map['bannerEnabled'] as bool? ?? true,
      criticalMode: map['criticalMode'] as bool? ?? false,
      systemEnabled: map['systemEnabled'] as bool? ?? false,
    );
  }

  /// Cria uma cópia do objeto com campos modificados
  AppPreferences copyWith({
    bool? vibrationEnabled,
    bool? soundEnabled,
    bool? bannerEnabled,
    bool? criticalMode,
    bool? systemEnabled,
  }) {
    return AppPreferences(
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      bannerEnabled: bannerEnabled ?? this.bannerEnabled,
      criticalMode: criticalMode ?? this.criticalMode,
      systemEnabled: systemEnabled ?? this.systemEnabled,
    );
  }

  @override
  String toString() {
    return 'AppPreferences{vibration: $vibrationEnabled, sound: $soundEnabled, '
        'banner: $bannerEnabled, critical: $criticalMode, enabled: $systemEnabled}';
  }
}

