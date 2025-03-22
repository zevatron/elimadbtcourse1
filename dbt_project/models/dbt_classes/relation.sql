{% set rel1 = ref('stg_nation') %}

Database -> {{rel1.database}}
Object -> {{rel1.identifier}}
Schema -> {{rel1.schema}}

{# {%  %} #}