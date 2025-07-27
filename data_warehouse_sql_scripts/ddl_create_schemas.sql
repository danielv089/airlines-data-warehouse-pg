-- ========================================
-- Script: ddl_create_schemas.sql
-- Purpose: Create Medallion Architecture Schemas
-- Author: Daniel Varga
-- Date: 2025-07-08
---Created: 2025-07-08
-- Modified: 2025-07-24
-- ========================================

--Create schemas for the medallion architecture.
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;