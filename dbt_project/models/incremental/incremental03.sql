{{
    config(
        materialized = 'incremental',
        unique_key = 'order_id',
        merge_updated_cols = ['order_status','order_quantity','last_updated']
    )
}}

select * from {{ ref('seed_orders') }}
{% if is_incremental() %}
  where last_updated >= (select max(last_updated) from {{ this }})
{% endif %}