# Sistema de Monitoramento e Alertas

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

Aplicativo mobile nativo desenvolvido em Flutter que simula um sistema de monitoramento e alertas pessoais com notificações locais, persistência de dados e integração com API.

## 📋 Índice

- [Características](#-características)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Arquitetura](#-arquitetura)
- [Instalação](#-instalação)
- [Como Usar](#-como-usar)
- [Funcionalidades](#-funcionalidades)
- [Testes](#-testes)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Requisitos Atendidos](#-requisitos-atendidos)

## ✨ Características

- **Dashboard de Monitoramento**: Visualize o status do sistema em tempo real
- **Botão de Pânico**: Dispare alertas de emergência instantaneamente
- **Notificações Locais**: Receba alertas mesmo com o app em segundo plano
- **Modo Crítico**: Alertas que ignoram modo silencioso do dispositivo
- **Persistência Local**: Armazenamento de eventos e preferências offline
- **Integração com API**: Comunicação HTTP com APIs externas
- **Histórico Completo**: Visualize todos os eventos com filtros
- **Interface Moderna**: Design responsivo com Material Design 3

## 🚀 Tecnologias Utilizadas

- **Flutter 3.0+**: Framework para desenvolvimento mobile
- **Dart 3.0+**: Linguagem de programação
- **Provider**: Gerenciamento de estado
- **SQLite**: Banco de dados local
- **SharedPreferences**: Armazenamento de preferências
- **flutter_local_notifications**: Sistema de notificações locais
- **http**: Cliente HTTP para integração com API

## 🏗 Arquitetura

O projeto segue uma arquitetura em camadas com separação de responsabilidades:

```
lib/
├── models/          # Modelos de dados
├── services/        # Serviços (API, Database, Notifications)
├── providers/       # Gerenciamento de estado (Provider)
├── screens/         # Telas da aplicação
├── widgets/         # Widgets reutilizáveis
└── main.dart        # Ponto de entrada
```

### Padrões Utilizados

- **Provider Pattern**: Para gerenciamento de estado reativo
- **Repository Pattern**: Para abstração de acesso a dados
- **Service Layer**: Para lógica de negócio
- **Dependency Injection**: Através do Provider

## 📦 Instalação

### Pré-requisitos

- Flutter SDK 3.0 ou superior
- Dart SDK 3.0 ou superior
- Android Studio / VS Code
- Dispositivo físico ou emulador Android/iOS

### Passos

1. **Clone o repositório**
```bash
git clone <seu-repositorio>
cd flutter_monitoramento
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Configure o Android (se necessário)**
```bash
cd android
./gradlew clean
cd ..
```

4. **Execute o aplicativo**
```bash
flutter run
```

5. **Execute os testes**
```bash
flutter test
```

## 📱 Como Usar

### 1. Dashboard

- **Visualize o Status**: Veja se o sistema está ativo ou inativo
- **Botão de Pânico**: Pressione o botão vermelho para disparar um alerta
- **Status da API**: Verifique a conectividade com a API
- **Alertas Ativos**: Monitore quantos alertas estão em andamento

### 2. Histórico

- **Lista de Eventos**: Visualize todos os alertas disparados
- **Filtros**: Filtre por status (Todos, Ativos, Concluídos, Pendentes)
- **Detalhes**: Toque em um evento para ver detalhes completos
- **Ações**: Marque eventos como concluídos ou delete-os

### 3. Preferências

- **Sistema Ativado**: Ative/desative o sistema de monitoramento
- **Tipos de Notificação**:
  - Vibração
  - Som
  - Banner
- **Modo Crítico**: Ative para alertas que ignoram modo silencioso
- **Resetar**: Restaure todas as configurações para o padrão

## 🎯 Funcionalidades

### ✅ Requisitos Obrigatórios Implementados

#### 1. Tela de Monitoramento (Dashboard)
- ✅ Visualização do estado do sistema (Ativado/Desativado)
- ✅ Botão de Pânico para disparar alertas
- ✅ Feedback visual claro e imediato
- ✅ Estado de conectividade da API
- ✅ Contador de alertas ativos e totais

#### 2. Tela de Preferências
- ✅ Configuração de tipos de notificação (Vibração, Som, Banner)
- ✅ Modo Crítico (ignora modo silencioso)
- ✅ Persistência local de configurações (SharedPreferences)
- ✅ Reset de preferências para valores padrão

#### 3. Tela de Histórico
- ✅ Listagem de todos os eventos com data e hora
- ✅ Tipo do evento e status
- ✅ Data de conclusão/processamento
- ✅ Armazenamento local com SQLite
- ✅ Funciona offline
- ✅ Filtros por status

#### 4. Notificações e Segundo Plano
- ✅ Notificações locais nativas
- ✅ Funciona com app em segundo plano
- ✅ Abre o aplicativo ao clicar na notificação
- ✅ Canais de notificação personalizados
- ✅ Modo crítico com alta prioridade

#### 5. Integração com API
- ✅ Chamadas HTTP (GET e POST)
- ✅ Health check da API
- ✅ Envio de eventos para API externa
- ✅ Exibição do status da API no dashboard
- ✅ Tratamento de erros e timeout

#### 6. Testes Unitários
- ✅ Teste do modelo AlertEvent (conversão, cópia, etc.)
- ✅ Teste do modelo AppPreferences (persistência, conversão)
- ✅ Teste de lógica de salvamento
- ✅ Teste de conversão de modelos
- ✅ Mais de 15 casos de teste implementados

#### 7. Qualidade do Código
- ✅ Código indentado e organizado
- ✅ Estrutura clara de diretórios
- ✅ Comentários quando necessário
- ✅ Arquitetura em camadas
- ✅ Gerenciamento de estado com Provider
- ✅ Boas práticas do Dart

#### 8. Interface
- ✅ Design responsivo
- ✅ Material Design 3
- ✅ Feedback visual adequado
- ✅ Estados de loading, erro e sucesso
- ✅ Animações e transições suaves

## 🧪 Testes

O projeto inclui testes unitários abrangentes para os modelos de dados:

### Executar Testes

```bash
# Executar todos os testes
flutter test

# Executar testes com cobertura
flutter test --coverage

# Executar um teste específico
flutter test test/alert_event_test.dart
```

### Testes Implementados

#### `test/alert_event_test.dart`
- Criação de AlertEvent com valores padrão
- Criação com todos os campos
- Conversão para/de Map
- Método copyWith
- Método toString
- Validação de campos null

#### `test/app_preferences_test.dart`
- Criação de AppPreferences com valores padrão
- Criação com valores customizados
- Conversão para/de Map
- Valores padrão quando Map tem null
- Método copyWith
- Preservação de valores em conversões

## 📂 Estrutura do Projeto

```
flutter_monitoramento/
├── android/                      # Configurações Android
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── kotlin/          # MainActivity
│   │   │   ├── res/             # Recursos
│   │   │   └── AndroidManifest.xml
│   │   └── build.gradle
│   ├── build.gradle
│   └── settings.gradle
├── assets/
│   └── sounds/                  # Sons para notificações
├── lib/
│   ├── models/
│   │   ├── alert_event.dart     # Modelo de evento
│   │   ├── app_preferences.dart # Modelo de preferências
│   │   └── api_status.dart      # Modelo de status da API
│   ├── services/
│   │   ├── database_service.dart      # SQLite
│   │   ├── preferences_service.dart   # SharedPreferences
│   │   ├── notification_service.dart  # Notificações
│   │   └── api_service.dart           # Integração HTTP
│   ├── providers/
│   │   ├── preferences_provider.dart  # Estado das preferências
│   │   ├── alert_provider.dart        # Estado dos alertas
│   │   └── api_provider.dart          # Estado da API
│   ├── screens/
│   │   ├── dashboard_screen.dart      # Tela principal
│   │   ├── history_screen.dart        # Tela de histórico
│   │   └── preferences_screen.dart    # Tela de preferências
│   ├── widgets/
│   │   ├── status_card.dart           # Card de status
│   │   └── alert_event_item.dart      # Item de evento
│   └── main.dart                      # Ponto de entrada
├── test/
│   ├── alert_event_test.dart          # Testes do modelo
│   └── app_preferences_test.dart      # Testes de preferências
├── pubspec.yaml                       # Dependências
└── README.md                          # Documentação
```

## ✅ Requisitos Atendidos

### Requisitos Obrigatórios
- [x] Tela de Monitoramento (Dashboard)
- [x] Tela de Preferências
- [x] Tela de Histórico
- [x] Notificações Locais
- [x] Execução em Segundo Plano
- [x] Integração com API (GET e POST)
- [x] Testes Unitários (2+)
- [x] Qualidade do Código
- [x] Interface Responsiva
- [x] Persistência Local (SQLite + SharedPreferences)

### Diferenciais Implementados
- [x] Modo Crítico para alertas
- [x] Múltiplos tipos de notificação
- [x] Sistema de filtros no histórico
- [x] Health check da API
- [x] Design moderno com Material Design 3
- [x] Feedback visual rico
- [x] Arquitetura escalável
- [x] Mais de 15 testes unitários

## 🔧 Configuração de Permissões

### Android

As seguintes permissões são configuradas automaticamente no `AndroidManifest.xml`:

- `INTERNET`: Para comunicação com APIs
- `POST_NOTIFICATIONS`: Para exibir notificações (Android 13+)
- `VIBRATE`: Para vibração do dispositivo
- `USE_FULL_SCREEN_INTENT`: Para alertas críticos em tela cheia
- `SCHEDULE_EXACT_ALARM`: Para agendar notificações
- `RECEIVE_BOOT_COMPLETED`: Para manter notificações após reinicialização
- `WAKE_LOCK`: Para manter dispositivo acordado durante alertas

### iOS

Configure as permissões no `Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```

## 📖 Documentação das APIs

### API de Health Check
- **Endpoint**: `https://api.publicapis.org/health`
- **Método**: GET
- **Descrição**: Verifica se a API está respondendo

### API de Teste (JSONPlaceholder)
- **Endpoint**: `https://jsonplaceholder.typicode.com/posts`
- **Método**: POST
- **Descrição**: Envia eventos de teste

## 🎨 Capturas de Tela

### Dashboard
- Visualização do status do sistema
- Botão de pânico destacado
- Cards informativos com gradientes
- Alertas recentes

### Histórico
- Lista completa de eventos
- Filtros por status
- Detalhes de cada evento
- Ações de conclusão e exclusão

### Preferências
- Configurações organizadas por categoria
- Switches visuais
- Alertas informativos sobre modo crítico
- Opção de reset

## 🔐 Segurança

- Todas as comunicações HTTP usam HTTPS
- Dados sensíveis são armazenados localmente
- Permissões mínimas necessárias
- Validação de entrada de dados

## 🐛 Resolução de Problemas

### Notificações não aparecem no Android 13+
- Certifique-se de conceder permissão de notificação nas configurações do app

### Modo crítico não funciona
- Verifique se o canal de notificação crítico foi criado
- Algumas fabricantes bloqueiam notificações críticas por padrão

### Erro ao conectar com API
- Verifique sua conexão com a internet
- Teste a URL da API em um navegador

## 📝 Notas de Desenvolvimento

### Provider vs Bloc vs Riverpod
Escolhemos Provider pela simplicidade e ampla adoção na comunidade Flutter.

### SQLite vs Hive
SQLite foi escolhido por ser mais robusto para queries complexas e ser nativo.

### Estrutura de Canais de Notificação
Dois canais foram criados:
1. **normal_channel**: Para notificações normais
2. **critical_channel**: Para alertas que ignoram modo silencioso

## 🚦 Roadmap Futuro

- [ ] WebSocket para alertas em tempo real
- [ ] Autenticação de usuário
- [ ] Backup na nuvem
- [ ] Widget para tela inicial
- [ ] Suporte para iOS completo
- [ ] Dark mode
- [ ] Internacionalização (i18n)
- [ ] Testes de integração

## 👥 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto é desenvolvido para fins educacionais.

## 📧 Contato

Para dúvidas ou sugestões, entre em contato.
