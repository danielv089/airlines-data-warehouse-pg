# 2022 Airlines Departure Data Exploratory Data Analysis (EDA)

## Number of All Not Cancelled Flights
```sql
airlines_departure_data_warehouse=# SELECT 
  COUNT(*) AS num_all_flights 
FROM gold.fact_departure_data 
WHERE cancellation = 0;

 num_all_flights 
-----------------
         6806806
(1 row)
```

## Number of Flights per Month Where the Flight Was Not Cancelled
```sql
airlines_departure_data_warehouse=# SELECT 
  gold.dim_date.year,
  gold.dim_date.month,
  gold.dim_date.month_name,
  COUNT(gold.fact_departure_data.cancellation) as num_flights
FROM gold.fact_departure_data
JOIN gold.dim_date
ON gold.fact_departure_data.date_fk = gold.dim_date.date_key
WHERE gold.fact_departure_data.cancellation=0
GROUP BY gold.dim_date.year,gold.dim_date.month, gold.dim_date.month_name;

 year | month | month_name | num_flights 
------+-------+------------+-------------
 2022 |     1 | January    |      526894
 2022 |     2 | February   |      495651
 2022 |     3 | March      |      579953
 2022 |     4 | April      |      565501
 2022 |     5 | May        |      589376
 2022 |     6 | June       |      581836
 2022 |     7 | July       |      605705
 2022 |     8 | August     |      596284
 2022 |     9 | September  |      570418
 2022 |    10 | October    |      589438
 2022 |    11 | November   |      559983
 2022 |    12 | December   |      545767
(12 rows)

```

## Number of All Cancelled Flights
```sql
airlines_departure_data_warehouse=# SELECT 
  COUNT(*) AS num_cancelled_flights 
FROM gold.fact_departure_data 
WHERE cancellation != 0;

 num_cancelled_flights 
-----------------------
                147830
(1 row)
```

## Monthly Cancellation Counts Group by Cancellation Reason and Maximum Number of Cancellations
```sql
airlines_departure_data_warehouse=# SELECT 
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

 year | month | month_name | cancellation | monthly_cancel_count | num_cancellations 
------+-------+------------+--------------+----------------------+-------------------
 2022 |     1 | January    |            1 |                10175 |             25099
 2022 |     1 | January    |            2 |                14466 |             25099
 2022 |     1 | January    |            3 |                  458 |             25099
 2022 |     2 | February   |            1 |                 3546 |             17928
 2022 |     2 | February   |            2 |                14075 |             17928
 2022 |     2 | February   |            3 |                  307 |             17928
 2022 |     3 | March      |            1 |                 2430 |              7080
 2022 |     3 | March      |            2 |                 3417 |              7080
 2022 |     3 | March      |            3 |                 1232 |              7080
 2022 |     3 | March      |            4 |                    1 |              7080
 2022 |     4 | April      |            1 |                 5395 |             11481
 2022 |     4 | April      |            2 |                 4246 |             11481
 2022 |     4 | April      |            3 |                 1840 |             11481
 2022 |     5 | May        |            1 |                 4583 |             10143
 2022 |     5 | May        |            2 |                 3988 |             10143
 2022 |     5 | May        |            3 |                 1571 |             10143
 2022 |     5 | May        |            4 |                    1 |             10143
 2022 |     6 | June       |            1 |                 6880 |             15165
 2022 |     6 | June       |            2 |                 5425 |             15165
 2022 |     6 | June       |            3 |                 2858 |             15165
 2022 |     6 | June       |            4 |                    2 |             15165
 2022 |     7 | July       |            1 |                 3658 |              9501
 2022 |     7 | July       |            2 |                 4022 |              9501
 2022 |     7 | July       |            3 |                 1752 |              9501
 2022 |     7 | July       |            4 |                   69 |              9501
 2022 |     8 | August     |            1 |                 3164 |             13041
 2022 |     8 | August     |            2 |                 7422 |             13041
 2022 |     8 | August     |            3 |                 2402 |             13041
 2022 |     8 | August     |            4 |                   53 |             13041
 2022 |     9 | September  |            1 |                 1136 |              6728
 2022 |     9 | September  |            2 |                 5051 |              6728
 2022 |     9 | September  |            3 |                  541 |              6728
 2022 |    10 | October    |            1 |                  734 |              3570
 2022 |    10 | October    |            2 |                 2491 |              3570
 2022 |    10 | October    |            3 |                  344 |              3570
 2022 |    10 | October    |            4 |                    1 |              3570
 2022 |    11 | November   |            1 |                  857 |              5295
 2022 |    11 | November   |            2 |                 3682 |              5295
 2022 |    11 | November   |            3 |                  756 |              5295
 2022 |    12 | December   |            1 |                12628 |             22799
 2022 |    12 | December   |            2 |                 9737 |             22799
 2022 |    12 | December   |            3 |                  434 |             22799
(42 rows)
```
## Top 10 Busiest Origin Airports by Number of Departures
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

