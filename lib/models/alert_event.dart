/// Modelo para representar um evento de alerta no sistema
class AlertEvent {
  final int? id;
  final String type;
  final DateTime timestamp;
  final DateTime? completedAt;
  final String status;
  final String? description;

  AlertEvent({
    this.id,
    required this.type,
    required this.timestamp,
    this.completedAt,
    this.status = 'pending',
    this.description,
  });

  /// Converte o objeto para Map para armazenamento no banco
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'status': status,
      'description': description,
    };
  }

  /// Cria um objeto AlertEvent a partir de um Map do banco
  factory AlertEvent.fromMap(Map<String, dynamic> map) {
    return AlertEvent(
      id: map['id'] as int?,
      type: map['type'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'] as String)
          : null,
      status: map['status'] as String,
      description: map['description'] as String?,
    );
  }

  /// Cria uma cópia do objeto com campos modificados
  AlertEvent copyWith({
    int? id,
    String? type,
    DateTime? timestamp,
    DateTime? completedAt,
    String? status,
    String? description,
  }) {
    return AlertEvent(
      id: id ?? this.id,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'AlertEvent{id: $id, type: $type, timestamp: $timestamp, status: $status}';
  }
}

