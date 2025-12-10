# Guia Completo de Uso do Sistema de Monitoramento

## 📱 Navegação Principal

O aplicativo possui 3 telas principais acessíveis pela barra de navegação inferior:

### 🏠 Dashboard (Tela Principal)
### 📜 Histórico
### ⚙️ Preferências

---

## 🏠 Dashboard - Tela de Monitoramento

### Visão Geral
A tela de Dashboard é o centro de controle do sistema, onde você pode:
- Monitorar o status em tempo real
- Acionar alertas de emergência
- Visualizar estatísticas rápidas

### Componentes

#### 1. Status do Sistema
- **Localização**: Card superior esquerdo
- **Estados**:
  - ✅ **ATIVO** (Verde): Sistema está monitorando
  - ❌ **INATIVO** (Cinza): Sistema desativado
- **Ação**: Toque no card para alternar o status

#### 2. Alertas Ativos
- **Localização**: Card superior direito
- **Função**: Mostra quantos alertas estão atualmente ativos
- **Cores**:
  - Vermelho: Quando há alertas ativos
  - Laranja: Quando não há alertas

#### 3. Total de Eventos
- **Localização**: Card inferior esquerdo
- **Função**: Contador total de todos os eventos registrados
- **Cor**: Azul

#### 4. Conexão API
- **Localização**: Card inferior direito
- **Estados**:
  - ✅ **OK** (Verde): API respondendo
  - ❌ **ERRO** (Cinza): Sem conexão
- **Ação**: Toque para verificar novamente

#### 5. Botão de Pânico 🚨
- **Localização**: Centro da tela
- **Aparência**: Grande botão vermelho com ícone de emergência
- **Função**: Dispara um alerta de emergência imediato
- **Como usar**:
  1. Toque no botão
  2. O botão mudará de aparência indicando processamento
  3. Uma notificação será enviada imediatamente
  4. O evento será registrado no histórico
  5. Se conectado, o evento será enviado para a API

#### 6. Alertas Recentes
- **Localização**: Parte inferior da tela
- **Função**: Mostra os 3 últimos alertas disparados
- **Ação**: Toque em "Ver todos" para ir ao histórico completo

### Funcionalidades Especiais

#### Pull to Refresh
- Deslize para baixo na tela para atualizar os dados
- Atualiza: eventos, status da API e contadores

#### Feedback Visual
- Quando o botão de pânico é acionado:
  - O botão pulsa e muda de cor
  - Uma mensagem de confirmação aparece
  - A notificação é enviada instantaneamente

---

## 📜 Histórico - Gerenciamento de Eventos

### Visão Geral
Visualize, filtre e gerencie todos os eventos de alerta registrados.

### Filtros Disponíveis

1. **Todos**: Exibe todos os eventos
2. **Ativos**: Apenas eventos em andamento
3. **Concluídos**: Eventos já processados
4. **Pendentes**: Eventos aguardando ação

**Como filtrar**:
- Toque no ícone de filtro (⋮) no canto superior direito
- Selecione o filtro desejado

### Informações do Evento

Cada card de evento exibe:
- **Ícone**: Indica o tipo de evento
- **Tipo**: PANIC, MANUAL, SCHEDULED
- **Status**: Active, Completed, Pending
- **Data/Hora de Disparo**: Quando foi criado
- **Data/Hora de Conclusão**: Quando foi finalizado (se aplicável)
- **Descrição**: Detalhes adicionais

### Ações Disponíveis

#### Visualizar Detalhes
- **Como**: Toque no card do evento
- **Mostra**: Diálogo com informações completas
- **Ações no diálogo**:
  - Marcar como concluído (se ativo)
  - Fechar

#### Deletar Evento
- **Como**: Toque no ícone de lixeira (🗑️) no card
- **Confirmação**: Sistema solicita confirmação
- **Resultado**: Evento é removido permanentemente

#### Deletar Todos
- **Como**: Toque no ícone de vassoura (🧹) no topo
- **Confirmação**: Sistema solicita confirmação
- **Resultado**: Todos os eventos são removidos

### Estados da Tela

#### Carregando
- Exibe um indicador de progresso circular
- Ocorre ao abrir a tela ou atualizar

#### Sem Eventos
- Mostra ícone de caixa vazia
- Mensagem: "Nenhum evento registrado"
- Sugestão para usar o botão de pânico

#### Com Eventos
- Lista rolável com todos os eventos
- Ordenados por data (mais recente primeiro)

