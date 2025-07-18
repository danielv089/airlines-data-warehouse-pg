-- ========================================
-- Purpose: Loading data into silver tables
-- Author: Daniel Varga
-- Date: 2025-07-18
-- ========================================



INSERT INTO silver.complete_data (
    fl_date, dep_hour, mkt_unique_carrier, mkt_carrier_fl_num,
    op_unique_carrier, op_carrier_fl_num, tail_num, origin, dest,
    dep_time, crs_dep_time, taxi_out, dep_delay, air_time, distance,
    cancelled, latitude, longitude, elevation, mesonet_station,
    year_of_manufacture, manufacturer, icao_type, ac_range, width,
    wind_dir, wind_spd, wind_gust, visibility, temperature, dew_point,
    rel_humidity, altimeter, lowest_cloud_layer, n_cloud_layer,
    low_level_cloud, mid_level_cloud, high_level_cloud, cloud_cover,
    active_weather, missing_weather_data
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
    active_weather,
    CASE 
      WHEN wind_dir IS NULL
        AND wind_spd IS NULL
        AND wind_gust IS NULL
        AND visibility IS NULL
        AND temperature IS NULL
        AND dew_point IS NULL
        AND rel_humidity IS NULL
        AND altimeter IS NULL
        AND lowest_cloud_layer IS NULL
        AND n_cloud_layer IS NULL
        AND low_level_cloud IS NULL
        AND mid_level_cloud IS NULL
        AND high_level_cloud IS NULL
        AND cloud_cover IS NULL
        AND active_weather IS NULL
      THEN TRUE
      ELSE FALSE
    END AS missing_weather_data
FROM
    bronze.complete_data
;