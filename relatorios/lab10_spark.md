# Lab 10 — Queries Interativas e Processamento Analítico In-Memory

## 1. Equivalência: SQL vs DataFrame API
A execução comparativa entre a query em SQL padrão e a API de agregação tabular produziu exatamente os mesmos agregados analíticos por segmento (médias de score de crédito e volume transacionado). Ambas as abordagens foram processadas pelo mesmo otimizador colunar, gerando planos de execução idênticos.

## 2. Ganho de Performance com Armazenamento em Memória (Cache)
* **Execução Direta do Disco:** Realizou a leitura física do arquivo Parquet, exigindo operações de I/O de disco para descompressão e varredura colunar.
* **Execução em Memória (Cache):** Operou sobre os dados previamente mantidos em memória RAM, eliminando o gargalo de leitura física e acelerando consideravelmente o tempo de resposta da contagem de fraudes.

## 3. Distribuição Semanal de Fraudes
A agregação por `day_of_week` apontou distribuição homogênea no volume de transações ao longo da semana, permitindo identificar os turnos com maior frequência de sinistros.
