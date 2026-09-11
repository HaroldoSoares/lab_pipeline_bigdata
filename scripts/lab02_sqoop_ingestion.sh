#!/bin/bash
# Lab 02: Ingestão MySQL -> HDFS via Apache Sqoop

sqoop import \
  --connect jdbc:mysql://localhost:3306/bigdata_db \
  --username root -P \
  --table customers \
  --target-dir /user/bigdata/raw/customers \
  --delete-target-dir \
  -m 1

sqoop import \
  --connect jdbc:mysql://localhost:3306/bigdata_db \
  --username root -P \
  --table transactions \
  --target-dir /user/bigdata/raw/transactions \
  --delete-target-dir \
  --split-by transaction_id \
  -m 4