#### Erro
- Mostra ícone de erro vermelho
- Exibe mensagem de erro
- Botão "Tentar Novamente"

### Pull to Refresh
Deslize para baixo para recarregar os eventos do banco de dados.

---

## ⚙️ Preferências - Configurações do Sistema

### Visão Geral
Personalize o comportamento do sistema e das notificações.

### Seções de Configuração

#### 1️⃣ Sistema

**Sistema Ativado**
- **Função**: Liga/desliga o sistema de monitoramento
- **Quando Ativo**:
  - Dashboard mostra status verde
  - Alertas podem ser disparados
- **Quando Inativo**:
  - Dashboard mostra status cinza
  - Sistema em standby

**Como usar**:
- Toque no switch
- Confirmação visual aparece

---

#### 2️⃣ Tipos de Notificação

Configure como você quer ser alertado:

**Vibração** 📳
- **ON**: Dispositivo vibra ao receber alerta
- **OFF**: Sem vibração
- **Recomendado**: ON para alertas silenciosos

**Som** 🔊
- **ON**: Toca som ao receber alerta
- **OFF**: Sem som
- **Recomendado**: ON para alertas audíveis

**Banner** 📱
- **ON**: Exibe banner de notificação na tela
- **OFF**: Sem banner visual
- **Recomendado**: ON para alertas visuais

**Combinações Comuns**:
- **Máximo Alerta**: Todos ON
- **Silencioso**: Apenas Vibração
- **Visual**: Apenas Banner
- **Discreto**: Vibração + Banner

---

#### 3️⃣ Modo Crítico ⚠️

**O que é?**
Modo especial que faz alertas ignorarem configurações do dispositivo.

**Quando Ativado**:
- ✅ Sons tocam mesmo em modo silencioso
- ✅ Vibração funciona mesmo se desabilitada no sistema
- ✅ Notificações aparecem como alta prioridade
- ✅ Pode despertar a tela
- ✅ Usa canal de notificação crítico

**Quando Usar**:
- Situações de emergência real
- Quando você PRECISA ser alertado
- Ambientes onde o telefone está sempre silenciado

**Cuidados**:
- ⚠️ Sons tocarão ALTO mesmo em modo silencioso
- ⚠️ Pode violar políticas de silêncio em locais públicos
- ⚠️ Use com responsabilidade

**Como Ativar**:
1. Toque no switch "Modo Crítico"
2. Leia o aviso que aparece
3. Toque em "Entendi" para confirmar

**Indicador Visual**:
- Quando ativo, aparece um banner vermelho de aviso
- Seção fica destacada em vermelho claro

---

#### 4️⃣ Informações

**Sobre o Aplicativo**
- Nome: Sistema de Monitoramento e Alertas
- Versão: 1.0.0
- Tecnologia: Flutter + Provider
- Toque para ver detalhes completos

**Como Funciona**
- Guia rápido de uso
- Explica cada seção do app
- Toque para ver o tutorial

---

### Ações Globais

#### Resetar Preferências
- **Localização**: Ícone de reset (↻) no topo
- **Função**: Restaura todas configurações para padrão
- **Valores Padrão**:
  - Sistema: Desativado
  - Vibração: ON
  - Som: ON
  - Banner: ON
  - Modo Crítico: OFF
- **Confirmação**: Sistema solicita confirmação

---

## 🔔 Sistema de Notificações

### Como Funcionam

#### Disparo Normal
1. Você aciona o botão de pânico
2. Sistema cria o evento no banco
3. Notificação é disparada imediatamente
4. Evento é enviado para API (se conectado)

#### Notificação Recebida
- **Banner**: Aparece na parte superior
- **Som**: Toca o som configurado
- **Vibração**: Dispositivo vibra
- **LED**: Pisca (se dispositivo tiver)

#### Interagindo com Notificação
- **Toque**: Abre o aplicativo
- **Deslizar**: Remove a notificação (evento permanece no histórico)
- **Ignorar**: Notificação fica na central de notificações

### Canais de Notificação

O app usa dois canais:

#### 1. Notificações Normais
- Nome: "Notificações Normais"
- Prioridade: Alta
- Respeita: Modo silencioso do dispositivo
- Uso: Quando modo crítico está OFF

#### 2. Alertas Críticos
- Nome: "Alertas Críticos"
- Prioridade: Máxima
- Ignora: Modo silencioso
- Som: Alto e persistente
- Uso: Quando modo crítico está ON

### Gerenciando Permissões

