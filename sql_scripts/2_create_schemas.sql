-- ========================================
-- Purpose: Create Medallion Architecture Schemas
-- Author: Daniel Varga
-- Date: 2025-07-08
-- ========================================

--Creating schemas for the medallion architecture
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;