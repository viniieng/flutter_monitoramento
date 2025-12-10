/// Modelo para representar o status da API
class ApiStatus {
  final bool isConnected;
  final String message;
  final DateTime lastChecked;
  final int? statusCode;

  ApiStatus({
    required this.isConnected,
    required this.message,
    required this.lastChecked,
    this.statusCode,
  });

  factory ApiStatus.fromJson(Map<String, dynamic> json) {
    return ApiStatus(
      isConnected: true,
      message: json['status'] ?? 'OK',
      lastChecked: DateTime.now(),
      statusCode: 200,
    );
  }

  factory ApiStatus.error(String message) {
    return ApiStatus(
      isConnected: false,
      message: message,
      lastChecked: DateTime.now(),
    );
  }
}

