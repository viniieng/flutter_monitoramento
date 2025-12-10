import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/preferences_provider.dart';
import '../providers/alert_provider.dart';
import '../providers/api_provider.dart';
import '../widgets/status_card.dart';

/// Tela principal do Dashboard com monitoramento
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isPanicPressed = false;

  @override
  void initState() {
    super.initState();
    // Carrega dados iniciais
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AlertProvider>().loadEvents();
      context.read<ApiProvider>().checkApiHealth();
    });
  }

  Future<void> _triggerPanicAlert() async {
    setState(() => _isPanicPressed = true);

    final preferences = context.read<PreferencesProvider>().preferences;
    final alertProvider = context.read<AlertProvider>();

    await alertProvider.createAlertEvent(
      type: 'panic',
      preferences: preferences,
      description: 'Botão de pânico acionado manualmente',
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🚨 Alerta de pânico disparado!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _isPanicPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<AlertProvider>().loadEvents();
          await context.read<ApiProvider>().checkApiHealth();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildStatusCards(),
              _buildPanicButton(),
              _buildRecentAlerts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sistema de Monitoramento',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Consumer<PreferencesProvider>(
            builder: (context, prefsProvider, _) {
              return Text(
                prefsProvider.preferences.systemEnabled
                    ? 'Status: Ativo ✓'
                    : 'Status: Desativado',
                style: TextStyle(
                  color: prefsProvider.preferences.systemEnabled
                      ? Colors.greenAccent
                      : Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCards() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Consumer3<PreferencesProvider, AlertProvider, ApiProvider>(
        builder: (context, prefsProvider, alertProvider, apiProvider, _) {
          final activeEvents = alertProvider.events
              .where((e) => e.status == 'active')
              .length;

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatusCard(
                      title: 'Status do Sistema',
                      value: prefsProvider.preferences.systemEnabled
                          ? 'ATIVO'
                          : 'INATIVO',
                      icon: prefsProvider.preferences.systemEnabled
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: prefsProvider.preferences.systemEnabled
                          ? Colors.green
                          : Colors.grey,
                      onTap: () {
                        prefsProvider.toggleSystem(
                          !prefsProvider.preferences.systemEnabled,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatusCard(
                      title: 'Alertas Ativos',
                      value: activeEvents.toString(),
                      icon: Icons.warning_amber_rounded,
                      color: activeEvents > 0 ? Colors.red : Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: StatusCard(
                      title: 'Total de Eventos',
                      value: alertProvider.events.length.toString(),
                      icon: Icons.event_note,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Consumer<ApiProvider>(
                      builder: (context, apiProvider, _) {
                        return StatusCard(
                          title: 'Conexão API',
                          value: apiProvider.isChecking
                              ? '...'
                              : (apiProvider.isConnected ? 'OK' : 'ERRO'),
                          icon: apiProvider.isConnected
                              ? Icons.cloud_done
                              : Icons.cloud_off,
                          color: apiProvider.isConnected
                              ? Colors.teal
                              : Colors.grey,
                          onTap: () => apiProvider.checkApiHealth(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPanicButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emergência',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: _isPanicPressed
                    ? [Colors.red[700]!, Colors.red[900]!]
                    : [Colors.red[400]!, Colors.red[600]!],
                center: Alignment.center,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.5),
                  blurRadius: _isPanicPressed ? 30 : 15,
                  spreadRadius: _isPanicPressed ? 5 : 2,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _isPanicPressed ? null : _triggerPanicAlert,
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emergency,
                        size: 64,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _isPanicPressed
                            ? 'ALERTA DISPARADO!'
                            : 'BOTÃO DE PÂNICO',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isPanicPressed
                            ? 'Processando...'
                            : 'Toque para acionar',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAlerts() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Alertas Recentes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  DefaultTabController.of(context).animateTo(1);
                },
                child: const Text('Ver todos'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Consumer<AlertProvider>(
            builder: (context, alertProvider, _) {
              if (alertProvider.isLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (alertProvider.events.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhum alerta registrado',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              final recentEvents = alertProvider.events.take(3).toList();

              return Column(
                children: recentEvents.map((event) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.warning_amber_rounded,
                        color: event.status == 'active'
                            ? Colors.red
                            : Colors.green,
                      ),
                      title: Text(
                        event.type.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        event.timestamp.toString().substring(0, 19),
                      ),
                      trailing: Chip(
                        label: Text(
                          event.status,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: event.status == 'active'
                            ? Colors.red[100]
                            : Colors.green[100],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

