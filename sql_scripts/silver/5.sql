
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


SELECT
  tail_num,
  year_of_manufacture,
  manufacturer,
  icao_type,
  ac_range,
  width
FROM bronze.complete_data;

