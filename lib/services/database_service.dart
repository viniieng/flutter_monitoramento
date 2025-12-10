import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/alert_event.dart';

/// Serviço para gerenciar o armazenamento local (compatível com web)
/// Substitui SQLite usando SharedPreferences/LocalStorage
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static const String _eventsKey = 'alert_events';

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  /// Obtém a instância do storage (compatível com web)
  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  /// Insere um novo evento de alerta
  Future<int> insertAlertEvent(AlertEvent event) async {
    final prefs = await _prefs;
    final events = await getAllAlertEvents();
    
    // Gera um ID único
    final newId = events.isEmpty 
        ? 1 
        : events.map((e) => e.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
    
    final eventWithId = event.copyWith(id: newId);
    events.insert(0, eventWithId);
    
    await _saveEvents(events);
    return newId;
  }

  /// Busca todos os eventos de alerta
  Future<List<AlertEvent>> getAllAlertEvents() async {
    final prefs = await _prefs;
    final String? eventsJson = prefs.getString(_eventsKey);
    
    if (eventsJson == null || eventsJson.isEmpty) {
      return [];
    }
    
    try {
      final List<dynamic> decoded = json.decode(eventsJson);
      return decoded.map((e) => AlertEvent.fromMap(e as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Erro ao decodificar eventos: $e');
      return [];
    }
  }

  /// Busca um evento de alerta por ID
  Future<AlertEvent?> getAlertEventById(int id) async {
    final events = await getAllAlertEvents();
    try {
      return events.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Atualiza um evento de alerta
  Future<int> updateAlertEvent(AlertEvent event) async {
    final events = await getAllAlertEvents();
    final index = events.indexWhere((e) => e.id == event.id);
    
    if (index != -1) {
      events[index] = event;
      await _saveEvents(events);
      return 1;
    }
    return 0;
  }

  /// Deleta um evento de alerta
  Future<int> deleteAlertEvent(int id) async {
    final events = await getAllAlertEvents();
    final initialLength = events.length;
    events.removeWhere((e) => e.id == id);
    
    if (events.length < initialLength) {
      await _saveEvents(events);
      return 1;
    }
    return 0;
  }

  /// Deleta todos os eventos de alerta
  Future<int> deleteAllAlertEvents() async {
    final prefs = await _prefs;
    await prefs.remove(_eventsKey);
    return 1;
  }

  /// Salva a lista de eventos
  Future<void> _saveEvents(List<AlertEvent> events) async {
    final prefs = await _prefs;
    final List<Map<String, dynamic>> eventMaps = 
        events.map((e) => e.toMap()).toList();
    await prefs.setString(_eventsKey, json.encode(eventMaps));
  }

  /// Fecha o banco de dados (não necessário para SharedPreferences)
  Future<void> close() async {
    // Não é necessário fechar SharedPreferences
  }
}
