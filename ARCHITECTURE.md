# Documentação Técnica - Arquitetura e Design

## 📐 Arquitetura Geral

### Padrão Arquitetural

O projeto utiliza uma arquitetura em camadas inspirada em **Clean Architecture** e **MVVM (Model-View-ViewModel)**, adaptada para Flutter usando o padrão Provider.

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│   (Screens, Widgets, UI Components)     │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│        Provider Layer (State)           │
│  (PreferencesProvider, AlertProvider)   │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Service Layer                   │
│  (DatabaseService, NotificationService) │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         Data Layer                      │
│   (Models, SQLite, SharedPreferences)   │
└─────────────────────────────────────────┘
```

---

## 🗂 Estrutura de Camadas

### 1. Presentation Layer (UI)

**Responsabilidade**: Interface do usuário e interação

**Componentes**:
- `screens/`: Telas completas da aplicação
- `widgets/`: Componentes reutilizáveis

**Características**:
- Não contém lógica de negócio
- Consome dados dos Providers
- Reage a mudanças de estado
- Dispara ações via Providers

**Exemplo**:
```dart
Consumer<AlertProvider>(
  builder: (context, alertProvider, _) {
    if (alertProvider.isLoading) {
      return CircularProgressIndicator();
    }
    return ListView(children: alertProvider.events);
  },
)
```

### 2. Provider Layer (State Management)

**Responsabilidade**: Gerenciamento de estado reativo

**Providers Implementados**:

#### PreferencesProvider
- Gerencia estado das preferências do app
- Persiste alterações automaticamente
- Notifica listeners sobre mudanças

#### AlertProvider
- Gerencia lista de eventos de alerta
- Coordena criação e exclusão de eventos
- Integra notificações e API

#### ApiProvider
- Gerencia estado da conexão com API
- Realiza health checks
- Provê dados de APIs externas

**Padrão ChangeNotifier**:
```dart
class AlertProvider with ChangeNotifier {
  List<AlertEvent> _events = [];
  
  Future<void> loadEvents() async {
    _events = await _databaseService.getAllAlertEvents();
    notifyListeners(); // Atualiza UI
  }
}
```

### 3. Service Layer

**Responsabilidade**: Lógica de negócio e operações

**Services Implementados**:

#### DatabaseService (Singleton)
- Gerencia conexão SQLite
- CRUD de eventos de alerta
- Queries otimizadas

**Padrão Singleton**:
```dart
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();
}
```

#### NotificationService (Singleton)
- Inicializa sistema de notificações
- Cria canais personalizados
- Dispara notificações locais

**Canais**:
- `normal_channel`: Notificações padrão
- `critical_channel`: Notificações críticas

#### PreferencesService
- Abstrai SharedPreferences
- Serialização/deserialização
- Operações assíncronas

#### ApiService
- Cliente HTTP
- Integração com APIs externas
- Tratamento de erros e timeouts

### 4. Data Layer

**Responsabilidade**: Modelos e persistência

**Models**:

#### AlertEvent
```dart
class AlertEvent {
  final int? id;
  final String type;
  final DateTime timestamp;
  final DateTime? completedAt;
  final String status;
  final String? description;
  
  // Métodos: toMap(), fromMap(), copyWith()
}
```

#### AppPreferences
```dart
class AppPreferences {
  final bool vibrationEnabled;
  final bool soundEnabled;
  final bool bannerEnabled;
  final bool criticalMode;
  final bool systemEnabled;
  
  // Métodos: toMap(), fromMap(), copyWith()
}
```

#### ApiStatus
```dart
class ApiStatus {
  final bool isConnected;
  final String message;
  final DateTime lastChecked;
  final int? statusCode;
}
```

---

## 🔄 Fluxo de Dados

### Fluxo de Criação de Alerta

```
1. User toca Botão de Pânico
        ↓
2. DashboardScreen chama AlertProvider.createAlertEvent()
        ↓
3. AlertProvider cria modelo AlertEvent
        ↓
4. DatabaseService.insertAlertEvent() persiste no SQLite
        ↓
5. NotificationService.showAlertNotification() dispara notificação
        ↓
6. ApiService.sendAlertEvent() envia para API (opcional)
        ↓
7. AlertProvider.loadEvents() recarrega lista
        ↓
8. notifyListeners() atualiza UI
        ↓
9. UI re-renderiza com novo evento
```

### Fluxo de Atualização de Preferências

```
1. User altera switch em PreferencesScreen
        ↓
2. PreferencesProvider.toggleVibration() é chamado
        ↓
3. Cria novo AppPreferences com copyWith()
        ↓
