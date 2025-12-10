import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_status.dart';

/// Serviço para integração com API externa
class ApiService {
  // Usando uma API pública gratuita para testes
  static const String _baseUrl = 'https://api.publicapis.org';
  static const String _healthEndpoint = '/health';
  
  /// Verifica o status da API (health check)
  Future<ApiStatus> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl$_healthEndpoint'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ApiStatus.fromJson(data);
      } else {
        return ApiStatus.error(
          'Erro na API: código ${response.statusCode}',
        );
      }
    } catch (e) {
      return ApiStatus.error('Falha na conexão: ${e.toString()}');
    }
  }

  /// Envia um evento de alerta para a API
  Future<Map<String, dynamic>> sendAlertEvent(Map<String, dynamic> eventData) async {
    try {
      // Usando endpoint de teste para demonstração
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(eventData),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': json.decode(response.body),
          'message': 'Evento enviado com sucesso',
        };
      } else {
        return {
          'success': false,
          'message': 'Erro ao enviar evento: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro na conexão: ${e.toString()}',
      };
    }
  }

  /// Busca informações aleatórias de APIs públicas
  Future<Map<String, dynamic>> getRandomApiInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/random'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': json.decode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'Erro: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro: ${e.toString()}',
      };
    }
  }
}