#### Android 13+
Na primeira execução:
1. App solicita permissão de notificação
2. Toque em "Permitir"
3. Sem permissão, notificações não funcionam

#### Alterar Permissões Depois
1. Configurações do Android
2. Apps > Monitoramento
3. Notificações
4. Ative/desative conforme necessário

---

## 🔄 Integração com API

### O que é enviado

Quando você aciona um alerta:
```json
{
  "type": "panic",
  "timestamp": "2024-01-01T12:00:00.000Z",
  "description": "Botão de pânico acionado manualmente"
}
```

### APIs Usadas

1. **Health Check**: `https://api.publicapis.org/health`
   - Verifica se API está online
   - Atualizado ao abrir dashboard

2. **Envio de Eventos**: `https://jsonplaceholder.typicode.com/posts`
   - API de teste para demonstração
   - Envia eventos de alerta

### Status da Conexão

- ✅ **OK**: API respondendo normalmente
- ❌ **ERRO**: Sem conexão ou API offline
- **...**: Verificando conexão

---

## 💾 Persistência de Dados

### O que é Salvo

#### SharedPreferences (Preferências)
- Vibração: ON/OFF
- Som: ON/OFF
- Banner: ON/OFF
- Modo Crítico: ON/OFF
- Sistema Ativado: ON/OFF

#### SQLite (Eventos)
- ID do evento
- Tipo (panic, manual, scheduled)
- Data/hora de criação
- Data/hora de conclusão
- Status (active, completed, pending)
- Descrição

### Backup e Recuperação

**Dados Preservados**:
- ✅ Eventos permanecem após fechar o app
- ✅ Preferências mantidas após reiniciar
- ✅ Funciona 100% offline

**Dados NÃO Salvos**:
- ❌ Status da API (verificado a cada abertura)
- ❌ Estado de carregamento

---

## 🎯 Cenários de Uso

### Cenário 1: Primeiro Uso

1. Abra o aplicativo
2. Conceda permissão de notificação
3. Vá em Preferências
4. Configure suas preferências
5. Ative o sistema
6. Teste com botão de pânico
7. Verifique histórico

### Cenário 2: Alerta de Emergência

1. Sistema já configurado e ativo
2. Situação de emergência ocorre
3. Abra o app rapidamente
4. Toque no botão de pânico
5. Notificação enviada imediatamente
6. Evento registrado no histórico

### Cenário 3: Modo Crítico

1. Vá em Preferências
2. Ative Modo Crítico
3. Leia e confirme o aviso
4. Coloque telefone em modo silencioso
5. Teste o botão de pânico
6. Som deve tocar mesmo em silencioso

### Cenário 4: Revisão de Histórico

1. Vá em Histórico
2. Veja todos eventos
3. Filtre por status (ex: apenas ativos)
4. Toque em um evento para detalhes
5. Marque como concluído se necessário
6. Delete eventos antigos se desejar

---

## ❓ Perguntas Frequentes

**P: As notificações funcionam com app fechado?**
R: Não nesta versão. O app precisa estar aberto ou em segundo plano.

**P: Os dados são sincronizados na nuvem?**
R: Não, todos os dados são armazenados localmente no dispositivo.

**P: Posso personalizar o som da notificação?**
R: Atualmente usa o som padrão do sistema.

**P: O modo crítico funciona em todos os dispositivos?**
R: Depende do fabricante. Alguns bloqueiam notificações críticas.

**P: Quanto espaço o app ocupa?**
R: Aproximadamente 20-30 MB instalado.

**P: Funciona sem internet?**
R: Sim! Apenas o envio para API requer internet.

**P: Posso ter múltiplos alertas ativos?**
R: Sim, pode disparar quantos alertas quiser.

**P: Como faço backup dos meus dados?**
R: Atualmente não há função de backup. Use backup do sistema Android.

---

## 🚨 Dicas de Segurança

1. **Teste antes de confiar**: Teste todas as funcionalidades em situação segura
2. **Verifique permissões**: Certifique-se de que notificações estão permitidas
3. **Modo Crítico**: Use apenas quando realmente necessário
4. **Bateria**: Modo crítico pode consumir mais bateria
5. **Privacidade**: Dados ficam apenas no seu dispositivo

---

## 📞 Suporte

Se você encontrar problemas ou tiver dúvidas:

1. Consulte o README.md para documentação técnica
2. Veja INSTALLATION.md para problemas de instalação
3. Verifique a seção de troubleshooting
4. Entre em contato com o desenvolvedor

---

**Desenvolvido com ❤️ usando Flutter**

