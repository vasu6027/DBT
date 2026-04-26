with BIKE as (

SELECT 
Distinct
start_station_id as station_id,
start_station_name as station_name,
start_lat as station_lat,
start_lng as station_lng

FROM {{ source('demo', 'bike') }}
where RIDE_ID != 'ride_id'



)

SELECT 
*
FROM BIKE