select
    employee_id,
    customer_id,
    email
from {{ ref('stg_jaffle_shop__employees') }}