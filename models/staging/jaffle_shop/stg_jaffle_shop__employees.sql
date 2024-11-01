select
    employee_id,
    customer_id,
    email
from {{ source('jaffle_shop', 'employees') }}