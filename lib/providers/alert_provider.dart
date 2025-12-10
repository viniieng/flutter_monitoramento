import 'package:flutter/material.dart';
import '../models/alert_event.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';
import '../services/api_service.dart';
import '../models/app_preferences.dart';

/// Provider para gerenciar eventos de alerta
class AlertProvider with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final NotificationService _notificationService = NotificationService();
  final ApiService _apiService = ApiService();

  List<AlertEvent> _events = [];
  bool _isLoading = false;
  String? _error;

  List<AlertEvent> get events => _events;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carrega todos os eventos do banco de dados
  Future<void> loadEvents() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _events = await _databaseService.getAllAlertEvents();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Erro ao carregar eventos: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Cria um novo evento de alerta
  Future<void> createAlertEvent({
    required String type,
    required AppPreferences preferences,
    String? description,
  }) async {
    try {
      // Cria o evento
      final event = AlertEvent(
        type: type,
        timestamp: DateTime.now(),
        status: 'active',
        description: description,
      );

      // Salva no banco de dados
      final id = await _databaseService.insertAlertEvent(event);
      
      // Envia notificação
      await _notificationService.showAlertNotification(
        title: '🚨 Alerta de Segurança',
        body: description ?? 'Botão de pânico acionado!',
        preferences: preferences,
        payload: id.toString(),
      );

      // Envia para API (opcional)
      try {
        await _apiService.sendAlertEvent({
          'type': type,
          'timestamp': event.timestamp.toIso8601String(),
          'description': description,
        });
      } catch (e) {
        print('Erro ao enviar para API: $e');
      }

      // Recarrega eventos
      await loadEvents();
    } catch (e) {
      _error = 'Erro ao criar alerta: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Marca um evento como completo
  Future<void> completeEvent(int eventId) async {
    try {
      final event = await _databaseService.getAlertEventById(eventId);
      if (event != null) {
        final updatedEvent = event.copyWith(
          status: 'completed',
          completedAt: DateTime.now(),
        );
        await _databaseService.updateAlertEvent(updatedEvent);
        await loadEvents();
      }
    } catch (e) {
      _error = 'Erro ao completar evento: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Deleta um evento
  Future<void> deleteEvent(int eventId) async {
    try {
      await _databaseService.deleteAlertEvent(eventId);
      await loadEvents();
    } catch (e) {
      _error = 'Erro ao deletar evento: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Deleta todos os eventos
  Future<void> deleteAllEvents() async {
    try {
      await _databaseService.deleteAllAlertEvents();
      await loadEvents();
    } catch (e) {
      _error = 'Erro ao deletar eventos: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Limpa o erro
  void clearError() {
    _error = null;
    notifyListeners();
  }
}

