{% set coluna = api.Column(
    column='id',
    dtype='int',
)
 %}

 Coluna -> {{coluna}}

 Nome da coluna -> {{coluna.column}}
 Nome da coluna -> {{coluna.name}}
 Tipo de dato -> {{coluna.dtype}}
 Tipo de dato -> {{coluna.data_type}}
 Eh numérico -> {{coluna.is_numeric()}}
 Eh string -> {{coluna.is_string()}}