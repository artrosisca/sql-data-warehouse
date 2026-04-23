# Bronze Layer

This directory contains the scripts responsible for **ingesting raw data** into SQL Server without applying any transformations. Data is loaded exactly as it arrives from the sources (CRM and ERP).

## Files

| File | Description |
|------|-------------|
| `ddl_bronze.sql` | DDL definition of all Bronze layer tables. |
| `procedure_load_bronze.sql` | Stored Procedure `bronze.load_bronze`: performs a `Truncate & Load` of all source files into the Bronze tables. |

## Load Strategy

The Bronze load uses the **Truncate & Load** strategy:
- The table is truncated (all records removed) on each execution.
- Raw CSV data is fully imported via `BULK INSERT`.

This ensures the Bronze layer always reflects the current state of the source files.

## Data Sources

| System | Tables |
|--------|--------|
| **CRM** | `bronze.crm_cust_info`, `bronze.crm_prd_info`, `bronze.crm_sales_details` |
| **ERP** | `bronze.erp_cust_az12`, `bronze.erp_loc_a101`, `bronze.erp_px_cat_g1v2` |

---
---

# Camada Bronze *(Português)*

Este diretório contém os scripts responsáveis pela **ingestão dos dados brutos** no SQL Server, sem aplicar nenhuma transformação. Os dados são carregados exatamente como chegam das fontes (CRM e ERP).

## Arquivos

| Arquivo | Descrição |
|---------|-----------|
| `ddl_bronze.sql` | Definição (DDL) de todas as tabelas da camada Bronze. |
| `procedure_load_bronze.sql` | Stored Procedure `bronze.load_bronze`: realiza a carga `Truncate & Load` de todos os arquivos de origem para as tabelas Bronze. |

## Estratégia de Carga

A carga Bronze utiliza a estratégia **Truncate & Load**:
- A tabela é truncada (todos os registros removidos) a cada execução.
- Os dados brutos dos arquivos CSV são importados integralmente via `BULK INSERT`.

Isso garante que a camada Bronze sempre reflita o estado atual dos arquivos de origem.

## Fontes de Dados

| Sistema | Tabelas |
|---------|---------|
| **CRM** | `bronze.crm_cust_info`, `bronze.crm_prd_info`, `bronze.crm_sales_details` |
| **ERP** | `bronze.erp_cust_az12`, `bronze.erp_loc_a101`, `bronze.erp_px_cat_g1v2` |
