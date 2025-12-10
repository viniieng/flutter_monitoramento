import 'package:flutter/material.dart';
import '../models/api_status.dart';
import '../services/api_service.dart';

/// Provider para gerenciar o status da API
class ApiProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  ApiStatus? _apiStatus;
  bool _isChecking = false;
  
  ApiStatus? get apiStatus => _apiStatus;
  bool get isChecking => _isChecking;
  bool get isConnected => _apiStatus?.isConnected ?? false;

  /// Verifica o status da API
  Future<void> checkApiHealth() async {
    _isChecking = true;
    notifyListeners();

    try {
      _apiStatus = await _apiService.checkHealth();
    } catch (e) {
      _apiStatus = ApiStatus.error('Erro ao verificar API: ${e.toString()}');
    }

    _isChecking = false;
    notifyListeners();
  }

  /// Busca informações aleatórias da API
  Future<Map<String, dynamic>> fetchRandomInfo() async {
    return await _apiService.getRandomApiInfo();
  }

  /// Reseta o status
  void resetStatus() {
    _apiStatus = null;
    notifyListeners();
  }
}

