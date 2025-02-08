select
    R_COMMENT,
    R_NAME,
    R_REGIONKEY
from {{ source('SNOWFLAKE_SOURCE', 'region') }}