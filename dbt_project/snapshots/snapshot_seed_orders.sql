{# {% snapshot snapshot_seed_orders %}

{{
   config(
       target_database='demo_db_dbt',
       target_schema='snapshots',
       unique_key='order_id',

       strategy='timestamp',
       updated_at='last_updated',
   )
}}

select *
from {{ ref('seed_orders') }}

{% endsnapshot %} #}