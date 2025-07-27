-- ========================================
-- Script: ddl_create_bronze_layer_tables.sql
-- Purpose: Creating bronze layer tables
-- Author: Daniel Varga
-- Created: 2025-07-08
-- Modified: 2025-07-24
-- ========================================

-- Table: bronze.complete_data
-- Description: Stores main flight data.
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
latitude DOUBLE PRECISION,
longitude DOUBLE PRECISION,
elevation INTEGER,
mesonet_station VARCHAR(5),
year_of_manufacture SMALLINT,
manufacturer VARCHAR(25),
icao_type VARCHAR(25),
ac_range VARCHAR(30),
width VARCHAR(25),
wind_dir DOUBLE PRECISION,
wind_spd DOUBLE PRECISION,
wind_gust DOUBLE PRECISION,
visibility DOUBLE PRECISION,
temperature DOUBLE PRECISION,
dew_point DOUBLE PRECISION,
rel_humidity DOUBLE PRECISION,
altimeter DOUBLE PRECISION,
lowest_cloud_layer DOUBLE PRECISION,
n_cloud_layer DOUBLE PRECISION,
low_level_cloud DOUBLE PRECISION,
mid_level_cloud DOUBLE PRECISION,
high_level_cloud DOUBLE PRECISION,
cloud_cover DOUBLE PRECISION,
active_weather DOUBLE PRECISION
);

-- Table: bronze.stations
-- Description: Airports metadata.
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

-- Table: bronze.carriers
-- Description: Airline carrier codes and full names.
CREATE TABLE IF NOT EXISTS bronze.carriers(
code VARCHAR(10),
description VARCHAR(50)
);

-- Table: bronze.cancellation
-- Description: Cancellation status code and description.
CREATE TABLE IF NOT EXISTS bronze.cancellation(
status INTEGER,
cancellation_reason VARCHAR(50)
);

-- Table: bronze.active_weather
-- Description: Weather condition codes and description.
CREATE TABLE IF NOT EXISTS bronze.active_weather(
status INTEGER,
weather_description VARCHAR(125)
);