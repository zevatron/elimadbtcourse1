{% set relation01 = adapter.get_relation(
    database = 'demo_db_dbt',
    schema = 'raw',
    identifier = 'src_nation'
)
 %}

 {%
    set colunas = adapter.get_columns_in_relation(relation01)
 %}

 select
 {% for coluna in colunas  %}
    {{coluna.quoted}} {% if not loop.last %},{% endif %}
{%endfor%}
from {{relation01}}