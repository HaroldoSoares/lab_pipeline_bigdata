-- Lab 07: Camada Gold com Agregações de Negócio e Métricas de Fraude (Corrigido)

DROP TABLE IF EXISTS gold_fraud_risk;

CREATE TABLE gold_fraud_risk
STORED AS PARQUET AS
SELECT
  segment,
  COUNT(*) AS total_transacoes,
  ROUND(SUM(amount), 2) AS valor_total,
  ROUND(AVG(amount), 2) AS ticket_medio,
  SUM(CASE WHEN is_fraud = true OR is_fraud = 'True' THEN 1 ELSE 0 END) AS qtd_fraudes,
  ROUND(100.0 * CAST(SUM(CASE WHEN is_fraud = true OR is_fraud = 'True' THEN 1 ELSE 0 END) AS DOUBLE) / COUNT(*), 2) AS taxa_fraude_pct,
  ROUND(SUM(CASE WHEN is_fraud = true OR is_fraud = 'True' THEN amount ELSE 0 END), 2) AS valor_em_risco
FROM silver_transactions
GROUP BY segment;

DROP TABLE IF EXISTS gold_daily_metrics;

CREATE TABLE gold_daily_metrics
STORED AS PARQUET AS
SELECT
  year,
  month,
  day,
  COUNT(*) AS transacoes,
  SUM(CASE WHEN is_fraud = true OR is_fraud = 'True' THEN 1 ELSE 0 END) AS fraudes
FROM silver_transactions
GROUP BY year, month, day;

SELECT * FROM gold_fraud_risk ORDER BY taxa_fraude_pct DESC;

SELECT year, month, day, fraudes
FROM gold_daily_metrics
ORDER BY fraudes DESC
LIMIT 5;
