select O_COMMENT
from {{ ref('src_orders') }}
where O_COMMENT is null
limit 1