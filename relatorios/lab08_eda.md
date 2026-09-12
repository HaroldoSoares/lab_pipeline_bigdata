# Lab 08 — Análise Exploratória de Dados (EDA)

## Resumo Executivo das 5 Perguntas de Negócio

| # | Raw Finding (O número real) | Business Insight (Por que importa) | Ação Proposta |
|---|-----------------------------|-------------------------------------|---------------|
| **1** | O segmento High-Risk apresenta score médio de crédito significativamente inferior frente aos segmentos Standard e Premium. | Confirma que o credit score é uma variável discriminante direta para a exposição ao risco de sinistro. | Estabelecer tetos operacionais reduzidos e autenticação de duplo fator mandatória para faixas de crédito mais baixas. |
| **2** | Determinados canais e operações remotas concentram a maior taxa percentual de fraude em relação a compras presenciais. | Operações sem validação física constituem o principal vetor de ataque com credenciais vazadas. | Implantar análise comportamental biométrica preventiva antes da liquidação em canais digitais. |
| **3** | Os dias 21 a 27 do mês concentram os maiores picos absolutos de transações fraudulentas. | Sazonalidade de fechamento: fraudadores exploram o aumento natural de volume financeiro para mascarar sinistros. | Escalar regras automáticas de monitoramento e capacidade operacional do time de risco na última dezena do mês. |
| **4** | Clientes com relacionamento maduro mantêm ticket médio estável com menor taxa de risco relativo. | A maturação do cliente na base reduz o risco operacional geral da carteira. | Reduzir a fricção de checagens repetitivas em contas antigas e priorizar o onboarding nos primeiros 90 dias. |
| **5** | Grupo seleto de clientes Premium concentra elevada frequência de compras aprovadas no período analisado. | Identificação de clientes fiéis com alto volume de gastos e histórico financeiro seguro. | Inserir a base qualificada em campanhas direcionadas de cross-sell e aumento de limite de crédito. |
