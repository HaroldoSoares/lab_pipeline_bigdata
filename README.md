# Pipeline Big Data — Hadoop, Sqoop & Hive

Repositório de entrega dos laboratórios práticos de Engenharia de Dados (Labs 02 ao 07).

## 📌 Escopo dos Laboratórios

* **Lab 02 — Ingestão com Apache Sqoop:** Extração das tabelas relacionais (`customers` e `transactions`) do MySQL diretamente para o HDFS em `/user/bigdata/raw/`.
* **Lab 03 — Tabelas Raw no Hive:** Mapeamento de tabelas externas desacopladas do HDFS e validação do ciclo de vida de tabelas gerenciadas (*Managed Tables*).
* **Lab 04 — Particionamento Dinâmico:** Implementação de particionamento por `year` e `month` com validação de *Partition Pruning*.
* **Lab 05 — Camada Bronze:** Sanitização de tipos, conversão para formato colunar Parquet e deduplicação estrita via janela analítica (`ROW_NUMBER()`).
* **Lab 06 — Camada Silver:** Enriquecimento dimensional via `MAPJOIN` (Broadcast Join) unindo transações e clientes com derivação de métricas temporais e faixas de valor.
* **Lab 07 — Camada Gold:** Agregações analíticas e consolidação de KPIs de risco de fraude por segmento e métricas diárias.

## 📁 Estrutura de Arquivos
* `scripts/`: Código-fonte DDL e DML de cada estágio do pipeline.
* `docs/`: Documentação e evidências de execução.
