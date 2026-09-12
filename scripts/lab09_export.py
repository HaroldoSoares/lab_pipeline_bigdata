"""
Lab 09: Exportação da Camada Gold para Servir BI
Testa exportação para CSV e SQLite simulando ambiente sem admin.
"""
import duckdb
import sqlite3
import os

def export_gold_layer():
    con = duckdb.connect()
    
    # Carrega Silver e consolida Gold
    con.sql("CREATE TABLE silver_transactions AS SELECT * FROM read_parquet('bigdata/silver/transactions_enriched.parquet')")
    con.sql("""
    CREATE TABLE gold_fraud_risk AS
    SELECT
      segment,
      COUNT(*) AS total_transacoes,
      ROUND(SUM(amount), 2) AS valor_total,
      ROUND(AVG(amount), 2) AS ticket_medio,
      SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS qtd_fraudes,
      ROUND(100.0 * CAST(SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS DOUBLE) / COUNT(*), 2) AS taxa_fraude_pct,
      ROUND(SUM(CASE WHEN is_fraud THEN amount ELSE 0 END), 2) AS valor_em_risco
    FROM silver_transactions
    GROUP BY segment
    """)
    
    # Opção 1: CSV Delimitado
    con.sql("COPY gold_fraud_risk TO 'scripts/fraud_risk_export.csv' (HEADER, DELIMITER ',')")
    
    # Opção 2: Banco Relacional SQLite
    df = con.sql("SELECT * FROM gold_fraud_risk").df()
    conn = sqlite3.connect('scripts/bi_db.sqlite')
    df.to_sql('fraud_risk_bi', conn, if_exists='replace', index=False)
    conn.close()
    
    print("Exportações concluídas com sucesso!")

if __name__ == '__main__':
    export_gold_layer()
