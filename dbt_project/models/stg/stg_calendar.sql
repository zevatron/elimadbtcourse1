select 
    day,
    month,
    year
from {{ ref('calendar') }}