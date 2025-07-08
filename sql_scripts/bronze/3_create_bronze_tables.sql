-- ========================================
-- Purpose: Creating Bronze Layer Tables and Load Data
-- Author: Daniel Varga
-- Date: 2025-07-08
-- ========================================



CREATE TABLE bronze.complete_data(
fl_date DATE,
dep_hour INTEGER,
mkt_unique_carrier VARCHAR(2),
mkt_carrier_fl_num INTEGER,
op_unique_carrier VARCHAR(2),
op_carrier_fl_num INTEGER,
tail_num VARCHAR(10),
origin VARCHAR(3),
dest VARCHAR(3),
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
icao_type VARCHAR(15),
ac_range VARCHAR(30),
width VARCHAR(25),
wind_dir NUMERIC(10,2),
wind_spd NUMERIC(10,2),
wind_gust NUMERIC(10,2),
visibility NUMERIC(10,2),
temperature NUMERIC(10,2),
dew_point NUMERIC(10,2),
rel_humidity NUMERIC(10,2),
altimeter NUMERIC(10,2),
lowest_cloud_layer NUMERIC(10,2),
n_cloud_layer NUMERIC(10,2),
low_level_cloud NUMERIC(10,2),
mid_level_cloud NUMERIC(10,2),
high_level_cloud NUMERIC(10,2),
cloud_cover NUMERIC(10,2),
active_weather NUMERIC(10,2)
);