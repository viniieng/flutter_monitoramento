import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/preferences_provider.dart';

/// Tela de preferências e configurações
class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PreferencesProvider>().loadPreferences();
    });
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resetar Preferências'),
        content: const Text(
          'Deseja restaurar todas as configurações para os valores padrão?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<PreferencesProvider>().resetPreferences();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Preferências restauradas com sucesso'),
                ),
              );
            },
            child: const Text('Resetar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferências'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Resetar Preferências',
            onPressed: _showResetDialog,
          ),
        ],
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, prefsProvider, _) {
          final prefs = prefsProvider.preferences;

          return ListView(
            children: [
              // Seção: Sistema
              _buildSectionHeader(
                'Sistema',
                Icons.settings,
                Colors.blue,
              ),
              _buildSwitchTile(
                title: 'Sistema Ativado',
                subtitle: prefs.systemEnabled
                    ? 'O sistema está monitorando ativamente'
                    : 'O sistema está desativado',
                value: prefs.systemEnabled,
                icon: Icons.power_settings_new,
                onChanged: (value) {
                  prefsProvider.toggleSystem(value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        value
                            ? 'Sistema ativado com sucesso'
                            : 'Sistema desativado',
                      ),
                      backgroundColor: value ? Colors.green : Colors.orange,
                    ),
                  );
                },
              ),
              const Divider(height: 1),

              // Seção: Tipos de Notificação
              _buildSectionHeader(
                'Tipos de Notificação',
                Icons.notifications,
                Colors.orange,
              ),
              _buildSwitchTile(
                title: 'Vibração',
                subtitle: 'Vibrar o dispositivo ao receber alertas',
                value: prefs.vibrationEnabled,
                icon: Icons.vibration,
                onChanged: (value) => prefsProvider.toggleVibration(value),
              ),
              const Divider(height: 1, indent: 72),
              _buildSwitchTile(
                title: 'Som',
                subtitle: 'Reproduzir som ao receber alertas',
                value: prefs.soundEnabled,
                icon: Icons.volume_up,
                onChanged: (value) => prefsProvider.toggleSound(value),
              ),
              const Divider(height: 1, indent: 72),
              _buildSwitchTile(
                title: 'Banner',
                subtitle: 'Exibir banner de notificação',
                value: prefs.bannerEnabled,
                icon: Icons.notifications_active,
                onChanged: (value) => prefsProvider.toggleBanner(value),
              ),
              const Divider(height: 1),

              // Seção: Modo Crítico
              _buildSectionHeader(
                'Modo Crítico',
                Icons.warning_amber,
                Colors.red,
              ),
              Container(
                color: prefs.criticalMode
                    ? Colors.red[50]
                    : Colors.transparent,
                child: _buildSwitchTile(
                  title: 'Modo Crítico',
                  subtitle: prefs.criticalMode
                      ? 'ATIVO: Alertas ignoram modo silencioso e volume baixo'
                      : 'INATIVO: Alertas respeitam configurações do dispositivo',
                  value: prefs.criticalMode,
                  icon: Icons.emergency,
                  iconColor: prefs.criticalMode ? Colors.red : null,
                  onChanged: (value) {
                    prefsProvider.toggleCriticalMode(value);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: Icon(
                          value ? Icons.warning_amber : Icons.info_outline,
                          size: 48,
                          color: value ? Colors.red : Colors.blue,
                        ),
                        title: Text(
                          value
                              ? 'Modo Crítico Ativado'
                              : 'Modo Crítico Desativado',
                        ),
                        content: Text(
                          value
                              ? 'Os alertas agora serão reproduzidos mesmo '
                                  'se o dispositivo estiver em modo silencioso '
                                  'ou com volume baixo. Use com responsabilidade.'
                              : 'Os alertas voltarão a respeitar as '
                                  'configurações normais do dispositivo.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Entendi'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (prefs.criticalMode)
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red[300]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.red[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Com o Modo Crítico ativo, os alertas usarão '
                          'canais de alta prioridade e tentarão reproduzir '
                          'sons mesmo em modo silencioso.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.red[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const Divider(height: 1),

              // Seção: Informações
              _buildSectionHeader(
                'Informações',
                Icons.info_outline,
                Colors.teal,
              ),
              _buildInfoTile(
                title: 'Sobre o Aplicativo',
                subtitle: 'Sistema de Monitoramento e Alertas v1.0.0',
                icon: Icons.app_settings_alt,
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Monitoramento e Alertas',
                    applicationVersion: '1.0.0',
                    applicationIcon: const Icon(
                      Icons.security,
                      size: 48,
                      color: Colors.blue,
                    ),
                    children: [
                      const Text(
                        'Aplicativo de monitoramento e alertas pessoais '
                        'com notificações locais, persistência de dados '
                        'e integração com API.\n\n'
                        'Desenvolvido com Flutter e Provider.',
                      ),
                    ],
                  );
                },
              ),
              const Divider(height: 1, indent: 72),
              _buildInfoTile(
                title: 'Como Funciona',
                subtitle: 'Entenda o funcionamento do sistema',
                icon: Icons.help_outline,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Como Funciona'),
                      content: const SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Dashboard',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '• Visualize o status do sistema\n'
                              '• Acione o botão de pânico\n'
                              '• Monitore conexão com API\n',
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Histórico',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '• Visualize todos os alertas\n'
                              '• Filtre por status\n'
                              '• Marque como concluído\n',
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Preferências',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '• Configure tipos de notificação\n'
                              '• Ative o modo crítico\n'
                              '• Personalize o sistema\n',
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Fechar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    Color? iconColor,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      secondary: Icon(icon, color: iconColor),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