## Total and Average Delay Time by Airlines
```sql
airlines_departure_data_warehouse=# SELECT
gold.dim_carriers.airline_name,
SUM(gold.fact_departure_data.dep_delay) AS total_delay,
ROUND(AVG(gold.fact_departure_data.dep_delay),2) AS avg_delay
FROM gold.fact_departure_data
JOIN gold.dim_carriers
ON gold.fact_departure_data.mkt_unique_carrier=gold.dim_carriers.carrier_id
GROUP BY gold.dim_carriers.airline_name
ORDER BY total_delay DESC;

      airline_name      | total_delay | avg_delay 
------------------------+-------------+-----------
 American Airlines Inc. |    20487201 |     11.70
 Southwest Airlines Co. |    18216638 |     14.07
 United Air Lines Inc.  |    14554591 |     11.73
 Delta Air Lines Inc.   |    13892270 |      9.61
 JetBlue Airways        |     6061825 |     22.28
 Spirit Air Lines       |     3213164 |     13.85
 Frontier Airlines Inc. |     3185527 |     21.11
 Alaska Airlines Inc.   |     2340302 |      6.13
 Allegiant Air          |     2078207 |     18.38
 Hawaiian Airlines Inc. |      721204 |      9.86
(10 rows)
```

## 10 Busiest Flight Departure Hours and Dates
```sql
airlines_departure_data_warehouse=# SELECT
  gold.fact_departure_data.fl_date,
  gold.fact_departure_data.dep_hour,
  COUNT(*) AS num_departures
FROM gold.fact_departure_data
GROUP BY gold.fact_departure_data.fl_date, gold.fact_departure_data.dep_hour
ORDER BY num_departures DESC
LIMIT 10;

  fl_date   | dep_hour | num_departures 
------------+----------+----------------
 2022-12-23 |        0 |           4655
 2022-12-26 |        0 |           3944
 2022-02-03 |        0 |           3371
 2022-02-04 |        0 |           3110
 2022-12-25 |        0 |           3001
 2022-12-24 |        0 |           2880
 2022-01-03 |        0 |           2605
 2022-12-22 |        0 |           2221
 2022-01-29 |        0 |           2211
 2022-01-02 |        0 |           2138
(10 rows)
```

## 10 Most Used Aircraft
```sql
airlines_departure_data_warehouse=# SELECT * 
FROM 
(SELECT
  gold.fact_departure_data.tail_num_fk,
  COUNT(*) AS num_flights
FROM gold.fact_departure_data
GROUP BY gold.fact_departure_data.tail_num_fk)
AS flights
JOIN gold.dim_aircraft
ON flights.tail_num_fk = gold.dim_aircraft.tail_num
ORDER BY num_flights DESC
LIMIT 10;

 tail_num_fk | num_flights | tail_num | year_of_manufacture | manufacturer | icao_type |  ac_range   |  ac_width   
-------------+-------------+----------+---------------------+--------------+-----------+-------------+-------------
 N475HA      |        3033 | N475HA   |                2001 | Boeing       | B712      | Short Range | Narrow-body
 N492HA      |        3032 | N492HA   |                2004 | Boeing       | B712      | Short Range | Narrow-body
 N483HA      |        2825 | N483HA   |                2001 | Boeing       | B712      | Short Range | Narrow-body
 N484HA      |        2813 | N484HA   |                2001 | Boeing       | B712      | Short Range | Narrow-body
 N476HA      |        2794 | N476HA   |                2001 | Boeing       | B712      | Short Range | Narrow-body
 N490HA      |        2792 | N490HA   |                2000 | Boeing       | B712      | Short Range | Narrow-body
 N493HA      |        2784 | N493HA   |                2005 | Boeing       | B712      | Short Range | Narrow-body
 N478HA      |        2773 | N478HA   |                2001 | Boeing       | B712      | Short Range | Narrow-body
 N489HA      |        2731 | N489HA   |                1998 | Boeing       | B712      | Short Range | Narrow-body
 N494HA      |        2553 | N494HA   |                2004 | Boeing       | B712      | Short Range | Narrow-body
(10 rows)
```

## Running total of all departures per month
```sql
airlines_datawarehouse=# SELECT 
  gold.dim_date.year,
  gold.dim_date.month,
  COUNT(*) AS monthly_departures,
  SUM(COUNT(*)) OVER (ORDER BY gold.dim_date.month) AS cumulative_departures
FROM gold.fact_departure_data
JOIN gold.dim_date
ON gold.fact_departure_data.date_fk = gold.dim_date.date_key
GROUP BY gold.dim_date.year, gold.dim_date.month
ORDER BY gold.dim_date.year, gold.dim_date.month;
 year | month | monthly_departures | cumulative_departures 
------+-------+--------------------+-----------------------
 2022 |     1 |             551993 |                551993
 2022 |     2 |             513579 |               1065572
 2022 |     3 |             587033 |               1652605
 2022 |     4 |             576982 |               2229587
 2022 |     5 |             599519 |               2829106
 2022 |     6 |             597001 |               3426107
 2022 |     7 |             615206 |               4041313
 2022 |     8 |             609325 |               4650638
 2022 |     9 |             577146 |               5227784
 2022 |    10 |             593008 |               5820792
 2022 |    11 |             565278 |               6386070
 2022 |    12 |             568566 |               6954636
(12 rows)
```