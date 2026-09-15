# Lab 12 — Detecção de Fraude com Modelagem Preditiva (ML Preview)

## 1. Visão Geral da Modelagem
* **Algoritmo:** Regressão Logística Binária com vetorização de features numéricas e categóricas.
* **Features Empregadas:** `amount`, `risk_score`, `credit_score` e `segment_idx`.
* **Divisão dos Dados:** 80% treino e 20% teste com estratificação de classe.

## 2. Métricas de Performance e Interpretabilidade
* **AUC-ROC no Teste:** Apresentou excelente poder de discriminação entre operações legítimas e fraudulentas, superando com folga o classificador aleatório (0.5).
* **Interpretação dos Coeficientes (Feature Importance):**
  * `risk_score`: Coeficiente positivo e de maior magnitude, demonstrando que o score de risco prévio é o preditor com maior peso direto para acionar o alerta de fraude.
  * `credit_score`: Coeficiente negativo, indicando que quanto maior o score creditício do cliente, menor a probabilidade estatística de fraude.
  * `amount`: Coeficiente positivo, capturando a tendência de golpes focarem em valores monetários mais elevados.

## 3. Conclusão do Ciclo de Engenharia de Dados (Labs 02 a 12)
O ciclo completo do pipeline de Big Data foi concluído com sucesso:
1. **Ingestão:** Ingestão de bases transacionais relacionais e cadastrais.
2. **Bronze:** Padronização estrutural e saneamento de tipos.
3. **Silver:** Enriquecimento com partições temporais, faixas de valor e junção de entidades.
4. **Gold:** Agregações de negócio para cálculo de risco financeiro e métricas diárias.
5. **Serviço & BI:** Exportação analítica em CSV/SQLite e dashboard executivo.
6. **Machine Learning:** Modelo treinado e avaliado para escoragem em tempo de inferência.
