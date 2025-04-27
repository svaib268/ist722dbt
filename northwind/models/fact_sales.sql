with stg_order_details as (
    select
        od.orderid,
        {{ dbt_utils.generate_surrogate_key(['p.productid']) }} as productkey,
        {{ dbt_utils.generate_surrogate_key(['s.supplierid']) }} as supplierkey,
        {{ dbt_utils.generate_surrogate_key(['c.customerid']) }} as customerkey,
        replace(to_date(o.orderdate)::varchar,'-','')::int as orderdatekey,
        od.quantity,
        od.unitprice,
        od.discount,
        (od.quantity * od.unitprice * (1 - od.discount)) as salesamount
    from {{ source('northwind','Order_Details') }} od
    join {{ source('northwind','Orders') }} o on od.orderid = o.orderid
    join {{ source('northwind','Products') }} p on od.productid = p.productid
    join {{ source('northwind','Suppliers') }} s on p.supplierid = s.supplierid
    join {{ source('northwind','Customers') }} c on o.customerid = c.customerid
)

select * from stg_order_details
