{%set var1 = api.Relation.create(database='DEMO_DB_DBT', schema='RAW', identifier='SRC_NATION')%}

select * from {{var1}}