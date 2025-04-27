select
    {{ dbt_utils.generate_surrogate_key(['supplierid']) }} as supplierkey,
    supplierid,
    companyname,
    contactname,
    address,
    city,
    country
from {{ source('northwind', 'Suppliers') }}
