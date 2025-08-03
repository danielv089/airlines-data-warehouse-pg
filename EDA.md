# 2022 Airlines Departure Data Exploratory Data Analysis (EDA)

## Number of flights per month where the flight was not cancelled
```sql
airlines_departure_data_warehouse=# SELECT 
  gold.dim_date.year,
  gold.dim_date.month_name,
  COUNT(gold.fact_departure_data.cancellation) as num_flights
FROM gold.fact_departure_data
JOIN gold.dim_date
ON gold.fact_departure_data.date_fk = gold.dim_date.date_key
WHERE gold.fact_departure_data.cancellation=0
GROUP BY gold.dim_date.year, gold.dim_date.month_name;

 year | month_name | num_flights 
------+------------+-------------
 2022 | April      |      565501
 2022 | August     |      596284
 2022 | December   |      545767
 2022 | February   |      495651
 2022 | January    |      526894
 2022 | July       |      605705
 2022 | June       |      581836
 2022 | March      |      579953
 2022 | May        |      589376
 2022 | November   |      559983
 2022 | October    |      589438
 2022 | September  |      570418
(12 rows)
```

## Monthly cancellation counts group by cancellation reason and maximum number of cancellations
```sql
airlines_departure_data_warehouse=# SELECT 
  gold.dim_date.year,
  gold.dim_date.month_name,
  gold.fact_departure_data.cancellation,
  COUNT(*) AS monthly_cancel_count,
  SUM(COUNT(*)) OVER (PARTITION BY gold.dim_date.year, gold.dim_date.month_name) as num_cancellations
FROM gold.fact_departure_data
JOIN gold.dim_date ON gold.fact_departure_data.date_fk = gold.dim_date.date_key
WHERE gold.fact_departure_data.cancellation != 0
GROUP BY gold.dim_date.year, gold.dim_date.month_name, gold.fact_departure_data.cancellation
ORDER BY gold.dim_date.year, gold.dim_date.month_name, gold.fact_departure_data.cancellation;

 year | month_name | cancellation | monthly_cancel_count | num_cancellations 
------+------------+--------------+----------------------+-------------------
 2022 | April      |            1 |                 5395 |             11481
 2022 | April      |            2 |                 4246 |             11481
 2022 | April      |            3 |                 1840 |             11481
 2022 | August     |            1 |                 3164 |             13041
 2022 | August     |            2 |                 7422 |             13041
 2022 | August     |            3 |                 2402 |             13041
 2022 | August     |            4 |                   53 |             13041
 2022 | December   |            1 |                12628 |             22799
 2022 | December   |            2 |                 9737 |             22799
 2022 | December   |            3 |                  434 |             22799
 2022 | February   |            1 |                 3546 |             17928
 2022 | February   |            2 |                14075 |             17928
 2022 | February   |            3 |                  307 |             17928
 2022 | January    |            1 |                10175 |             25099
 2022 | January    |            2 |                14466 |             25099
 2022 | January    |            3 |                  458 |             25099
 2022 | July       |            1 |                 3658 |              9501
 2022 | July       |            2 |                 4022 |              9501
 2022 | July       |            3 |                 1752 |              9501
 2022 | July       |            4 |                   69 |              9501
 2022 | June       |            1 |                 6880 |             15165
 2022 | June       |            2 |                 5425 |             15165
 2022 | June       |            3 |                 2858 |             15165
 2022 | June       |            4 |                    2 |             15165
 2022 | March      |            1 |                 2430 |              7080
 2022 | March      |            2 |                 3417 |              7080
 2022 | March      |            3 |                 1232 |              7080
 2022 | March      |            4 |                    1 |              7080
 2022 | May        |            1 |                 4583 |             10143
 2022 | May        |            2 |                 3988 |             10143
 2022 | May        |            3 |                 1571 |             10143
 2022 | May        |            4 |                    1 |             10143
 2022 | November   |            1 |                  857 |              5295
 2022 | November   |            2 |                 3682 |              5295
 2022 | November   |            3 |                  756 |              5295
 2022 | October    |            1 |                  734 |              3570
 2022 | October    |            2 |                 2491 |              3570
 2022 | October    |            3 |                  344 |              3570
 2022 | October    |            4 |                    1 |              3570
 2022 | September  |            1 |                 1136 |              6728
 2022 | September  |            2 |                 5051 |              6728
 2022 | September  |            3 |                  541 |              6728
(42 rows)
```
## Top 10 busiest origin airports by number of departures
```sql
airlines_departure_data_warehouse=# SELECT
  gold.dim_airports.display_airport_name,
  COUNT(*) AS num_flights
FROM gold.fact_departure_data
JOIN gold.dim_airports
ON gold.fact_departure_data.origin_id = gold.dim_airports.airport_id
GROUP BY gold.dim_airports.display_airport_name
ORDER BY num_flights DESC
LIMIT 10;

           display_airport_name           | num_flights 
------------------------------------------+-------------
 Hartsfield-Jackson Atlanta International |      316706
 Chicago O'Hare International             |      293052
 Denver International                     |      275751
 Dallas/Fort Worth International          |      275432
 Charlotte Douglas International          |      213747
 Los Angeles International                |      190172
 Harry Reid International                 |      174297
 Seattle/Tacoma International             |      173462
 LaGuardia                                |      169946
 Phoenix Sky Harbor International         |      164359
(10 rows)
```