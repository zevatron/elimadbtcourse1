with src_orders_cte as (
    select
        O_ORDERKEY,
        O_CUSTKEY,
        O_ORDERSTATUS,
        O_TOTALPRICE,
        O_ORDERDATE,
        O_ORDERPRIORITY,
        O_CLERK,
        O_SHIPPRIORITY,
        O_COMMENT
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
)

select * from src_orders_cte