-- ========================================
-- Script: ddl_create_gold_layer_tables.sql
-- Purpose: Creating gold layer tables
-- Author: Daniel Varga
-- Created: 2025-07-18
-- Modified: 2025-07-24
-- ========================================


CREATE TABLE IF NOT EXISTS gold.dim_date (
    date_key INTEGER PRIMARY KEY,
    date DATE,
    year INTEGER,
    month INTEGER,
    month_name VARCHAR(20),
    day INTEGER,
    day_of_year INTEGER,
    weekday_name VARCHAR(20),
    calendar_week INTEGER,
    formatted_date VARCHAR(20),
    quartal VARCHAR(5),
    year_quartal VARCHAR(10),
    year_month VARCHAR(10),
    year_calendar_week VARCHAR(10),
    weekend VARCHAR(10),
    american_holiday VARCHAR(20),
    calendar_week_start DATE,
    calendar_week_end DATE,
    month_start DATE,
    month_end DATE
);
























CREATE TABLE gold.fact_departure_data(
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
    UNIQUE(fl_date, dep_hour, op_unique_carrier, op_carrier_fl_num, tail_num)
);