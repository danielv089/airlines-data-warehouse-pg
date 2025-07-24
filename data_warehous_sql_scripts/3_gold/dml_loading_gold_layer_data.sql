-- ========================================
-- Script: ddl_loading_gold_layer_tables.sql
-- Purpose: Loading data into gold layer tables
-- Author: Daniel Varga
-- Created: 2025-07-24
-- Modified: 2025-07-24
-- ========================================


INSERT INTO gold.dim_date (
    date_key,
    date,
    year,
    month,
    month_name,
    day,
    day_of_year,
    weekday_name,
    calendar_week,
    formatted_date,
    quartal,
    year_quartal,
    year_month,
    year_calendar_week,
    weekend,
    american_holiday,
    calendar_week_start,
    calendar_week_end,
    month_start,
    month_end
)
SELECT
    TO_CHAR(datum, 'YYYYMMDD')::INTEGER AS date_key,
	datum as Date,
	extract(year from datum) AS Year,
	extract(month from datum) AS Month,
	to_char(datum, 'TMMonth') AS Month_Name,
	extract(day from datum) AS Day,
	extract(doy from datum) AS Day_of_Year,
	to_char(datum, 'TMDay') AS Weekday_Name,
	extract(week from datum) AS Calendar_Week,
	to_char(datum, 'dd. mm. yyyy') AS Formatted_Date,
	'Q' || to_char(datum, 'Q') AS Quartal,
	to_char(datum, 'yyyy/"Q"Q') AS Year_Quartal,
	to_char(datum, 'yyyy/mm') AS Year_Month,
	to_char(datum, 'iyyy/IW') AS Year_Calendar_Week,
	CASE WHEN extract(isodow from datum) in (6, 7) THEN 'Weekend' ELSE 'Weekday' END AS Weekend,
        CASE WHEN to_char(datum, 'MMDD') IN ('0101', '0704', '1225', '1226')
		THEN 'Holiday' ELSE 'No holiday' END
		AS American_Holiday,
	datum + (1 - extract(isodow from datum))::integer AS CWStart,
	datum + (7 - extract(isodow from datum))::integer AS CWEnd,
	datum + (1 - extract(day from datum))::integer AS Month_Start,
	(datum + (1 - extract(day from datum))::integer + '1 month'::interval)::date - '1 day'::interval AS Month_End
FROM (
	SELECT '2022-01-01'::DATE + sequence.day AS datum
	FROM generate_series(0,364) AS sequence(day)
	GROUP BY sequence.day
     ) DQ
order by 1;