4. PreferencesService.savePreferences() persiste
        ↓
5. notifyListeners() notifica observadores
        ↓
6. DashboardScreen recebe atualização
        ↓
7. Próximos alertas usam novas preferências
```

---

## 🗄 Persistência de Dados

### SQLite (Eventos)

**Tabela: alert_events**

| Coluna | Tipo | Constraints |
|--------|------|-------------|
| id | INTEGER | PRIMARY KEY AUTOINCREMENT |
| type | TEXT | NOT NULL |
| timestamp | TEXT | NOT NULL |
| completedAt | TEXT | NULL |
| status | TEXT | NOT NULL |
| description | TEXT | NULL |

**Queries Principais**:
```sql
-- Buscar todos (ordenado)
SELECT * FROM alert_events ORDER BY timestamp DESC

-- Buscar por ID
SELECT * FROM alert_events WHERE id = ?

-- Atualizar status
UPDATE alert_events SET status = ?, completedAt = ? WHERE id = ?

-- Deletar
DELETE FROM alert_events WHERE id = ?
```

### SharedPreferences (Preferências)

**Keys Utilizadas**:
- `vibrationEnabled`: bool
- `soundEnabled`: bool
- `bannerEnabled`: bool
- `criticalMode`: bool
- `systemEnabled`: bool

**Acesso**:
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setBool('vibrationEnabled', true);
bool? value = prefs.getBool('vibrationEnabled');
```

---

## 🔔 Sistema de Notificações

### Inicialização

```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final notificationService = NotificationService();
  await notificationService.initialize();
  
  runApp(MyApp());
}
```

### Canais Android

#### Canal Normal
```dart
AndroidNotificationChannel(
  'normal_channel',
  'Notificações Normais',
  importance: Importance.high,
  playSound: true,
  enableVibration: true,
)
```

#### Canal Crítico
```dart
AndroidNotificationChannel(
  'critical_channel',
  'Alertas Críticos',
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
  sound: RawResourceAndroidNotificationSound('alarm'),
)
```

### Disparo de Notificação

```dart
await _flutterLocalNotificationsPlugin.show(
  id,
  title,
  body,
  NotificationDetails(
    android: AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.max,
    ),
  ),
);
```

---

## 🌐 Integração com API

### Endpoints Utilizados

#### 1. Health Check
```http
GET https://api.publicapis.org/health
Content-Type: application/json
```

**Resposta Esperada**:
```json
{
  "alive": true
}
```

#### 2. Envio de Evento (Demo)
```http
POST https://jsonplaceholder.typicode.com/posts
Content-Type: application/json

{
  "type": "panic",
  "timestamp": "2024-01-01T12:00:00.000Z",
  "description": "Botão de pânico acionado"
}
```

### Tratamento de Erros

```dart
try {
  final response = await http.get(uri).timeout(Duration(seconds: 10));
  if (response.statusCode == 200) {
    return ApiStatus.fromJson(json.decode(response.body));
  }
} catch (e) {
  return ApiStatus.error('Erro: ${e.toString()}');
}
```

---

## 🎨 Design System

### Paleta de Cores

**Status**:
- 🟢 Verde: Sistema ativo, sucesso, completo
- 🔴 Vermelho: Alertas, crítico, erro
- 🔵 Azul: Informação, primário
- 🟠 Laranja: Aviso, pendente
- ⚫ Cinza: Inativo, desabilitado

**Gradientes**:
```dart
LinearGradient(
  colors: [Colors.blue[700]!, Colors.blue[500]!],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
)
```

### Tipografia

**Headers**:
- 28px, Bold: Títulos principais
- 20px, Bold: Subtítulos
- 16px, Bold: Cards e seções

**Body**:
- 16px, Regular: Texto principal
- 14px, Regular: Texto secundário
- 13px, Regular: Captions

### Componentes Reutilizáveis

#### StatusCard
```dart
StatusCard(
  title: 'Status do Sistema',
  value: 'ATIVO',
  icon: Icons.check_circle,
  color: Colors.green,
  onTap: () { },
)
```

#### AlertEventItem
```dart
AlertEventItem(
  event: event,
  onTap: () { },
  onDelete: () { },
)
```

---

## 🧪 Estratégia de Testes

### Testes Unitários

**Escopo**: Modelos e lógica pura

**Cobertura**:
- ✅ Criação de objetos
- ✅ Serialização/Deserialização
- ✅ Métodos copyWith
- ✅ Conversão de tipos
- ✅ Valores padrão
- ✅ Validações

