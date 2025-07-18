-- ========================================
-- Purpose: Creating gold layer tables
-- Author: Daniel Varga
-- Date: 2025-07-18
-- ========================================



CREATE TABLE silver.complete_data (
    id SERIAL PRIMARY KEY,
    fl_date DATE NOT NULL,
    dep_hour INTEGER,
    mkt_unique_carrier VARCHAR(5) FOREIGN KEY REFERENCES,
    mkt_carrier_fl_num INTEGER,
    op_unique_carrier VARCHAR(5) FOREIGN KEY REFERENCES,
    op_carrier_fl_num INTEGER,
    tail_num VARCHAR(10) FOREIGN KEY REFERENCES ,
    origin VARCHAR(10) FOREIGN  KEY REFERENCES ,
    dest VARCHAR(10) FOREIGN KEY REFERENCES ,
    dep_time TIMESTAMP,
    crs_dep_time TIMESTAMP,
    taxi_out INTEGER,
    dep_delay INTEGER,
    air_time INTEGER,
    distance INTEGER,
    cancelled INTEGER FOREIGN KEY REFERENCES ,
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
    active_weather DOUBLE PRECISION FOREIGN KEY REFERENCES,
    missing_weather_data BOOLEAN
    UNIQUE(fl_date, dep_hour, op_unique_carrier, op_carrier_fl_num, tail_num)
);