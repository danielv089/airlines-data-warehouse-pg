CREATE TABLE silver.complete_data(
flight_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
fl_date DATE NOT NULL,
dep_hour INTEGER NOT NULL,
mkt_unique_carrier VARCHAR(5),
mkt_carrier_fl_num INTEGER,
op_unique_carrier VARCHAR(5),
op_carrier_fl_num INTEGER,
tail_num VARCHAR(10),
origin VARCHAR(10),
dest VARCHAR(10),
dep_time TIMESTAMP NOT NULL,
crs_dep_time TIMESTAMP NOT NULL,
taxi_out INTEGER,
dep_delay INTEGER,
air_time INTEGER,
distance INTEGER,
cancelled INTEGER,
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
active_weather FLOAT,
CONSTRAINT uniq_flight UNIQUE (fl_date, mkt_unique_carrier, mkt_carrier_fl_num, origin, dest)
);



INSERT INTO silver.complete_data (
    fl_date, dep_hour, mkt_unique_carrier, mkt_carrier_fl_num,
    op_unique_carrier, op_carrier_fl_num, tail_num, origin, dest,
    dep_time, crs_dep_time, taxi_out, dep_delay, air_time, distance,
    cancelled, wind_dir, wind_spd, wind_gust, visibility, temperature,
    dew_point, rel_humidity, altimeter, lowest_cloud_layer, n_cloud_layer,
    low_level_cloud, mid_level_cloud, high_level_cloud, cloud_cover, active_weather
)
SELECT 
    fl_date, dep_hour, mkt_unique_carrier, mkt_carrier_fl_num,
    op_unique_carrier, op_carrier_fl_num, tail_num, origin, dest,
    dep_time, crs_dep_time, taxi_out, dep_delay, air_time, distance,
    cancelled, wind_dir, wind_spd, wind_gust, visibility, temperature,
    dew_point, rel_humidity, altimeter, lowest_cloud_layer, n_cloud_layer,
    low_level_cloud, mid_level_cloud, high_level_cloud, cloud_cover, active_weather
FROM bronze.complete_data;


SELECT flight_id, COUNT(*) FROM silver.complete_data GROUP BY flight_id HAVING COUNT(*)>1;




