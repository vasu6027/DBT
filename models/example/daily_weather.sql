with daily_weather AS (

SELECT

date(time) as daily_weather,
weather,
temp,
pressure,
humidity,
clouds

FROM {{ source('demo', 'weather') }} 



),

daily_weather_agg as (

select daily_weather,
weather,
count(weather),
round(AVG(temp), 2) AS AVG_TEMP,
round(AVG(pressure), 2) AS AVG_PRESSURE,
round(AVG(humidity), 2) AS AVG_HUMIDITY,
round(AVG(clouds), 2) AS AVG_CLOUDS

from daily_weather

group by daily_weather, weather

qualify ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY COUNT(WEATHER) DESC) = 1

)

SELECT * FROM daily_weather_agg