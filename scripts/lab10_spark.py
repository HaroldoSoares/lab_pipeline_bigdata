"""
Lab 10: Processamento Analítico com Queries Interativas
Compara operações SQL vs DataFrame API e afere ganho de latência in-memory
"""
import time
import duckdb

def run_analytics_lab():
    con = duckdb.connect()
    parquet_path = "bigdata/silver/transactions_enriched.parquet"
    con.sql(f"CREATE TABLE silver_transactions AS SELECT * FROM read_parquet('{parquet_path}')")

    # 1. SQL vs DataFrame API
    print("--- SQL ---")
    con.sql("""
    SELECT segment, ROUND(AVG(credit_score), 1) AS score_medio, COUNT(*) AS total
    FROM silver_transactions
    GROUP BY segment
    ORDER BY score_medio
    """).show()

    print("--- DataFrame API ---")
    con.table("silver_transactions") \
       .aggregate("segment, ROUND(AVG(credit_score), 1) AS score_medio, COUNT(*) AS total") \
       .order("score_medio") \
       .show()

    # 2. Avaliação de Desempenho / Cache
    t0 = time.time()
    c1 = con.sql(f"SELECT COUNT(*) FROM read_parquet('{parquet_path}') WHERE is_fraud = true").fetchone()[0]
    t_disco = time.time() - t0

    t0 = time.time()
    c2 = con.sql("SELECT COUNT(*) FROM silver_transactions WHERE is_fraud = true").fetchone()[0]
    t_mem = time.time() - t0

    print(f"Sem Cache (Disco): {t_disco:.5f}s | Com Cache (RAM): {t_mem:.5f}s")

    # 3. Análise por Dia da Semana
    con.sql("""
    SELECT day_of_week AS dia_semana,
           COUNT(*) AS total,
           SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraudes
    FROM silver_transactions
    GROUP BY day_of_week
    ORDER BY dia_semana
    """).show()

if __name__ == "__main__":
    run_analytics_lab()
