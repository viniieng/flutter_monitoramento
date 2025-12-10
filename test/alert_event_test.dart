import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_monitoramento/models/alert_event.dart';

/// Testes unitários para o modelo AlertEvent
void main() {
  group('AlertEvent Model Tests', () {
    test('Deve criar um AlertEvent com valores padrão', () {
      // Arrange & Act
      final timestamp = DateTime.now();
      final event = AlertEvent(
        type: 'panic',
        timestamp: timestamp,
      );

      // Assert
      expect(event.type, 'panic');
      expect(event.timestamp, timestamp);
      expect(event.status, 'pending');
      expect(event.id, null);
      expect(event.completedAt, null);
      expect(event.description, null);
    });

    test('Deve criar um AlertEvent com todos os campos', () {
      // Arrange & Act
      final timestamp = DateTime.now();
      final completedAt = DateTime.now().add(const Duration(minutes: 5));
      final event = AlertEvent(
        id: 1,
        type: 'manual',
        timestamp: timestamp,
        completedAt: completedAt,
        status: 'completed',
        description: 'Teste de alerta',
      );

      // Assert
      expect(event.id, 1);
      expect(event.type, 'manual');
      expect(event.timestamp, timestamp);
      expect(event.completedAt, completedAt);
      expect(event.status, 'completed');
      expect(event.description, 'Teste de alerta');
    });

    test('Deve converter AlertEvent para Map corretamente', () {
      // Arrange
      final timestamp = DateTime(2024, 1, 1, 12, 0, 0);
      final completedAt = DateTime(2024, 1, 1, 12, 5, 0);
      final event = AlertEvent(
        id: 1,
        type: 'panic',
        timestamp: timestamp,
        completedAt: completedAt,
        status: 'completed',
        description: 'Teste',
      );

      // Act
      final map = event.toMap();

      // Assert
      expect(map['id'], 1);
      expect(map['type'], 'panic');
      expect(map['timestamp'], timestamp.toIso8601String());
      expect(map['completedAt'], completedAt.toIso8601String());
      expect(map['status'], 'completed');
      expect(map['description'], 'Teste');
    });

    test('Deve criar AlertEvent a partir de Map corretamente', () {
      // Arrange
      final map = {
        'id': 1,
        'type': 'panic',
        'timestamp': '2024-01-01T12:00:00.000',
        'completedAt': '2024-01-01T12:05:00.000',
        'status': 'completed',
        'description': 'Teste de conversão',
      };

      // Act
      final event = AlertEvent.fromMap(map);

      // Assert
      expect(event.id, 1);
      expect(event.type, 'panic');
      expect(event.timestamp, DateTime.parse(map['timestamp'] as String));
      expect(event.completedAt, DateTime.parse(map['completedAt'] as String));
      expect(event.status, 'completed');
      expect(event.description, 'Teste de conversão');
    });

    test('Deve criar AlertEvent a partir de Map sem completedAt', () {
      // Arrange
      final map = {
        'id': 1,
        'type': 'panic',
        'timestamp': '2024-01-01T12:00:00.000',
        'completedAt': null,
        'status': 'active',
        'description': null,
      };

      // Act
      final event = AlertEvent.fromMap(map);

      // Assert
      expect(event.id, 1);
      expect(event.type, 'panic');
      expect(event.completedAt, null);
      expect(event.status, 'active');
      expect(event.description, null);
    });

    test('Deve criar cópia de AlertEvent com copyWith', () {
      // Arrange
      final timestamp = DateTime.now();
      final originalEvent = AlertEvent(
        id: 1,
        type: 'panic',
        timestamp: timestamp,
        status: 'active',
      );

      // Act
      final completedAt = DateTime.now();
      final copiedEvent = originalEvent.copyWith(
        status: 'completed',
        completedAt: completedAt,
      );

      // Assert
      expect(copiedEvent.id, originalEvent.id);
      expect(copiedEvent.type, originalEvent.type);
      expect(copiedEvent.timestamp, originalEvent.timestamp);
      expect(copiedEvent.status, 'completed');
      expect(copiedEvent.completedAt, completedAt);
      expect(originalEvent.status, 'active'); // Original não modificado
    });

    test('Deve retornar toString corretamente', () {
      // Arrange
      final timestamp = DateTime(2024, 1, 1, 12, 0, 0);
      final event = AlertEvent(
        id: 1,
        type: 'panic',
        timestamp: timestamp,
        status: 'active',
      );

      // Act
      final result = event.toString();

      // Assert
      expect(result, contains('AlertEvent'));
      expect(result, contains('id: 1'));
      expect(result, contains('type: panic'));
      expect(result, contains('status: active'));
    });
  });
}

