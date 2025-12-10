# 🎨 Guia Visual da Aplicação

Descrição visual das telas e fluxos do Sistema de Monitoramento e Alertas.

---

## 📱 Navegação Principal

```
┌─────────────────────────────────────────┐
│                                         │
│         Conteúdo da Tela                │
│                                         │
│                                         │
│                                         │
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│  🏠 Dashboard  |  📜 Histórico  |  ⚙️ Preferências │
└─────────────────────────────────────────┘
```

**3 Telas Principais** acessíveis pela barra inferior.

---

## 🏠 Dashboard - Tela de Monitoramento

### Layout

```
╔═══════════════════════════════════════╗
║  Sistema de Monitoramento             ║
║  Status: Ativo ✓                      ║
╠═══════════════════════════════════════╣
║                                       ║
║  ┌──────────┐    ┌──────────┐       ║
║  │ Sistema  │    │ Alertas  │       ║
║  │  ATIVO   │    │ Ativos   │       ║
║  │    ✓     │    │    2     │       ║
║  └──────────┘    └──────────┘       ║
║                                       ║
║  ┌──────────┐    ┌──────────┐       ║
║  │ Total de │    │ Conexão  │       ║
║  │ Eventos  │    │   API    │       ║
║  │    15    │    │    OK    │       ║
║  └──────────┘    └──────────┘       ║
║                                       ║
║  ╔═══════════════════════════╗       ║
║  ║                           ║       ║
║  ║      🚨 EMERGÊNCIA       ║       ║
║  ║                           ║       ║
║  ║   BOTÃO DE PÂNICO        ║       ║
║  ║   Toque para acionar     ║       ║
║  ║                           ║       ║
║  ╚═══════════════════════════╝       ║
║                                       ║
║  Alertas Recentes          Ver todos ║
║  ┌─────────────────────────────────┐ ║
║  │ 🚨 PANIC      [Active]          │ ║
║  │    09/12/2024 21:00:00          │ ║
║  └─────────────────────────────────┘ ║
║  ┌─────────────────────────────────┐ ║
║  │ 🚨 PANIC      [Completed]       │ ║
║  │    09/12/2024 20:30:00          │ ║
║  └─────────────────────────────────┘ ║
║                                       ║
╚═══════════════════════════════════════╝
```

### Componentes

#### 1. Header (Azul Gradiente)
- Título do sistema
- Status atual (Ativo/Inativo)

#### 2. Cards de Status (4 cards em grid 2x2)
- **Verde**: Sistema Ativo
- **Vermelho**: Alertas Ativos
- **Azul**: Total de Eventos
- **Verde/Cinza**: Conexão API

#### 3. Botão de Pânico (Destaque vermelho)
- Grande, centralizado
- Efeito de pulso quando acionado
- Ícone de emergência
- Texto chamativo

#### 4. Alertas Recentes
- 3 últimos eventos
- Botão "Ver todos" para histórico

---

## 📜 Histórico - Tela de Eventos

### Layout

```
╔═══════════════════════════════════════╗
║  Histórico de Alertas    ⋮  🗑️        ║
╠═══════════════════════════════════════╣
║  🔍 Filtro: Todos     |  15 evento(s) ║
╠═══════════════════════════════════════╣
║                                       ║
║  ┌─────────────────────────────────┐ ║
║  │ 🚨  PANIC         [Active]  🗑️  │ ║
║  │     Disparado: 09/12 21:00:00   │ ║
║  │     Botão de pânico acionado    │ ║
║  └─────────────────────────────────┘ ║
║                                       ║
║  ┌─────────────────────────────────┐ ║
║  │ ✅  PANIC      [Completed]  🗑️  │ ║
║  │     Disparado: 09/12 20:30:00   │ ║
║  │     Concluído: 09/12 20:35:00   │ ║
║  └─────────────────────────────────┘ ║
║                                       ║
║  ┌─────────────────────────────────┐ ║
║  │ 🚨  MANUAL        [Active]  🗑️  │ ║
║  │     Disparado: 09/12 20:00:00   │ ║
║  │     Alerta manual               │ ║
║  └─────────────────────────────────┘ ║
║                                       ║
║  ┌─────────────────────────────────┐ ║
║  │ ⏰  SCHEDULED   [Pending]  🗑️   │ ║
║  │     Disparado: 09/12 19:30:00   │ ║
║  │     Alerta agendado             │ ║
║  └─────────────────────────────────┘ ║
║                                       ║
╚═══════════════════════════════════════╝
```

### Funcionalidades

#### Barra Superior
- Botão de filtro (⋮)
- Botão deletar todos (🗑️)

#### Barra de Filtro
- Status atual do filtro
- Contador de eventos

#### Lista de Eventos
- Card para cada evento
- Ícone baseado no status
- Tipo (PANIC, MANUAL, SCHEDULED)
- Status (Active, Completed, Pending)
- Timestamps
- Descrição
- Botão deletar individual

