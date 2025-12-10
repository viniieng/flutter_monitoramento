# 🌐 Guia de Execução Web (Chrome)

Este guia mostra como executar o Sistema de Monitoramento e Alertas no navegador Chrome.

---

## 🚀 Instalação Rápida para Web

### Pré-requisitos
- Flutter SDK instalado
- Chrome instalado

### Passo 1: Habilitar Suporte Web

```bash
flutter config --enable-web
```

### Passo 2: Criar Arquivos Web

```bash
flutter create --platforms=web .
```

Este comando criará a pasta `web/` com os arquivos necessários.

### Passo 3: Instalar Dependências

```bash
flutter pub get
```

### Passo 4: Executar no Chrome

```bash
flutter run -d chrome
```

Ou simplesmente:

```bash
flutter run
```

E selecione "Chrome" quando aparecer a lista de dispositivos.

---

## 🔧 Adaptações para Web

O projeto foi adaptado para funcionar perfeitamente no navegador:

### ✅ O que FUNCIONA no Web

- ✅ **Interface completa** - Todas as 3 telas funcionais
- ✅ **Navegação** - Tabs e rotas
- ✅ **State Management** - Provider funcionando
- ✅ **Persistência** - SharedPreferences (usa localStorage)
- ✅ **API HTTP** - Integração com APIs externas
- ✅ **Histórico** - Armazenamento de eventos (LocalStorage)
- ✅ **Preferências** - Salvamento de configurações
- ✅ **Filtros** - Sistema de filtros no histórico
- ✅ **Pull to Refresh** - Atualização de dados

### 🔄 Adaptações Realizadas

#### 1. Banco de Dados
**Antes (Mobile)**: SQLite  
**Agora (Web)**: SharedPreferences + JSON

- Eventos são salvos como JSON no localStorage
- Mantém todas as funcionalidades de CRUD
- Funciona offline

#### 2. Notificações
**Antes (Mobile)**: flutter_local_notifications  
**Agora (Web)**: Notificações simuladas no console

- Notificações aparecem no console do navegador
- Feedback visual via SnackBar
- Possibilidade de implementar Web Notifications API

#### 3. Permissões
**Antes (Mobile)**: permission_handler  
**Agora (Web)**: Removido (não necessário)

---

## 🎯 Como Usar no Chrome

### Primeira Execução

1. Execute o comando:
```bash
flutter run -d chrome
```

2. O Chrome abrirá automaticamente

3. Aguarde a compilação (primeira vez demora mais)

4. O app estará rodando em `localhost:porta`

### Testando Funcionalidades

#### Dashboard
- ✅ Veja o status do sistema
- ✅ Pressione o botão de pânico
- ✅ Veja os cards de status
- ✅ Verifique conexão com API

#### Histórico
- ✅ Veja lista de eventos
- ✅ Use os filtros (Todos, Ativos, Concluídos)
- ✅ Clique em eventos para detalhes
- ✅ Delete eventos

#### Preferências
- ✅ Ative/desative o sistema
- ✅ Configure tipos de notificação
- ✅ Ative modo crítico
- ✅ Reset de configurações

---

## 🔍 DevTools do Chrome

Para ver as "notificações":

1. Abra o DevTools (F12)
2. Vá na aba "Console"
3. Acione um alerta no app
4. Veja a notificação no console:

```
🔔 NOTIFICAÇÃO WEB:
   Título: 🚨 Alerta de Segurança
   Mensagem: Botão de pânico acionado!
   Horário: 2024-12-09 21:30:00
```

---

## 📊 Armazenamento Local (LocalStorage)

### Verificar Dados Salvos

1. Abra DevTools (F12)
2. Vá em "Application" → "Local Storage"
3. Clique em `localhost`
4. Veja as chaves:
   - `alert_events` - Eventos salvos
   - `vibrationEnabled` - Preferências
   - etc.

### Limpar Dados

