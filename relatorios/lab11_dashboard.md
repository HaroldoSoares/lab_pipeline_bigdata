# Lab 11 — Dashboard Executivo de Risco

## Arquitetura Visual e Anatomia do Painel

O painel foi construído no padrão de 4 blocos analíticos complementares:

* **1. Volume Global (KPI Superior Esquerdo):** Exibe o total acumulado de transações processadas, permitindo dimensionar a escala da operação de pagamentos.
* **2. Risco Sistêmico (KPI Superior Direito):** Mostra a taxa global de sinistralidade (~1,83%), servindo como linha de base (baseline) para avaliar desvios operacionais.
* **3. Composição de Risco por Segmento (Gráfico de Barras Inferior Esquerdo):** Destaca visualmente a disparidade de risco, evidenciando o segmento **High-Risk (~7,7%)** com taxa quase dez vezes superior à do segmento **Premium (~0,77%)**.
* **4. Detalhamento Tabular (Tabela Inferior Direita):** Disponibiliza os valores monetários absolutos, tíquete médio e o valor financeiro total em risco para subsidiar auditorias financeiras e provisões de perdas.

## Rota de Visualização
Implementado via biblioteca Plotly (HTML standalone autônomo), garantindo portabilidade para abertura em qualquer navegador sem dependência de contêineres Docker ou servidores externos.
