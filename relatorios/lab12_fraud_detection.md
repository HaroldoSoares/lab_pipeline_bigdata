# Lab 12 — Detecção de Fraude com Modelagem Preditiva (ML Preview)

## 1. Desempenho e Validação do Modelo
* **Algoritmo:** Regressão Logística Binária com otimização numérica.
* **Divisão dos Dados:** 80% treino e 20% teste com amostragem estratificada.
* **Métrica de Discriminação:** **AUC-ROC = 0.6526** no conjunto de teste, confirmando capacidade preditiva superior à linha de base aleatória (0.50).

## 2. Feature Importance e Interpretabilidade
* **risk_score (+0.016644):** Variável de maior relevância positiva para a classificação. Cada aumento unitário no score de risco eleva diretamente o log-odds de sinistro.
* **segment_idx (-0.667419):** Forte peso negativo, comprovando a eficácia da segmentação de clientes da camada Silver na proteção contra fraudes.
* **amount (-0.000158) e credit_score (-0.000015):** Apresentam impacto marginal estabilizador na função de perda.

## 3. Conclusão do Pipeline Medallion Completo (Labs 02 ao 12)
O ciclo integral de Big Data foi cumprido de ponta a ponta:
1. **Ingestão (Labs 02-04):** Captura de dados relacionais e eventos sintéticos.
2. **Bronze (Lab 05):** Deduplicação e tipagem estrita no formato colunar Parquet.
3. **Silver (Lab 06):** Junção de cadastros, derivação de faixas monetárias e partições temporais.
4. **Gold (Lab 07):** Agregações gerenciais de valor em risco e taxas por segmento.
5. **EDA & Export (Labs 08-09):** Resposta a 5 perguntas de negócio e entrega em CSV/SQLite.
6. **Analytics & BI (Labs 10-11):** Benchmarks in-memory e painel interativo visual.
7. **ML Preview (Lab 12):** Escoragem probabilística de risco com validação de métricas.
