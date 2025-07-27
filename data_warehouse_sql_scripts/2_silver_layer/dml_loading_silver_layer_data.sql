-- ========================================
-- Script: dml_loading_silver_layer_data
-- Purpose: Loading data into silver layer tables.
-- Author: Daniel Varga
-- Created: 2025-07-18
-- Modified: 2025-07-24
-- ========================================



-- Load main flight and weather data into silver.complete_data
INSERT INTO silver.complete_data (
    fl_date, dep_hour, mkt_unique_carrier, mkt_carrier_fl_num,
    op_unique_carrier, op_carrier_fl_num, tail_num, origin, dest,
    dep_time, crs_dep_time, taxi_out, dep_delay, air_time, distance,
    cancelled, latitude, longitude, elevation, mesonet_station,
    year_of_manufacture, manufacturer, icao_type, ac_range, ac_width,
    wind_dir, wind_spd, wind_gust, visibility, temperature, dew_point,
    rel_humidity, altimeter, lowest_cloud_layer, n_cloud_layer,
    low_level_cloud, mid_level_cloud, high_level_cloud, cloud_cover,
    active_weather
)
SELECT
    fl_date, dep_hour, mkt_unique_carrier, mkt_carrier_fl_num,
    op_unique_carrier, op_carrier_fl_num, tail_num, origin, dest,
    dep_time, crs_dep_time, taxi_out, dep_delay, air_time, distance,
    cancelled, latitude, longitude, elevation, mesonet_station,
    year_of_manufacture, manufacturer, icao_type, ac_range, width,
    wind_dir, wind_spd, wind_gust, visibility, temperature, dew_point,
    rel_humidity, altimeter, lowest_cloud_layer, n_cloud_layer,
    low_level_cloud, mid_level_cloud, high_level_cloud, cloud_cover,
    active_weather
FROM
    bronze.complete_data;

-- Load cancellation data table into silver.cancellation
-- Note: 'status' in bronze maps changed to 'status_code'
INSERT INTO silver.cancellation(
    status_code, 
    cancellation_reason
)
SELECT
    status,
    cancellation_reason
FROM
    bronze.cancellation;

-- Load carrier codes and names into silver.carriers
-- Note: 'code' → 'carrier_code', 'description' → 'airline_name'
INSERT INTO silver.carriers(
    carrier_code,
    airline_name
)
SELECT
    code,
    description
FROM
    bronze.carriers;

-- Load weather event codes and description into silver.active_weather
INSERT INTO silver.active_weather(
    weather_code,
    weather_description
)
SELECT
    status,
    weather_description
FROM
    bronze.active_weather;

-- Load station metadata into silver.stations
-- Note: Parses airport city from 'display_airport_city' by removing state info to ensure atomicity
INSERT INTO silver.stations(
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
    