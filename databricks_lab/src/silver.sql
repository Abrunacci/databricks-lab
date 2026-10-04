-- Databricks notebook source
-- La primera línea hace que Databricks lo trate como notebook SQL.
-- Silver: reconstruye válidos y rechazos desde bronze (reproceso completo).

CREATE OR REPLACE TABLE databricks_lab.silver.transactions AS
SELECT * FROM databricks_lab.silver.transactions_parsed
WHERE amount IS NOT NULL AND txn_ts IS NOT NULL;

-- COMMAND ----------
-- Rechazos, con el motivo de cada uno

CREATE OR REPLACE TABLE databricks_lab.silver.transactions_rejected AS
SELECT *,
    CASE WHEN amount is NULL THEN "invalid_amount" ELSE "invalid_timestamp" END AS reject_reason
FROM databricks_lab.silver.transactions_parsed
WHERE amount is NULL or txn_ts IS NULL;