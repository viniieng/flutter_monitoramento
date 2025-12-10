# Guia de Instalação e Execução

## 🚀 Instalação Rápida

### 1. Verifique a instalação do Flutter

Abra o terminal e execute:

```bash
flutter --version
```

Se o comando não for reconhecido, adicione o Flutter ao PATH do sistema ou use o caminho completo.

### 2. Instale as dependências

No diretório do projeto, execute:

```bash
flutter pub get
```

### 3. Verifique a configuração

```bash
flutter doctor
```

Certifique-se de que todas as dependências estão instaladas corretamente.

### 4. Execute o aplicativo

#### No emulador/dispositivo Android:
```bash
flutter run
```

#### Para uma plataforma específica:
```bash
flutter run -d windows    # Para Windows
flutter run -d android    # Para Android
flutter run -d ios        # Para iOS (somente macOS)
```

### 5. Execute os testes

```bash
flutter test
```

## 📱 Executando no Android

### Usando Dispositivo Físico

1. Habilite o modo de desenvolvedor no seu dispositivo Android
2. Conecte o dispositivo via USB
3. Execute: `flutter devices` para verificar se o dispositivo foi detectado
4. Execute: `flutter run`

### Usando Emulador

1. Abra o Android Studio
2. Vá em Tools > AVD Manager
3. Crie ou inicie um emulador
4. Execute: `flutter run`

## 🔧 Compilando para Release

### Android APK

```bash
flutter build apk --release
```

O APK será gerado em: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (para Google Play)

```bash
flutter build appbundle --release
```

## 🐛 Problemas Comuns

### Flutter não encontrado

Se o comando `flutter` não for reconhecido:

**Windows:**
1. Localize onde o Flutter está instalado (ex: `C:\src\flutter`)
2. Adicione ao PATH: `C:\src\flutter\bin`
3. Reinicie o terminal

**Linux/Mac:**
```bash
export PATH="$PATH:[caminho-para-flutter]/bin"
```

### Erro de dependências

```bash
flutter clean
flutter pub get
```

### Erro no Android

```bash
cd android
./gradlew clean    # Linux/Mac
gradlew.bat clean  # Windows
cd ..
flutter run
```

### Erro de permissões Android 13+

O app solicitará permissão de notificação na primeira execução. Certifique-se de conceder a permissão.

## 📊 Executar com análise de código

```bash
flutter analyze
```

## 🧪 Executar testes com cobertura

```bash
flutter test --coverage
```

## 🔍 Debug

### Modo Debug
```bash
flutter run --debug
```

### Modo Profile (para análise de performance)
```bash
flutter run --profile
```

### Logs detalhados
```bash
flutter run -v
```

## 📦 Estrutura de Build

Após a compilação, os arquivos estarão em:

- **Android APK**: `build/app/outputs/flutter-apk/`
- **Android Bundle**: `build/app/outputs/bundle/release/`
- **iOS**: `build/ios/iphoneos/`

## ⚙️ Configurações Avançadas

### Alterar o nome do pacote Android

Edite `android/app/build.gradle`:
```gradle
defaultConfig {
    applicationId "com.seudominio.flutter_monitoramento"
    ...
}
```

### Alterar ícone do app

Coloque seus ícones em:
- Android: `android/app/src/main/res/mipmap-*/`
- iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

Ou use o pacote `flutter_launcher_icons`:
```bash
flutter pub add flutter_launcher_icons
```

## 📱 Testando Notificações

### Android

1. Compile e instale o app
2. Acione o botão de pânico no dashboard
3. Minimize o app
4. A notificação deve aparecer na barra de status

### Modo Crítico

1. Ative o Modo Crítico nas Preferências
2. Coloque o dispositivo em modo silencioso
3. Acione um alerta
4. O som deve tocar mesmo em modo silencioso

## 🔐 Permissões Necessárias

O app solicitará automaticamente as seguintes permissões:

- **Notificações** (Android 13+): Necessária para exibir alertas
- **Vibração**: Para feedback tátil
- **Internet**: Para comunicação com API

## 📝 Notas Importantes

1. **Primeira Execução**: Pode demorar mais devido à compilação inicial
2. **Hot Reload**: Use `r` no terminal para recarregar rápido durante desenvolvimento
3. **Hot Restart**: Use `R` para reiniciar completamente o app
4. **Quit**: Use `q` para sair do modo de execução

## 🆘 Suporte

Se encontrar problemas:

1. Execute `flutter doctor` para diagnóstico
2. Limpe o cache com `flutter clean`
3. Reinstale dependências com `flutter pub get`
4. Verifique a versão do Flutter: `flutter --version`
5. Consulte a documentação oficial: https://flutter.dev/docs

## 📖 Links Úteis

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- [SQLite](https://pub.dev/packages/sqflite)

---

**Desenvolvido com Flutter**