#### Estados
- **Vazio**: Ícone de inbox vazio
- **Carregando**: Spinner circular
- **Erro**: Mensagem de erro + botão retry

---

## ⚙️ Preferências - Tela de Configurações

### Layout

```
╔═══════════════════════════════════════╗
║  Preferências              ↻          ║
╠═══════════════════════════════════════╣
║                                       ║
║  ⚙️ Sistema                           ║
║  ┌─────────────────────────────────┐ ║
║  │ 🔌 Sistema Ativado       [ON]   │ ║
║  │    O sistema está ativo         │ ║
║  └─────────────────────────────────┘ ║
║                                       ║
║  🔔 Tipos de Notificação             ║
║  ┌─────────────────────────────────┐ ║
║  │ 📳 Vibração              [ON]   │ ║
║  │    Vibrar ao receber alertas    │ ║
║  ├─────────────────────────────────┤ ║
║  │ 🔊 Som                   [ON]   │ ║
║  │    Reproduzir som               │ ║
║  ├─────────────────────────────────┤ ║
║  │ 📱 Banner                [ON]   │ ║
║  │    Exibir banner                │ ║
║  └─────────────────────────────────┘ ║
║                                       ║
║  ⚠️ Modo Crítico                     ║
║  ┌─────────────────────────────────┐ ║
║  │ 🚨 Modo Crítico          [OFF]  │ ║
║  │    INATIVO: Respeita config     │ ║
║  └─────────────────────────────────┘ ║
║                                       ║
║  ℹ️ Informações                      ║
║  ┌─────────────────────────────────┐ ║
║  │ 📱 Sobre o Aplicativo        >  │ ║
║  │    Sistema v1.0.0               │ ║
║  ├─────────────────────────────────┤ ║
║  │ ❓ Como Funciona             >  │ ║
║  │    Entenda o sistema            │ ║
║  └─────────────────────────────────┘ ║
║                                       ║
╚═══════════════════════════════════════╝
```

### Seções

#### 1. Sistema
- Switch de ativação
- Feedback ao alternar

#### 2. Tipos de Notificação
- 3 switches (Vibração, Som, Banner)
- Descrição de cada um

#### 3. Modo Crítico (Destaque)
- Switch com confirmação
- Banner de aviso quando ativo
- Explicação detalhada

#### 4. Informações
- Sobre o aplicativo
- Tutorial de uso

---

## 🔔 Sistema de Notificações

### Notificação Normal

```
┌─────────────────────────────────────┐
│ 🚨 Alerta de Segurança              │
│ Botão de pânico acionado manualmente│
│                                     │
│ Agora                    [Expandir] │
└─────────────────────────────────────┘
```

### Notificação Crítica (Modo Crítico Ativo)

```
┌─────────────────────────────────────┐
│ 🚨🚨 ALERTA CRÍTICO 🚨🚨             │
│ Botão de pânico acionado!           │
│                                     │
│ URGENTE                  [Expandir] │
└─────────────────────────────────────┘
```

**Diferenças**:
- Modo crítico: Som alto, ignora silencioso
- Modo normal: Respeita configurações do sistema

---

## 🎨 Paleta de Cores

### Status
```
🟢 Verde (#4CAF50)    → Ativo, Sucesso, Completo
🔴 Vermelho (#F44336) → Alerta, Erro, Crítico
🔵 Azul (#2196F3)     → Informação, Primário
🟠 Laranja (#FF9800)  → Aviso, Pendente
⚫ Cinza (#9E9E9E)    → Inativo, Desabilitado
```

### Gradientes

**Dashboard Header**
```
Azul Escuro (#1976D2) → Azul Claro (#2196F3)
```

**Cards de Status**
```
Verde:    #66BB6A → #4CAF50
Vermelho: #EF5350 → #F44336
Azul:     #42A5F5 → #2196F3
Laranja:  #FFA726 → #FF9800
```

**Botão de Pânico**
```
Vermelho: #EF5350 → #E53935 (com pulso)
```

---

## 🎭 Estados Visuais

### Loading (Carregando)

```
┌─────────────────────────────────────┐
│                                     │
│              ⟳                      │
│         Carregando...               │
│                                     │
└─────────────────────────────────────┘
```

### Empty (Vazio)

```
┌─────────────────────────────────────┐
│                                     │
│              📭                     │
│      Nenhum evento registrado       │
│   Acione o botão de pânico para     │
│        criar novos alertas          │
│                                     │
└─────────────────────────────────────┘
```

### Error (Erro)

```
┌─────────────────────────────────────┐
│                                     │
│              ❌                     │
│       Erro ao carregar eventos      │
│    Falha na conexão com banco       │
│                                     │
│        [Tentar Novamente]           │
│                                     │
└─────────────────────────────────────┘
```

