import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alert_provider.dart';
import '../widgets/alert_event_item.dart';

/// Tela de histórico de alertas
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _filterStatus = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AlertProvider>().loadEvents();
    });
  }

  void _showDeleteAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text(
          'Deseja realmente excluir TODOS os eventos do histórico? '
          'Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AlertProvider>().deleteAllEvents();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Todos os eventos foram excluídos'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Excluir Todos'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int eventId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: const Text('Deseja realmente excluir este evento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AlertProvider>().deleteEvent(eventId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Evento excluído'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Alertas'),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                _filterStatus = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('Todos'),
              ),
              const PopupMenuItem(
                value: 'active',
                child: Text('Ativos'),
              ),
              const PopupMenuItem(
                value: 'completed',
                child: Text('Concluídos'),
              ),
              const PopupMenuItem(
                value: 'pending',
                child: Text('Pendentes'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Excluir Todos',
            onPressed: _showDeleteAllDialog,
          ),
        ],
      ),
      body: Consumer<AlertProvider>(
        builder: (context, alertProvider, _) {
          if (alertProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (alertProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar eventos',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    alertProvider.error!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => alertProvider.loadEvents(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          var events = alertProvider.events;

          // Aplica filtro
          if (_filterStatus != 'all') {
            events = events.where((e) => e.status == _filterStatus).toList();
          }

          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _filterStatus == 'all'
                        ? 'Nenhum evento registrado'
                        : 'Nenhum evento $_filterStatus',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Acione o botão de pânico para\ncriar novos alertas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => alertProvider.loadEvents(),
            child: Column(
              children: [
                // Filtro visual
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      Icon(Icons.filter_list, size: 20, color: Colors.grey[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Filtro: ${_filterStatus == 'all' ? 'Todos' : _filterStatus}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${events.length} evento(s)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // Lista de eventos
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return AlertEventItem(
                        event: event,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(event.type.toUpperCase()),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ID: ${event.id}'),
                                  const SizedBox(height: 8),
                                  Text('Status: ${event.status}'),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Disparado em: ${event.timestamp}',
                                  ),
                                  if (event.completedAt != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      'Concluído em: ${event.completedAt}',
                                    ),
                                  ],
                                  if (event.description != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      'Descrição: ${event.description}',
                                    ),
                                  ],
                                ],
                              ),
                              actions: [
                                if (event.status == 'active')
                                  TextButton.icon(
                                    onPressed: () {
                                      alertProvider.completeEvent(event.id!);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.check_circle),
                                    label: const Text('Marcar como Concluído'),
                                  ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Fechar'),
                                ),
                              ],
                            ),
                          );
                        },
                        onDelete: () => _showDeleteDialog(event.id!),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

