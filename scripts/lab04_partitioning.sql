-- Lab 04: Otimização com Tabela Particionada (Year/Month)

CREATE EXTERNAL TABLE IF NOT EXISTS raw_transactions (
  transaction_id INT,
  customer_id INT,
  transaction_type STRING,
  amount FLOAT,
  status STRING,
  ts STRING,
  risk_score FLOAT,
  is_fraud BOOLEAN
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/bigdata/raw/transactions';

CREATE TABLE IF NOT EXISTS transactions_particionada (
  transaction_id INT,
  customer_id INT,
  transaction_type STRING,
  amount FLOAT,
  status STRING,
  risk_score FLOAT,
  is_fraud BOOLEAN
)
PARTITIONED BY (year INT, month INT)
STORED AS TEXTFILE;

SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;

INSERT OVERWRITE TABLE transactions_particionada PARTITION(year, month)
SELECT 
  transaction_id,
  customer_id,
  transaction_type,
  amount,
  status,
  risk_score,
  is_fraud,
  YEAR(ts) AS year,
  MONTH(ts) AS month
FROM raw_transactions;
