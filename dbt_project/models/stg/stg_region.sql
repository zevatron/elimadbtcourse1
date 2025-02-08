{# {{
  config(
    materialized = 'view',
    )
}} #}

select
    R_COMMENT       as region_key,
    R_NAME          as region_name,
    R_REGIONKEY     as region_comment
from {{ref('src_region')}}