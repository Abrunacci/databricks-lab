-- Gold: movimiento neto diario por cuenta, construido desde silver.
-- source() le dice a dbt de dónde viene; dbt lo traduce a databricks_lab.silver.transactions
select
    concat(account_id, '|', cast(to_date(txn_ts) as string))           as account_day_key, -- clave del grain
    account_id,
    to_date(txn_ts)                                                    as txn_date,
    cast(sum(case when amount > 0 then amount else 0 end) as decimal(18,2))  as total_in,
    cast(sum(case when amount < 0 then -amount else 0 end) as decimal(18,2)) as total_out,
    cast(sum(amount) as decimal(18,2))                                 as net_amount,
    cast(count(*) as int)                                              as txn_count
from {{ source('silver', 'transactions') }}
group by account_id, to_date(txn_ts)