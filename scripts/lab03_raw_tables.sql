-- Lab 03: Criação de Tabelas Raw no Hive (External vs Managed)

CREATE EXTERNAL TABLE IF NOT EXISTS raw_customers (
  customer_id INT,
  name STRING,
  cpf STRING,
  email STRING,
  segment STRING,
  credit_score INT,
  created_at STRING
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/bigdata/raw/customers';

-- Demonstração de Managed Table e teste de ciclo de vida (DROP)
CREATE TABLE IF NOT EXISTS teste_managed (
  id INT,
  valor STRING
);

INSERT INTO teste_managed VALUES (1, 'teste_ciclo_de_vida');

DROP TABLE teste_managed;
