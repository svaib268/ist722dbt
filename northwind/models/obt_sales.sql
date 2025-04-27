with f_sales as (
    select * from {{ ref('fact_sales') }}
),
d_product as (
    select * from {{ ref('dim_product') }}
),
d_customer as (
    select * from {{ ref('dim_customer') }}
),
d_supplier as (
    select * from {{ ref('dim_supplier') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
)

select
    f.orderid,
    f.salesamount,
    f.quantity,
    p.productname,
    s.companyname as suppliername,
    c.contactname as customername,
    d.date as orderdate
from f_sales f
left join d_product p on f.productkey = p.productkey
left join d_customer c on f.customerkey = c.customerkey
left join d_supplier s on f.supplierkey = s.supplierkey
left join d_date d on f.orderdatekey = d.datekey