```javascript
// No console do Chrome:
localStorage.clear();
```

---

## 🐛 Troubleshooting Web

### Erro: "No devices found"

**Solução**:
```bash
flutter config --enable-web
flutter doctor
```

### Erro: "Web is not enabled"

**Solução**:
```bash
flutter channel stable
flutter upgrade
flutter config --enable-web
```

### Página em branco

**Solução**:
1. Limpe o cache: `flutter clean`
2. Reinstale: `flutter pub get`
3. Execute novamente: `flutter run -d chrome`

### Hot Reload não funciona

**Solução**:
- Use `r` no terminal para hot reload
- Use `R` para hot restart
- Ou reinicie o app

---

## 🚀 Build para Produção Web

### Criar Build de Produção

```bash
flutter build web --release
```

Os arquivos estarão em: `build/web/`

### Testar Build Local

```bash
# Instale um servidor HTTP simples
python -m http.server 8000 -d build/web

# Ou use
npx serve build/web
```

Acesse: `http://localhost:8000`

### Deploy

Faça upload da pasta `build/web/` para:
- Firebase Hosting
- GitHub Pages
- Netlify
- Vercel
- Qualquer servidor web

---

## 📝 Diferenças Mobile vs Web

| Funcionalidade | Mobile | Web |
|----------------|--------|-----|
| Interface | ✅ | ✅ |
| Navegação | ✅ | ✅ |
| State Management | ✅ | ✅ |
| Persistência | SQLite | LocalStorage |
| Notificações | Nativas | Console/SnackBar |
| API HTTP | ✅ | ✅ |
| Permissões | Necessárias | Não necessárias |
| Performance | Excelente | Muito Boa |

---

## 💡 Dicas para Web

### Performance

1. **Use Release Mode** para melhor performance:
```bash
flutter run -d chrome --release
```

2. **Minimize Rebuilds**:
- Use `const` quando possível
- Evite widgets pesados

### Debug

1. **Flutter DevTools**:
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

2. **Console Logs**:
```dart
print('Debug: $variavel');
```

### Compatibilidade

- ✅ Chrome (recomendado)
- ✅ Edge
- ✅ Firefox
- ✅ Safari
- ⚠️ IE (não suportado)

---

## 🎨 Recursos Web Específicos

### Responsividade

O app adapta automaticamente para:
- 📱 Mobile (< 600px)
- 💻 Desktop (> 600px)
- 🖥️ Wide screens (> 1200px)

### Atalhos de Teclado

- `r` - Hot reload
- `R` - Hot restart
- `q` - Quit
- `h` - Help

---

## 📦 Estrutura Web

```
build/web/
├── index.html          # Página principal
├── main.dart.js        # App compilado
├── flutter.js          # Flutter engine
├── assets/             # Recursos
└── icons/              # Ícones
```

---

## ✅ Checklist Web

Antes de rodar no Chrome:

- [ ] Flutter web habilitado
- [ ] Dependências instaladas
- [ ] Chrome disponível
- [ ] Porta livre (default: random)

Funcionalidades testadas:

- [ ] Dashboard carrega
- [ ] Botão de pânico funciona
- [ ] Histórico exibe eventos
- [ ] Filtros funcionam
- [ ] Preferências salvam
- [ ] API conecta
- [ ] Pull to refresh funciona

---

## 🔗 Links Úteis

- [Flutter Web Docs](https://flutter.dev/web)
- [Debugging Web Apps](https://flutter.dev/docs/development/tools/devtools/overview)
- [Web Renderers](https://flutter.dev/docs/development/tools/web-renderers)

---

## 🎉 Pronto!

Agora você pode executar o Sistema de Monitoramento e Alertas no Chrome! 🌐

```bash
flutter run -d chrome
```

**Aproveite a versão web!** ✨

---

**Última atualização**: Dezembro 2024  
**Versão Web**: 1.0.0-web  
**Status**: ✅ Funcionando no Chrome

