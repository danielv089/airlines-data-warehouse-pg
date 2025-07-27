-- ========================================
-- Script: ddl_loading_gold_layer_tables.sql
-- Purpose: Loading data into gold layer tables
-- Author: Daniel Varga
-- Created: 2025-07-24
-- Modified: 2025-07-26
-- ========================================

-- Load date dimension table (dim_date)
-- Generates a calendar for the year 2022
INSERT INTO gold.dim_date (
    date_key,
    date,
    year,
    month,
    month_name,
    day,
    day_of_year,
    weekday_name,
    calendar_week,
    formatted_date,
    quartal,
    year_quartal,
    year_month,
    year_calendar_week,
    weekend,
    american_holiday,
    calendar_week_start,
    calendar_week_end,
    month_start,
    month_end
)
SELECT
    TO_CHAR(datum, 'YYYYMMDD')::INTEGER AS date_key,
	datum as Date,
	extract(year from datum) AS Year,
	extract(month from datum) AS Month,
	to_char(datum, 'TMMonth') AS Month_Name,
	extract(day from datum) AS Day,
	extract(doy from datum) AS Day_of_Year,
	to_char(datum, 'TMDay') AS Weekday_Name,
	extract(week from datum) AS Calendar_Week,
	to_char(datum, 'dd. mm. yyyy') AS Formatted_Date,
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

-- Load cancellation data table into gold.dim_cancellation
INSERT INTO gold.dim_cancellation(
    status_code, 
    cancellation_reason
)
SELECT
    status_code,
    cancellation_reason
FROM
    silver.cancellation;

-- Load carrier codes and names into gold.dim_carriers
-- Note:
INSERT INTO gold.dim_carriers(
    carrier_id,
    airline_name
)
SELECT
    carrier_code,
    airline_name
FROM
    silver.carriers;

-- Load weather event codes and description into gold.dim_active_weather
INSERT INTO gold.dim_active_weather(
    weather_id,
    weather_description
)
SELECT
    weather_code,
    weather_description
FROM
    silver.active_weather;

-- Load station metadata into gold.dim_airports
INSERT INTO gold.dim_airports(
  airport_id,
  airport,
  display_airport_name,
  display_airport_city,
  airport_state_name,
  airport_state_code,
  lattitude,
  longitude,
  elevation,
  icao,
  iata,
  faa,
  mesonet_station
)
SELECT 
  airport_id,
  airport,
  display_airport_name,
  display_airport_city,
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
  silver.stations;

-- Load distinct aircraft info into aircraft dimension
-- Separating aircraft data from the main fact table
-- Note: DISTINCT ensures unique tail numbers to avoid PK conflicts
INSERT INTO gold.dim_aircraft(
  tail_num,
  year_of_manufacture,
  manufacturer,
  icao_type,
  ac_range,
  ac_width
)
SELECT DISTINCT 
  tail_num,
  year_of_manufacture,
  manufacturer,
  icao_type,
  ac_range,
  width
FROM bronze.complete_data;

-- Load main fact table with enriched flight data
-- Note: Joins to airport dimension for origin and destination IDs for quicker query performance
INSERT INTO gold.fact_departure_data(
    fl_date,
    date_fk,
    dep_hour,
    mkt_unique_carrier,
    mkt_carrier_fl_num,
    op_unique_carrier,
    op_carrier_fl_num,
    tail_num_fk,
    origin_id,
    dest_id,
    dep_time,
    crs_dep_time,
    taxi_out,
    dep_delay,
    air_time,
    distance,
    cancellation,
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
)
SELECT
  fl_date,
  TO_CHAR(fl_date, 'YYYYMMDD')::INTEGER AS date_fk,
  dep_hour,
  mkt_unique_carrier,
  mkt_carrier_fl_num,
  op_unique_carrier,
  op_carrier_fl_num,
  tail_num,
  origin_airport.airport_id AS origin_id,
  dest_airport.airport_id AS dest_id,
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
FROM silver.complete_data
JOIN gold.dim_airports AS origin_airport ON complete_data.origin = origin_airport.airport
JOIN gold.dim_airports AS dest_airport ON complete_data.dest = dest_airport.airport;
