-- ========================================
-- Script: ddl_create_gold_layer_tables.sql
-- Purpose: Creating gold layer tables
-- Author: Daniel Varga
-- Created: 2025-07-18
-- Modified: 2025-07-26
-- ========================================

-- Table: gold.dim_date
-- Description: Date dimension table containing various granularities
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

-- Table: gold.dim_cancellation
-- Description: Cancellation status code and description dimension table
-- Note: Primary key added.
CREATE TABLE IF NOT EXISTS gold.dim_cancellation(
    status_code INTEGER PRIMARY KEY,
    cancellation_reason VARCHAR(50)
);

-- Table: gold.dim_carriers
-- Description: Airline carrier codes and full names dimension table
-- Note: Primary key added.
CREATE TABLE IF NOT EXISTS gold.dim_carriers(
    carrier_id VARCHAR(10) PRIMARY KEY,
    airline_name VARCHAR(50)
);

-- Table: gold.dim_active_weather
-- Description: Weather condition codes and description dimension table
-- Note_ Primary key added
CREATE TABLE IF NOT EXISTS gold.dim_active_weather(
    weather_id INTEGER PRIMARY KEY,
    weather_description VARCHAR(125)
);

-- Table: gold.dim_stations
-- Description: Airports metadata dimension table
-- Note: Primary key added
CREATE TABLE IF NOT EXISTS gold.dim_airports(
    airport_id INTEGER PRIMARY KEY,
    airport VARCHAR(25),
    display_airport_name VARCHAR(100),
    display_airport_city VARCHAR(100),
    airport_state_name VARCHAR(50),
    airport_state_code VARCHAR(10),
    lattitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    elevation INTEGER,
    icao VARCHAR(25),
    iata VARCHAR(25),
    faa VARCHAR(25),
    mesonet_station VARCHAR(25)
);

-- Table: gold.dim_aircraft
-- Description: Aircraft dimension table
-- Note: Aircraft diemnsion table seperated from the main complete data
CREATE TABLE IF NOT EXISTS gold.dim_aircraft(
    tail_num VARCHAR(10) PRIMARY KEY,
    year_of_manufacture SMALLINT,
    manufacturer VARCHAR(25),
    icao_type VARCHAR(25),
    ac_range VARCHAR(30),
    ac_width VARCHAR(25)
);

-- Table: gold.fact_departure_data
-- Description: Departure facts table linking to all dimensions
CREATE TABLE gold.fact_departure_data(
    fl_date DATE NOT NULL,
    date_fk INTEGER REFERENCES gold.dim_date(date_key),
    dep_hour INTEGER,
    mkt_unique_carrier VARCHAR(5) REFERENCES gold.dim_carriers(carrier_id),
    mkt_carrier_fl_num INTEGER,
    op_unique_carrier VARCHAR(5) REFERENCES gold.dim_carriers(carrier_id),
    op_carrier_fl_num INTEGER,
    tail_num_fk VARCHAR(10) REFERENCES gold.dim_aircraft(tail_num),
    origin_id INTEGER REFERENCES gold.dim_airports(airport_id),
    dest_id INTEGER REFERENCES gold.dim_airports(airport_id),
    dep_time TIMESTAMP,
    crs_dep_time TIMESTAMP,
    taxi_out INTEGER,
    dep_delay INTEGER,
    air_time INTEGER,
    distance INTEGER,
    cancellation INTEGER REFERENCES gold.dim_cancellation(status_code),
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
    active_weather INTEGER REFERENCES gold.dim_active_weather(weather_id)
);