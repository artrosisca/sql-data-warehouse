/*
============================================================
Create Database and Schemas (Fixed Version)
============================================================
*/

USE master;
GO

-- 1. Derruba conexões e exclui a base se ela já existir
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    -- Força o fechamento de conexões e coloca em single_user para deletar
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- 2. Cria a base do zero
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- 3. Cria os schemas para a arquitetura de medalhão
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO