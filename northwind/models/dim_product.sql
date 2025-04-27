select
    {{ dbt_utils.generate_surrogate_key(['productid']) }} as productkey,
    productid,
    productname,
    supplierid,
    categoryid,
    quantityperunit,
    unitprice,
    unitsinstock,
    unitsonorder,
    reorderlevel,
    discontinued
from {{ source('northwind', 'Products') }}
