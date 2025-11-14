# RPA0180 - Tratamento e Roteamento de Dados de Faturas

## Visão Geral

Este robô (RPA) atua como um processador e roteador de dados. Ele foi desenvolvido para ler informações de faturas de uma fila do UiPath Orchestrator, enriquecer esses dados com informações de uma base mestre no Google Cloud Platform (GCP), e direcionar os dados consolidados para o próximo robô no fluxo do processo (RPA0174).

---

## Para o Usuário Final

### O que o robô faz?

O principal objetivo deste robô é orquestrar dados entre diferentes sistemas e processos. Ele realiza as seguintes ações:

1.  **Leitura de Dados:** Inicia ao consumir um item de uma fila no UiPath Orchestrator. Este item contém dados de faturas em formato JSON.
2.  **Consulta a Dados Mestres:** Conecta-se ao Google Cloud Platform (GCP) para buscar informações complementares em uma base de dados mestre.
3.  **Consolidação de Dados:** Vincula as informações da fatura (obtidas da fila) com os dados mestres (obtidos do GCP).
4.  **Armazenamento de Auditoria:** Salva os dados brutos da fatura em duas tabelas no GCP para fins de auditoria e rastreabilidade: uma tabela principal e uma tabela de serviços.
5.  **Notificações via Microsoft Teams:** Envia alertas em duas situações críticas:
    *   Quando uma fatura é identificada como "substituta".
    *   Quando as informações necessárias não são encontradas na base de dados mestre do GCP.
6.  **Envio para o Próximo Processo:** Cria um novo item de fila, contendo os dados já consolidados e enriquecidos, e o envia para a fila do robô **RPA0174**, que dará continuidade ao processo.

### Entradas e Saídas

*   **Entrada:** Itens da fila do Orchestrator contendo dados de faturas em formato JSON.
*   **Saída:**
    *   Dados da fatura salvos em duas tabelas no Google BigQuery.
    *   Notificações em um canal do Microsoft Teams (em casos de exceção).
    *   Novos itens de fila, com dados enriquecidos, enviados para o processo RPA0174.

---

## Para Desenvolvedores

### Arquitetura

Este projeto é baseado no **UiPath Robotic Enterprise Framework (REFramework)**. Ele foi projetado para atuar como um robô de back-office (não assistido) que lida com a lógica de processamento de dados entre sistemas.

### Pré-requisitos

*   UiPath Studio (versão 23.10.12.0 ou compatível).
*   Acesso ao Google Cloud Platform (GCP) com permissões para o BigQuery.
*   Credenciais para autenticação no GCP.
*   Webhook ou credenciais para envio de notificações no Microsoft Teams.

### Estrutura do Projeto

*   `Main.xaml`: Ponto de entrada do processo.
*   `Framework/`: Contém os workflows padrão do REFramework.
*   `ProcessBox/`: Contém os workflows customizados para este processo.
    *   `AUTENTICACOES/`: Workflows para autenticação no Google e MS 365.
    *   `Google/`: Workflows para interação com o Google BigQuery (consulta e inserção).
        *   `SQL/`: Scripts SQL para `SELECT` na base mestre e `INSERT` nas tabelas de faturas e serviços.
    *   `Office/`: Contém o workflow `NotificaSeSubstituta.xaml`, responsável por enviar alertas para o Microsoft Teams.
    *   `EnviarDadosFila.xaml`: Workflow para enviar o novo item para a fila do RPA0174.
*   `Data/Config.xlsx`: Arquivo de configuração principal do robô.

### Configuração

O arquivo `Data/Config.xlsx` é o principal ponto de configuração do robô. Nele, você pode ajustar:

*   **Nomes das Filas do Orchestrator:** Fila de entrada (de onde o RPA0180 lê) e fila de saída (para o RPA0174).
*   **Detalhes do Projeto GCP:** ID do projeto, nomes dos datasets e das tabelas de destino.
*   **Configurações de Notificação:** URL do Webhook do Microsoft Teams e mensagens padrão.

### Fluxo do Processo

1.  **Inicialização:**
    *   `InitAllSettings.xaml`: Carrega as configurações do `Config.xlsx` e dos assets do Orchestrator.
    *   `InitAllApplications.xaml`: Realiza a autenticação no Google Cloud.

2.  **Obtenção de Dados da Transação:**
    *   `GetTransactionData.xaml`: Obtém o próximo item da fila do Orchestrator. O item contém os dados da fatura em JSON.

3.  **Processamento da Transação:**
    *   `Process.xaml`: Orquestra a lógica principal.
    *   Os dados JSON do item da fila são desserializados.
    *   O robô executa uma consulta (`consulta_masterdata.sql`) no BigQuery para obter dados mestres.
    *   **Lógica de Validação:**
        *   Se os dados mestres não são encontrados, uma notificação é enviada via Teams e a transação pode ser marcada como exceção.
        *   Se a fatura é do tipo "substituta", uma notificação é enviada.
    *   Os dados da fila e do GCP são vinculados.
    *   O robô executa os `INSERT`s (`insert_faturas.sql`, `insert_servicos.sql`) para salvar os dados brutos nas tabelas do BigQuery.
    *   `EnviarDadosFila.xaml`: Um novo item de fila é criado com os dados consolidados e enviado para a fila do RPA0174.

4.  **Finalização:**
    *   `CloseAllApplications.xaml`: Realiza o logout de todas as aplicações.

