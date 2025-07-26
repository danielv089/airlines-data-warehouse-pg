# 2022 Airlines Departure Data Warehouse in PostgreSQL

## 📌 Overview

This project demonstrates the design and implementation of an airline data warehouse using PostgreSQL. It focuses on modeling historical U.S. domestic departure flight data into a clean, query-optimized structure following the dimensional modeling (star schema) approach. The goal is to transform raw, denormalized datasets into a datawarehous that supports efficient querying, reporting, and analytics for airline operations and performance metrics. The project uses the Medallion Architecture design pattern, which organizes data processing into layered zones — Bronze, Silver, and Gold.

## 🧱 Architecture Layers

### Bronze Layer
- Raw flight, , cancellation, carrier, weather, and airport data ingested directly from source systems.
- Data stored in staging tables in the bronze schema without transformation.
- Preserving raw data.

### Silver Layer
- Data validation, cleansing and transormation, when needed. 
- The raw data is already relatively clean, so minimal transformation needed.
- Purpose is refining data quality and apply consistent formatting.

### Gold Layer
- Creating and loading data into dimension and fact tables used for business intelligence, reporting, and analytics.
- Follows a star schema structure or business intelligence, reporting, and analytics.

## 🧰 Tech Stack
- **PostgreSQL**
- **SQL**

## 🔗 References

- Kaggle - 2022 US Airlines Domestic Departure Data
  https://www.kaggle.com/datasets/jl8771/2022-us-airlines-domestic-departure-data

- PostgreSQL Documentation
  https://www.postgresql.org/docs/

✅ This project uses only publicly available data for educational purposes.
