# Pipeline Big Data — Hadoop, Sqoop, Hive, Spark & ML

Repositório de entrega dos laboratórios práticos de Engenharia e Análise de Dados (Labs 02 ao 12).

## 📌 Escopo dos Laboratórios

* **Lab 02 — Ingestão com Apache Sqoop:** Extração das tabelas relacionais (`customers` e `transactions`) do MySQL diretamente para o HDFS em `/user/bigdata/raw/`.
* **Lab 03 — Tabelas Raw no Hive:** Mapeamento de tabelas externas desacopladas do HDFS e validação do ciclo de vida de tabelas gerenciadas (*Managed Tables*).
* **Lab 04 — Particionamento Dinâmico:** Implementação de particionamento por `year` e `month` com validação de *Partition Pruning*.
* **Lab 05 — Camada Bronze:** Sanitização de tipos, conversão para formato colunar Parquet e deduplicação estrita via janela analítica (`ROW_NUMBER()`).
* **Lab 06 — Camada Silver:** Enriquecimento dimensional via `MAPJOIN` (*Broadcast Join*) unindo transações e clientes com derivação de métricas temporais e faixas de valor.
* **Lab 07 — Camada Gold:** Agregações analíticas e consolidação de KPIs de risco de fraude por segmento e métricas diárias.
* **Lab 08 — Análise Exploratória (EDA):** Resposta a 5 perguntas estratégicas de negócio sobre a camada Silver e estruturação do framework *Finding → Insight → Ação*.
* **Lab 09 — Exportação da Camada Gold:** Extração da tabela analítica para consumo de BI via arquivo delimitado (`CSV`) e banco relacional desacoplado (`SQLite`).
* **Lab 10 — Processamento Analítico In-Memory:** Execução de consultas interativas, avaliação de equivalência entre SQL e DataFrame API e mensuração de ganho de desempenho via cache em memória.
* **Lab 11 — Visualização Executiva & Dashboard:** Construção de painel analítico com 4 quadrantes (KPIs de volume/taxa geral, composição de risco por segmento e tabela de detalhe) com saídas em HTML interativo (`Plotly`) e captura estática em `PNG`.
* **Lab 12 — Machine Learning Preview:** Treinamento de modelo preditivo supervisionado de Regressão Logística para detecção de fraude, com validação de métricas de discriminação (`AUC-ROC = 0.6526`) e interpretabilidade de coeficientes (*Feature Importance*).

## 📁 Estrutura de Arquivos

* `scripts/`: Código-fonte DDL, DML, scripts Python e arquivos de exportação analítica.
* `relatorios/`: Documentação executiva de negócio de cada laboratório, painéis e capturas do dashboard.
* `bigdata/`: Estrutura local das camadas do modelo Medallion (`bronze/`, `silver/`, `gold/`).
