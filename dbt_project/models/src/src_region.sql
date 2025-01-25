with src_region_cte as (
    select
        R_COMMENT,
        R_NAME,
        R_REGIONKEY
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.REGION
)

select * from src_region_cte