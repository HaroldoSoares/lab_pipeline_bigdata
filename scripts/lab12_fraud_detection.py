"""
Lab 12: Modelo Preditivo de Detecção de Fraude (Regressão Logística)
Pipeline completo: feature encoding, split 80/20, treino, métrica AUC e interpretabilidade.
"""
import duckdb
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_auc_score
from sklearn.preprocessing import LabelEncoder

def train_fraud_model():
    con = duckdb.connect()
    df = con.sql("""
    SELECT transaction_id, amount, risk_score, credit_score, segment, is_fraud 
    FROM read_parquet('bigdata/silver/transactions_enriched.parquet')
    """).df()

    le = LabelEncoder()
    df['segment_idx'] = le.fit_transform(df['segment'])
    df['label'] = df['is_fraud'].astype(int)

    feature_cols = ['amount', 'risk_score', 'credit_score', 'segment_idx']
    X = df[feature_cols]
    y = df['label']

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )

    lr = LogisticRegression(max_iter=1000, random_state=42)
    lr.fit(X_train, y_train)

    y_prob = lr.predict_proba(X_test)[:, 1]
    auc = roc_auc_score(y_test, y_prob)

    print(f"Modelo finalizado. AUC: {auc:.4f}")
    for col, coef in zip(feature_cols, lr.coef_[0]):
        print(f"Feature: {col} | Coeficiente: {coef:.6f}")

if __name__ == '__main__':
    train_fraud_model()