**Estrutura**:
```dart
group('AlertEvent Model Tests', () {
  test('Deve criar um AlertEvent com valores padrão', () {
    // Arrange & Act
    final event = AlertEvent(type: 'panic', timestamp: DateTime.now());
    
    // Assert
    expect(event.type, 'panic');
    expect(event.status, 'pending');
  });
});
```

### Testes Pendentes (Futuro)

- **Widget Tests**: Testar componentes UI isoladamente
- **Integration Tests**: Testar fluxos completos
- **Golden Tests**: Comparação visual de screenshots

---

## 🔐 Segurança

### Dados Locais

**SQLite**:
- Armazenamento local seguro
- Dados não saem do dispositivo
- Sem criptografia (considerar para v2)

**SharedPreferences**:
- Armazenamento key-value local
- Dados não sensíveis
- Acesso restrito ao app

### Comunicação

**HTTP/HTTPS**:
- Todas requisições usam HTTPS
- Timeout de 10 segundos
- Sem armazenamento de tokens (não implementado)

### Permissões

**Princípio do Menor Privilégio**:
- Apenas permissões necessárias
- Solicitadas em runtime (Android 13+)
- Usuário pode revogar a qualquer momento

---

## ⚡ Performance

### Otimizações Implementadas

1. **Lazy Loading**: Providers carregam dados sob demanda
2. **Singleton Pattern**: Services instanciados uma vez
3. **Async/Await**: Operações não bloqueantes
4. **ListView.builder**: Renderização eficiente de listas
5. **const Constructors**: Reduz rebuilds desnecessários

### Métricas

**Tempo de Inicialização**: ~2-3 segundos
**Tempo de Disparo de Alerta**: <500ms
**Consumo de Memória**: ~50-80 MB
**Tamanho do APK**: ~15-20 MB

---

## 🔄 Ciclo de Vida

### Aplicação

```dart
main() 
  → initializeServices()
  → runApp()
  → MultiProvider
  → MaterialApp
  → MainScreen
```

### Providers

```dart
ChangeNotifierProvider(
  create: (_) => PreferencesProvider()..loadPreferences(),
)
```

**Lifecycle**:
1. Create: Provider é instanciado
2. LoadPreferences: Carrega dados iniciais
3. Listen: Widgets se inscrevem
4. Notify: Mudanças propagam
5. Dispose: Cleanup ao fechar app

---

## 📊 Diagramas

### Diagrama de Classes (Simplificado)

```
┌─────────────────┐
│  AlertEvent     │
├─────────────────┤
│ +id             │
│ +type           │
│ +timestamp      │
│ +status         │
├─────────────────┤
│ +toMap()        │
│ +fromMap()      │
│ +copyWith()     │
└─────────────────┘

┌─────────────────┐
│ AlertProvider   │
├─────────────────┤
│ -events         │
│ -isLoading      │
│ -error          │
├─────────────────┤
│ +loadEvents()   │
│ +createEvent()  │
│ +deleteEvent()  │
└─────────────────┘

┌──────────────────┐
│ DatabaseService  │
├──────────────────┤
│ -database        │
├──────────────────┤
│ +insertEvent()   │
│ +getAllEvents()  │
│ +updateEvent()   │
└──────────────────┘
```

---

## 🚀 Melhorias Futuras

### Arquitetura

- [ ] Implementar Repository Pattern completo
- [ ] Adicionar UseCase layer
- [ ] Implementar Dependency Injection (get_it)
- [ ] Adicionar Error Handling centralizado

### Features

- [ ] WebSocket para alertas em tempo real
- [ ] Background Service para monitoramento contínuo
- [ ] Sincronização na nuvem (Firebase)
- [ ] Autenticação de usuário
- [ ] Geolocalização em alertas
- [ ] Envio de SMS/Email automático

### Testes

- [ ] Aumentar cobertura para 80%+
- [ ] Widget Tests
- [ ] Integration Tests
- [ ] Performance Tests

### DevOps

- [ ] CI/CD com GitHub Actions
- [ ] Automated Testing
- [ ] Code Coverage Reports
- [ ] Automated Deployment

---

## 📚 Referências

### Documentação Oficial
- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [SQLite for Flutter](https://pub.dev/packages/sqflite)
- [Local Notifications](https://pub.dev/packages/flutter_local_notifications)

### Padrões e Arquitetura
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [MVVM Pattern](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)
- [Repository Pattern](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-design)

### Materiais de Estudo
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Material Design 3](https://m3.material.io/)

---

**Documentação mantida por: Equipe de Desenvolvimento**

**Última atualização: Dezembro 2024**

