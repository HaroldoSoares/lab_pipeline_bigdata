-- Lab 05: Camada Bronze em Parquet com Deduplicação via ROW_NUMBER()

CREATE TABLE IF NOT EXISTS bronze_customers (
  customer_id INT,
  name STRING,
  cpf STRING,
  email STRING,
  segment STRING,
  credit_score INT,
  created_at DATE
)
STORED AS PARQUET;

INSERT OVERWRITE TABLE bronze_customers
SELECT DISTINCT
  customer_id,
  name,
  cpf,
  email,
  segment,
  CAST(credit_score AS INT) AS credit_score,
  CAST(created_at AS DATE) AS created_at
FROM raw_customers
WHERE customer_id IS NOT NULL;

CREATE TABLE IF NOT EXISTS bronze_transactions (
  transaction_id INT,
  customer_id INT,
  transaction_type STRING,
  amount FLOAT,
  status STRING,
  risk_score FLOAT,
  is_fraud BOOLEAN,
  ts TIMESTAMP
)
STORED AS PARQUET;

INSERT OVERWRITE TABLE bronze_transactions
SELECT 
  transaction_id,
  customer_id,
  transaction_type,
  amount,
  status,
  risk_score,
  is_fraud,
  ts
FROM (
  SELECT 
    transaction_id,
    customer_id,
    transaction_type,
    CAST(amount AS FLOAT) AS amount,
    status,
    CAST(risk_score AS FLOAT) AS risk_score,
    CAST(is_fraud AS BOOLEAN) AS is_fraud,
    CAST(ts AS TIMESTAMP) AS ts,
    ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY CAST(ts AS TIMESTAMP) DESC) AS rn
  FROM raw_transactions
  WHERE amount > 0 AND customer_id IS NOT NULL
) sub
WHERE rn = 1;
