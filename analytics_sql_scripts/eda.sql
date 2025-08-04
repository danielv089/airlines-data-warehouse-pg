-- ========================================
-- Script: eda.sql
-- Purpose: Perform EDA by SQL
-- Author: Daniel Varga
-- Created: 2025-08-03
-- Modified: 2025-08-03
-- ========================================


--Number of all not cancelled flights
SELECT 
  COUNT(*) AS num_all_flights 
FROM gold.fact_departure_data 
WHERE cancellation = 0;

--Number of flights per month where the flight was not cancelled
SELECT 
  gold.dim_date.year,
  gold.dim_date.month,
  gold.dim_date.month_name,
  COUNT(gold.fact_departure_data.cancellation) as num_flights
FROM gold.fact_departure_data
JOIN gold.dim_date
ON gold.fact_departure_data.date_fk = gold.dim_date.date_key
WHERE gold.fact_departure_data.cancellation=0
GROUP BY gold.dim_date.year,gold.dim_date.month, gold.dim_date.month_name;

--Number of all cancelled flights
SELECT 
  COUNT(*) AS num_cancelled_flights 
FROM gold.fact_departure_data 
WHERE cancellation != 0;

--Monthly cancellation counts group by cancellation reason and maximum number of cancellations
SELECT 
  gold.dim_date.year,
  gold.dim_date.month,
  gold.dim_date.month_name,
  gold.fact_departure_data.cancellation,
  COUNT(*) AS monthly_cancel_count,
  SUM(COUNT(*)) OVER (PARTITION BY gold.dim_date.year,gold.dim_date.month, gold.dim_date.month_name) as num_cancellations
FROM gold.fact_departure_data
JOIN gold.dim_date ON gold.fact_departure_data.date_fk = gold.dim_date.date_key
WHERE gold.fact_departure_data.cancellation != 0
GROUP BY gold.dim_date.year, gold.dim_date.month, gold.dim_date.month_name, gold.fact_departure_data.cancellation
ORDER BY gold.dim_date.year, gold.dim_date.month, gold.dim_date.month_name, gold.fact_departure_data.cancellation;

--Top 10 busiest origin airports by number of departures
SELECT
  gold.dim_airports.display_airport_name,
  COUNT(*) AS num_flights
FROM gold.fact_departure_data
JOIN gold.dim_airports
ON gold.fact_departure_data.origin_id = gold.dim_airports.airport_id
GROUP BY gold.dim_airports.display_airport_name
ORDER BY num_flights DESC
LIMIT 10;

--Calculating total and average delay time by arilines
SELECT
gold.dim_carriers.airline_name,
SUM(gold.fact_departure_data.dep_delay) AS total_delay,
ROUND(AVG(gold.fact_departure_data.dep_delay),2) AS avg_delay
FROM gold.fact_departure_data
JOIN gold.dim_carriers
ON gold.fact_departure_data.mkt_unique_carrier=gold.dim_carriers.carrier_id
GROUP BY gold.dim_carriers.airline_name
ORDER BY total_delay DESC;


