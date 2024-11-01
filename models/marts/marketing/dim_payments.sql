select
    payment_id,
    order_id,
    payment_method,
    status,
    amount
from {{ ref('stg_stripe__payments') }}