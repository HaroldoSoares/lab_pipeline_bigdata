#!/bin/bash
# Lab 01: Setup das Camadas Raw/Bronze/Silver/Gold e Simulacao de Replicacao HDFS
mkdir -p bigdata/raw/customers bigdata/raw/transactions bigdata/raw/fraud_labels
mkdir -p bigdata/bronze bigdata/silver bigdata/gold bigdata/_replica_demo

cp /home/yagor/customers_synthetic.csv bigdata/raw/customers/
cp /home/yagor/transactions_synthetic.csv bigdata/raw/transactions/

for i in 1 2 3; do
  cp bigdata/raw/transactions/transactions_synthetic.csv bigdata/_replica_demo/copia_$i.csv
done

echo "Lab 01 concluido: camadas criadas e arquivos posicionados."
