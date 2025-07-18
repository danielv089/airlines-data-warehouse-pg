# 2002 Airlines Departure Data Warehouse in PostgreSQL

## 📌 Overview

This project demonstrates the design and implementation of an airline data warehouse using PostgreSQL. It focuses on modeling historical U.S. domestic departure flight data into a clean, query-optimized structure following the dimensional modeling (star schema) approach. The goal is to transform raw, denormalized datasets into a datawarehous that supports efficient querying, reporting, and analytics for airline operations and performance metrics. The project uses the Medallion Architecture design pattern, which organizes data processing into layered zones — Bronze, Silver, and Gold.

## 🧱 Architecture Layers

### Bronze Layer
- Raw flight, , cancellation, carrier, weather, and airport data ingested directly from source systems.
- Data stored in staging tables in the bronze schema without transformation.

### Silver Layer
- Data cleansing and transformation.
- Separation into normalized dimension tables and a fact table.

### Gold Layer
- Business-level aggregates, KPIs, and advanced metrics calculated

## 🧰 Tech Stack
- **PostgreSQL**

## 🔗 References

- Kaggle - 2022 US Airlines Domestic Departure Data
https://www.kaggle.com/datasets/jl8771/2022-us-airlines-domestic-departure-data

- PostgreSQL Documentation
https://www.postgresql.org/docs/

✅ This project uses only publicly available data for educational purposes.
