-- Lab 07: Camada Gold com Agregações de Negócio e Métricas de Fraude

CREATE TABLE IF NOT EXISTS gold_fraud_risk (
  segment STRING,
  total_transacoes BIGINT,
  valor_total DOUBLE,
  ticket_medio DOUBLE,
  qtd_fraudes BIGINT,
  taxa_fraude_pct DOUBLE,
  valor_em_risco DOUBLE
)
STORED AS PARQUET;

INSERT OVERWRITE TABLE gold_fraud_risk
SELECT
  segment,
  COUNT(*) AS total_transacoes,
  SUM(amount) AS valor_total,
  ROUND(AVG(amount), 2) AS ticket_medio,
  SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS qtd_fraudes,
  ROUND(100.0 * SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) / COUNT(*), 2) AS taxa_fraude_pct,
  SUM(CASE WHEN is_fraud THEN amount ELSE 0 END) AS valor_em_risco
FROM silver_transactions
GROUP BY segment;

CREATE TABLE IF NOT EXISTS gold_daily_metrics (
  year INT,
  month INT,
  day INT,
  transacoes BIGINT,
  fraudes BIGINT
)
STORED AS PARQUET;

INSERT OVERWRITE TABLE gold_daily_metrics
SELECT
  year,
  month,
  day,
  COUNT(*) AS transacoes,
  SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraudes
FROM silver_transactions
GROUP BY year, month, day;
