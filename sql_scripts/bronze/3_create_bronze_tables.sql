-- ========================================
-- Purpose: Creating Bronze Layer Tables and Load Data
-- Author: Daniel Varga
-- Date: 2025-07-08
-- ========================================


-- =====================
-- Creating table for raw flight data, weather and aircraft attributes
-- =====================
CREATE TABLE IF NOT EXISTS bronze.complete_data(
fl_date DATE,
dep_hour INTEGER,
mkt_unique_carrier VARCHAR(5),
mkt_carrier_fl_num INTEGER,
op_unique_carrier VARCHAR(5),
op_carrier_fl_num INTEGER,
tail_num VARCHAR(10),
origin VARCHAR(10),
dest VARCHAR(10),
dep_time TIMESTAMP,
crs_dep_time TIMESTAMP,
taxi_out INTEGER,
dep_delay INTEGER,
air_time INTEGER,
distance INTEGER,
cancelled INTEGER,
latitude FLOAT,
longitude FLOAT,
elevation INTEGER,
mesonet_station VARCHAR(5),
year_of_manufacture SMALLINT,
manufacturer VARCHAR(25),
icao_type VARCHAR(25),
ac_range VARCHAR(30),
width VARCHAR(25),
wind_dir FLOAT,
wind_spd FLOAT,
wind_gust FLOAT,
visibility FLOAT,
temperature FLOAT,
dew_point FLOAT,
rel_humidity FLOAT,
altimeter FLOAT,
lowest_cloud_layer FLOAT,
n_cloud_layer FLOAT,
low_level_cloud FLOAT,
mid_level_cloud FLOAT,
high_level_cloud FLOAT,
cloud_cover FLOAT,
active_weather FLOAT
);


-- =====================
-- Creating table for station data
-- =====================
CREATE TABLE IF NOT EXISTS bronze.stations(
airport_id INTEGER,
airport VARCHAR(25),
display_airport_name VARCHAR(100),
display_airport_city VARCHAR(100),
airport_state_name VARCHAR(50),
airport_state_code VARCHAR(10),
lattitude FLOAT,
longitude FLOAT,
elevation INTEGER,
icao VARCHAR(25),
iata VARCHAR(25),
faa VARCHAR(25),
mesonet_station VARCHAR(25)
);


-- =====================
-- Creating table for carriers data
-- =====================
CREATE TABLE IF NOT EXISTS bronze.carriers(
code VARCHAR(10),
description VARCHAR(50)
);


-- =====================
-- Creating table for cancellation statud code and description
-- =====================
CREATE TABLE IF NOT EXISTS bronze.cancellation(
status INTEGER,
cancellation_reason VARCHAR(50)
);


-- =====================
-- Creating table for weather code and description
-- =====================
CREATE TABLE IF NOT EXISTS bronze.active_weather(
status INTEGER,
weather_description VARCHAR(125)
);