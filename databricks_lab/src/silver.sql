-- Databricks notebook source
-- La primera línea hace que Databricks lo trate como notebook SQL.
-- Silver: reconstruye válidos y rechazos desde bronze (reproceso completo).

USE CATALOG IDENTIFIER(:catalog);

CREATE OR REPLACE TABLE silver.transactions AS
SELECT * FROM silver.transactions_parsed
WHERE amount IS NOT NULL AND txn_ts IS NOT NULL;

-- COMMAND ----------
-- Rechazos, con el motivo de cada uno

CREATE OR REPLACE TABLE silver.transactions_rejected AS
SELECT *,
    CASE WHEN amount is NULL THEN "invalid_amount" ELSE "invalid_timestamp" END AS reject_reason
FROM silver.transactions_parsed
WHERE amount is NULL or txn_ts IS NULL;