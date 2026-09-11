-- Lab 06: Camada Silver com Enriquecimento e Otimização MapJoin

CREATE TABLE IF NOT EXISTS silver_transactions (
  transaction_id INT,
  customer_id INT,
  amount FLOAT,
  transaction_type STRING,
  status STRING,
  risk_score FLOAT,
  is_fraud BOOLEAN,
  ts TIMESTAMP,
  segment STRING,
  credit_score INT,
  year INT,
  month INT,
  day INT,
  day_of_week INT,
  amount_band STRING
)
STORED AS PARQUET;

INSERT OVERWRITE TABLE silver_transactions
SELECT /*+ MAPJOIN(c) */
  t.transaction_id,
  t.customer_id,
  t.amount,
  t.transaction_type,
  t.status,
  t.risk_score,
  t.is_fraud,
  t.ts,
  c.segment,
  c.credit_score,
  YEAR(t.ts)  AS year,
  MONTH(t.ts) AS month,
  DAY(t.ts)   AS day,
  DAYOFWEEK(t.ts) AS day_of_week,
  CASE
    WHEN t.amount < 100  THEN 'baixo'
    WHEN t.amount < 1000 THEN 'medio'
    ELSE 'alto'
  END AS amount_band
FROM bronze_transactions t
JOIN bronze_customers c ON t.customer_id = c.customer_id;
