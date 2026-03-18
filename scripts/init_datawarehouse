/*
============================
Create Database and Schemas
============================
Script Purpose:
  Create a new datawarehouse and three schemas: 'bronze', 'silver', 'gold'.
WARNING:
  It will drop the ENTIRE DataWarehouse database if it exists.
*/
USE master;
GO

-- Drop datawarehouse SE ele ja existe
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
END;
GO

-- Cria datawarehouse
CREATE DATABASE DataWarehouse;

USE DataWarehouse;
GO

-- Cria schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
