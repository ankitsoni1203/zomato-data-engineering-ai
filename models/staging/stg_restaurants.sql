select 
    id :: number as restaurant_id , 
    name as restaurant_name , 
    trim(COALESCE(regexp_substr(city,'[^,]+$'),city)) as city,
    try_to_decimal(NULLIF(rating,'--'),3,1) as rating,
    try_to_number(regexp_substr(rating_count,'[0-9]+')) as rating_count,
    try_to_number(regexp_substr(cost,'[0-9]')) as cost_for_two,
    cuisine,lic_no as lincense_no
from {{source('raw', 'restaurants')}} where try_to_number(id) is not null 