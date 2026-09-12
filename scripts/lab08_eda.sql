-- Lab 08: Análise Exploratória de Dados (EDA) — 5 Perguntas de Negócio

-- 1. Segmentação por Score
SELECT segment,
       ROUND(AVG(credit_score), 1) AS score_medio,
       COUNT(DISTINCT customer_id) AS clientes
FROM silver_transactions
GROUP BY segment
ORDER BY score_medio;

-- 2. Análise de Risco por Tipo de Transação
SELECT transaction_type,
       SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraudes,
       COUNT(*) AS total,
       ROUND(100.0 * CAST(SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS DOUBLE) / COUNT(*), 2) AS taxa_pct
FROM silver_transactions
GROUP BY transaction_type
ORDER BY taxa_pct DESC;

-- 3. Padrões Temporais (Concentração por Dia)
SELECT day,
       COUNT(*) AS total_transacoes,
       SUM(CASE WHEN is_fraud THEN 1 ELSE 0 END) AS fraudes
FROM silver_transactions
GROUP BY day
ORDER BY fraudes DESC
LIMIT 10;

-- 4. Cohort — Clientes Antigos vs Novos (Join com Bronze Customers)
SELECT
  CASE WHEN DATEDIFF('day', c.created_at, CURRENT_DATE) > 365 THEN 'cliente antigo'
       ELSE 'cliente novo' END AS cohort,
  ROUND(AVG(t.amount), 2) AS ticket_medio,
  COUNT(*) AS transacoes
FROM silver_transactions t
JOIN bronze_customers c ON t.customer_id = c.customer_id
GROUP BY 1;

-- 5. Cross-sell — Clientes Premium de Alta Frequência em Compras
SELECT customer_id, COUNT(*) AS compras
FROM silver_transactions
WHERE segment = 'Premium' AND transaction_type = 'compra'
GROUP BY customer_id
HAVING COUNT(*) > 10
ORDER BY compras DESC
LIMIT 10;
