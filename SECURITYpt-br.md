<div align="center">

# Política de Segurança

[English (US)](./SECURITY.md)

</div>

---

## Versões Suportadas

Apenas a versão mais recente disponível na branch main é mantida ativamente com correções de segurança e atualizações.

| Versão | Suportada |
| ------ | --------- |
| Branch main | Sim |
| Commits anteriores | Não |

---

## Como Reportar uma Vulnerabilidade

A segurança e a integridade do sistema são tratadas com seriedade neste projeto. Se você descobrir uma vulnerabilidade de segurança, impacto indesejado no sistema ou falha de execução, relate de forma responsável.

### Passos para Reportar

1. Abra uma nova Issue no repositório do GitHub categorizada como Segurança ou entre em contato diretamente pelo perfil do mantenedor.
2. Descreva detalhadamente o problema encontrado.
3. Inclua os passos necessários para reproduzir o comportamento:
   - Versão e compilação do Windows (ex: Windows 11 23H2 / Windows 10 22H2).
   - Logs ou códigos de erro exibidos durante a execução.
   - Comportamento esperado versus o comportamento real observado.

### Tempo de Resposta

Os relatos serão analisados o mais breve possível. Falhas críticas de sistema terão prioridade máxima para correção.

---

## Impacto no Sistema e Transparência

O Edge Killer interage diretamente com componentes e registros do Windows. Para total transparência, segue a lista completa de modificações realizadas:

### 1. Chaves de Registro
O script altera apenas configurações padrão do sistema:
- `HKLM:\SOFTWARE\Microsoft\EdgeUpdate`
  - Define `DoNotUpdateToEdgeWithChromium = 1` (Política oficial da Microsoft que impede a reinstalação automática do navegador pelo Windows Update).
- `HKCU:\Software\Policies\Microsoft\Windows\Explorer`
  - Define `DisableSearchBoxSuggestions = 1` (Desativa sugestões de busca web do Bing na barra de pesquisa).
- `HKCU:\Software\Microsoft\Windows\CurrentVersion\Search`
  - Define `SearchboxTaskbarMode = 0` (Oculta a lupa da barra de tarefas, mantendo apenas o botão Iniciar).
  - Define `BingSearchEnabled = 0` e `CortanaConsent = 0` (Desativa consultas web no SearchHost).

### 2. Serviços e Tarefas Agendadas
- Desativa os serviços do sistema: `edgeupdate` e `edgeupdatem`.
- Desativa as tarefas agendadas: `MicrosoftEdgeUpdateTaskMachineCore` e `MicrosoftEdgeUpdateTaskMachineUA`.

### 3. Sistema de Arquivos e Pacotes
- Executa o próprio desinstalador oficial do Microsoft Edge com parâmetros silenciosos (`setup.exe --uninstall --system-level --force-uninstall`).
- Remove atalhos residuais (`.lnk`) da Área de Trabalho e Menu Iniciar.
- Filtra e preserva pacotes de desenvolvimento protegidos do Windows para evitar erros e instabilidades no AppX.

---

## Rede e Privacidade de Dados

- **Zero Telemetria:** O script não coleta, armazena ou transmite nenhum dado do usuário, identificadores de hardware ou informações pessoais.
- **Sem Binários Externos:** O script não baixa executáveis de terceiros (`.exe`, `.dll` ou drivers). Ele utiliza exclusivamente recursos nativos do PowerShell, APIs do Windows e o instalador nativo já existente na máquina.

---

## Boas Práticas

Ao executar scripts por comandos remotos (`irm | iex`), recomenda-se:
1. Inspecionar o código-fonte no repositório antes da execução.
2. Garantir que o comando executado aponte para o repositório oficial.
3. Executar o terminal como Administrador apenas com a intenção explícita de realizar as modificações.

---

## Isenção de Responsabilidade

Este software é fornecido "no estado em que se encontra", sem garantias expressas ou implícitas. Embora todas as alterações utilizem métodos oficiais do Windows e exista função de reversão, o usuário assume total responsabilidade ao executar modificações a nível de sistema em seu dispositivo.
