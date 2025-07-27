-- ========================================
-- Script: indexes.sql
-- Purpose: Creating indexes to increase query performance
-- Author: Daniel Varga
-- Created: 2025-07-26
-- Modified: 2025-07-26
-- ========================================


-- fact_departure_data Indexes
CREATE INDEX idx_date_fk ON gold.fact_departure_data(date_fk);

CREATE INDEX idx_tail_num_fk ON gold.fact_departure_data(tail_num_fk);

CREATE INDEX idx_origin_id ON gold.fact_departure_data(origin_id);

CREATE INDEX idx_dest_id ON gold.fact_departure_data(dest_id);

-- dim_date Indexes
CREATE INDEX idx_date_key ON gold.dim_date(date_key);

-- dim_airports Indexes
CREATE INDEX idx_airport_id ON gold.dim_airports(airport_id);

-- dim_aircraft Indexes
CREATE INDEX idx_tail_num ON gold.dim_aircraft(tail_num);

