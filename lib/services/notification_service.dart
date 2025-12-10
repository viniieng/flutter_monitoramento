import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/app_preferences.dart';

/// Serviço de notificações adaptado para web
/// No web, usa notificações do navegador
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  /// Inicializa o serviço de notificações
  Future<void> initialize() async {
    if (kIsWeb) {
      // No web, notificações são gerenciadas pelo navegador
      print('🌐 Modo Web: Notificações via navegador');
    } else {
      print('📱 Modo Mobile: Notificações nativas');
    }
  }

  /// Solicita permissões de notificação
  Future<bool> requestPermissions() async {
    if (kIsWeb) {
      // No web, permissão é solicitada automaticamente ao tentar mostrar notificação
      return true;
    }
    return true;
  }

  /// Envia uma notificação de alerta (adaptado para web)
  Future<void> showAlertNotification({
    required String title,
    required String body,
    required AppPreferences preferences,
    String? payload,
  }) async {
    if (kIsWeb) {
      // Simula notificação no console para web
      _showWebNotification(title, body);
    } else {
      // Aqui seria a implementação mobile original
      print('📱 Notificação Mobile: $title - $body');
    }
  }

  /// Mostra notificação web (simulada no console + alert visual)
  void _showWebNotification(String title, String body) {
    print('🔔 NOTIFICAÇÃO WEB:');
    print('   Título: $title');
    print('   Mensagem: $body');
    print('   Horário: ${DateTime.now()}');
    
    // No navegador, você poderia usar a Web Notifications API:
    // Notification.requestPermission().then((permission) {
    //   if (permission == 'granted') {
    //     new Notification(title, { body: body });
    //   }
    // });
  }

  /// Agenda uma notificação futura
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required AppPreferences preferences,
  }) async {
    if (kIsWeb) {
      print('📅 Notificação agendada para web: $scheduledDate');
    }
  }

  /// Cancela todas as notificações
  Future<void> cancelAllNotifications() async {
    if (kIsWeb) {
      print('🔕 Notificações web canceladas');
    }
  }

  /// Cancela uma notificação específica
  Future<void> cancelNotification(int id) async {
    if (kIsWeb) {
      print('🔕 Notificação #$id cancelada');
    }
  }
}