### Success (Sucesso)

```
┌─────────────────────────────────────┐
│ ✅ Alerta disparado com sucesso!    │
└─────────────────────────────────────┘
```

---

## 🎬 Fluxos de Uso

### Fluxo 1: Acionar Alerta

```
Dashboard
   ↓
[Pressiona Botão de Pânico]
   ↓
Botão muda aparência (pulsa)
   ↓
Notificação enviada
   ↓
SnackBar de confirmação
   ↓
Evento salvo no banco
   ↓
Lista atualizada
```

### Fluxo 2: Ver Histórico

```
Dashboard
   ↓
[Toca "Ver todos" ou aba Histórico]
   ↓
Lista de eventos carregada
   ↓
[Toca em um evento]
   ↓
Dialog com detalhes
   ↓
Opção: Marcar como concluído
```

### Fluxo 3: Configurar Preferências

```
Preferências
   ↓
[Alterna switch]
   ↓
Confirmação visual
   ↓
Salvo em SharedPreferences
   ↓
Dashboard reflete mudança
```

### Fluxo 4: Modo Crítico

```
Preferências
   ↓
[Ativa Modo Crítico]
   ↓
Dialog de confirmação
   ↓
Banner de aviso aparece
   ↓
Dashboard
   ↓
[Aciona alerta]
   ↓
Notificação CRÍTICA (ignora silencioso)
```

---

## 📊 Animações

### Botão de Pânico
```
Estado Normal → [Pressionar] → Pulsar e expandir
                             → Mudar cor (mais escuro)
                             → Texto muda
                             → 2 segundos → Volta ao normal
```

### Pull to Refresh
```
[Deslizar para baixo]
   ↓
Spinner aparece
   ↓
Dados recarregados
   ↓
Spinner desaparece
   ↓
Lista atualizada
```

### Navegação entre Abas
```
[Toca aba]
   ↓
Slide animation
   ↓
Nova tela aparece
   ↓
Ícone da aba destacado
```

---

## 🎯 Elementos Interativos

### Dashboard
- ✅ Cards de status (tocar para ação)
- ✅ Botão de pânico (tocar para disparar)
- ✅ "Ver todos" (navega para histórico)
- ✅ Pull to refresh (deslizar)

### Histórico
- ✅ Filtro (menu dropdown)
- ✅ Deletar todos (confirmação)
- ✅ Evento (tocar para detalhes)
- ✅ Deletar individual (tocar lixeira)
- ✅ Pull to refresh (deslizar)

### Preferências
- ✅ Switches (alternar configurações)
- ✅ Resetar (confirmação)
- ✅ Sobre (dialog informativo)
- ✅ Como funciona (tutorial)

---

## 📱 Responsividade

### Portrait (Retrato)
- Layout em coluna
- Cards em grid 2x2
- Botão de pânico centralizado

### Landscape (Paisagem)
- Layout adapta automaticamente
- Mais espaço horizontal
- Mesma funcionalidade

---

## ✨ Feedback Visual

### Ações do Usuário

| Ação | Feedback |
|------|----------|
| Pressiona botão | Animação de pulso |
| Dispara alerta | SnackBar verde |
| Erro | SnackBar vermelho |
| Sucesso | SnackBar verde |
| Alterna switch | Animação suave |
| Deleta evento | Confirmação dialog |
| Pull to refresh | Spinner + atualização |

---

## 🎨 Ícones Utilizados

```
🏠 Dashboard          - home, dashboard
📜 Histórico          - history, event_note
⚙️ Preferências       - settings
🚨 Alerta/Pânico      - warning, emergency
✅ Concluído          - check_circle
📳 Vibração           - vibration
🔊 Som                - volume_up
📱 Banner             - notifications_active
🔗 API                - cloud_done / cloud_off
🗑️ Deletar            - delete
⋮  Menu              - more_vert
↻  Resetar           - restore
❓ Ajuda             - help_outline
ℹ️ Info              - info_outline
```

---

## 🎓 Convenções de UI

### Cores Semânticas
- Verde = Positivo (ativo, sucesso, completo)
- Vermelho = Urgente (alerta, erro, crítico)
- Azul = Neutro (informação, padrão)
- Laranja = Atenção (aviso, pendente)
- Cinza = Inativo (desabilitado, secundário)

### Hierarquia Visual
1. Botão de pânico (maior destaque)
2. Cards de status (destaque médio)
3. Lista de eventos (informação)
4. Texto descritivo (menor destaque)

### Espaçamentos
- Padding externo: 16-24px
- Padding interno: 12-16px
- Espaçamento entre elementos: 8-16px

---

**Guia visual completo do Sistema de Monitoramento e Alertas**

**Versão**: 1.0.0  
**Última atualização**: Dezembro 2024

