-- Databricks notebook source

USE CATALOG IDENTIFIER(:catalog);

CREATE OR REPLACE VIEW silver.transactions_parsed AS
SELECT
  raw_payload:txn_id::string                             AS txn_id,
  raw_payload:account::string                            AS account_id,
  try_cast(raw_payload:amount::string AS DECIMAL(18,2))  AS amount,
  upper(raw_payload:currency::string)                    AS currency,  -- "usd" -> "USD"
  try_cast(raw_payload:ts::string AS TIMESTAMP)          AS txn_ts,
  _source_file,
  _ingested_at
FROM bronze.transactions_raw;