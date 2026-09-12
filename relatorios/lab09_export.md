# Lab 09 — Exportação da Camada Gold

## 1. Caminhos de Exportação Testados

* **Opção 1 (CSV Delimitado):** Extração direta do conjunto agregado via DuckDB para o arquivo `fraud_risk_export.csv`. Garante portabilidade universal e leitura direta em qualquer ferramenta tabular ou dashboard simples sem necessidade de drivers adicionais.
* **Opção 2 (SGBD Relacional / SQLite):** Carga dos dados agregados na tabela `fraud_risk_bi` dentro do banco `bi_db.sqlite`. Simula a ingestão relacional corporativa (equivalente ao Sqoop Export para MySQL na Rota A), permitindo conexão via drivers JDBC/ODBC padrão.

## 2. Decisão Arquitetural para o Lab 11 (Dashboard)

Para a construção do painel de BI (Lab 11), a rota prioritária adotada é o formato **CSV delimitado / SQLite local**:
* Elimina a dependência de serviços adicionais em segundo plano (como daemons MySQL).
* Oferece integração direta e sem atrito com o Metabase, DuckDB Web ou dashboards analíticos em Python (Streamlit/Seaborn).
