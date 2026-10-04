-- Databricks notebook source
-- La primera línea hace que Databricks lo trate como notebook SQL.
-- Silver: reconstruye válidos y rechazos desde bronze (reproceso completo).
CREATE TABLE IF NOT EXISTS databricks_lab.gold.daily_account_summary (
  account_id  STRING        COMMENT 'Account identifier',
  txn_date    DATE          COMMENT 'Transaction date',
  total_in    DECIMAL(18,2) COMMENT 'Sum of positive amounts',
  total_out   DECIMAL(18,2) COMMENT 'Sum of negative amounts, as positive',
  net_amount  DECIMAL(18,2) COMMENT 'total_in - total_out',
  txn_count   INT           COMMENT 'Number of transactions'
) COMMENT 'One row per account and day';


INSERT OVERWRITE databricks_lab.gold.daily_account_summary
SELECT
    account_id,
    to_date(txn_ts),
    sum(CASE WHEN amount > 0 THEN amount ELSE 0 END),
    sum(CASE WHEN amount < 0 THEN -amount ELSE 0 END),
    sum(amount),
    count(*)
FROM databricks_lab.silver.transactions
GROUP BY account_id, to_date(txn_ts);
