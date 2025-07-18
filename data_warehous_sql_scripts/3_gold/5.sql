
--Checking Duplicate Values
SELECT
  fl_date,
  dep_hour,
  mkt_unique_carrier,
  mkt_carrier_fl_num,
  op_unique_carrier,
  op_carrier_fl_num,
  tail_num,
  origin,
  dest,
  dep_time,
  crs_dep_time,
  taxi_out,
  dep_delay,
  air_time,
  distance,
  cancelled,
  wind_dir,
  wind_spd,
  wind_gust,
  visibility,
  temperature,
  dew_point,
  rel_humidity,
  altimeter,
  lowest_cloud_layer,
  n_cloud_layer,
  low_level_cloud,
  mid_level_cloud,
  high_level_cloud,
  cloud_cover,
  active_weather,
  COUNT(*)
FROM bronze.complete_data
GROUP BY 
  fl_date,
  dep_hour,
  mkt_unique_carrier,
  mkt_carrier_fl_num,
  op_unique_carrier,
  op_carrier_fl_num,
  tail_num,
  origin,
  dest,
  dep_time,
  crs_dep_time,
  taxi_out,
  dep_delay,
  air_time,
  distance,
  cancelled,
  wind_dir,
  wind_spd,
  wind_gust,
  visibility,
  temperature,
  dew_point,
  rel_humidity,
  altimeter,
  lowest_cloud_layer,
  n_cloud_layer,
  low_level_cloud,
  mid_level_cloud,
  high_level_cloud,
  cloud_cover,
  active_weather 
 HAVING
 COUNT(*)>1;



--Creating airlines fact table
SELECT
  DENSE_RANK() OVER (
    ORDER BY fl_date, dep_hour, mkt_unique_carrier, mkt_carrier_fl_num, origin, dest
  ) AS flight_id,
  fl_date,
  dep_hour,
  mkt_unique_carrier,
  mkt_carrier_fl_num,
  op_unique_carrier,
  op_carrier_fl_num,
  tail_num,
  origin,
  dest,
  dep_time,
  crs_dep_time,
  taxi_out,
  dep_delay,
  air_time,
  distance,
  cancelled,
  wind_dir,
  wind_spd,
  wind_gust,
  visibility,
  temperature,
  dew_point,
  rel_humidity,
  altimeter,
  lowest_cloud_layer,
  n_cloud_layer,
  low_level_cloud,
  mid_level_cloud,
  high_level_cloud,
  cloud_cover,
  active_weather
FROM bronze.complete_data;

--Checking duplicated values after new table creation
SELECT flight_id, COUNT(*) FROM silver.complete_data GROUP BY flight_id HAVING COUNT(*)>1;


--Creating date dimension table for the year 2022
SELECT
	datum as Date,
	extract(year from datum) AS Year,
	extract(month from datum) AS Month,
	to_char(datum, 'TMMonth') AS Month_Name,
	extract(day from datum) AS Day,
	extract(doy from datum) AS Day_of_Year,
	to_char(datum, 'TMDay') AS Weekday_Name,
	extract(week from datum) AS Calendar_Week,
	to_char(datum, 'dd. mm. yyyy') AS FormattedD_ate,
	'Q' || to_char(datum, 'Q') AS Quartal,
	to_char(datum, 'yyyy/"Q"Q') AS Year_Quartal,
	to_char(datum, 'yyyy/mm') AS Year_Month,
	to_char(datum, 'iyyy/IW') AS Year_Calendar_Week,
	CASE WHEN extract(isodow from datum) in (6, 7) THEN 'Weekend' ELSE 'Weekday' END AS Weekend,
        CASE WHEN to_char(datum, 'MMDD') IN ('0101', '0704', '1225', '1226')
		THEN 'Holiday' ELSE 'No holiday' END
		AS American_Holiday,
	datum + (1 - extract(isodow from datum))::integer AS CWStart,
	datum + (7 - extract(isodow from datum))::integer AS CWEnd,
	datum + (1 - extract(day from datum))::integer AS Month_Start,
	(datum + (1 - extract(day from datum))::integer + '1 month'::interval)::date - '1 day'::interval AS Month_End
FROM (
	SELECT '2022-01-01'::DATE + sequence.day AS datum
	FROM generate_series(0,364) AS sequence(day)
	GROUP BY sequence.day
     ) DQ
order by 1;

--Creating airport dimension table
SELECT 
  airport_id,
  airport,
  display_airport_name,
  split_part(display_airport_city, ',', 1) AS airport_city,
  airport_state_name,
  airport_state_code,
  lattitude,
  longitude,
  elevation,
  icao,
  iata,
  faa,
  mesonet_station
FROM
  bronze.stations;

--Creating aircraft dimension table
SELECT
  tail_num,
  year_of_manufacture,
  manufacturer,
  icao_type,
  ac_range,
  width
FROM bronze.complete_data;


--Creating active weather dimension table
SELECT * FROM bronze.active_weather;


--Creating cancellation dimension table
SELECT * FROM bronze.cancellation;

--Creating carriers dimension table
SELECT * FROM bronze.carriers;

