# Verificações de Qualidade de Dados (Data Quality)

Este diretório contém scripts SQL dedicados à **validação e auditoria** dos dados em cada camada do pipeline ETL, garantindo integridade e consistência antes do avanço para a próxima etapa.

## Estrutura de Pastas

| Pasta | Descrição |
|-------|-----------|
| `bronze_check/` | Validações na camada Bronze: nulos em chaves primárias, duplicatas e espaços em branco indesejados nos dados de origem. |
| `silver_check/` | Validações na camada Silver: verificação de que as transformações (padronização, cálculos e limpeza) foram aplicadas corretamente. |
| `gold_check/` | Validações na camada Gold: integridade referencial entre Fatos e Dimensões, verificando registros órfãos nos joins. |

## Scripts por Camada

**Bronze** (6 scripts):
- `crm_cust_info`, `crm_prd_info`, `crm_sales_details`
- `erp_cust_az12`, `erp_loc_a101`, `erp_px_cat_g1v2`

**Silver** (5 scripts):
- `crm_cust_info`, `crm_prd_info`, `crm_sales_details`
- `erp_cust_az12`, `erp_loc_a101`

**Gold** (1 script):
- `dimension_table_join_check` — verifica se os joins entre fatos e dimensões retornam registros nulos.

## Objetivo

Garantir que apenas dados íntegros e confiáveis avancem pelo pipeline, prevenindo inconsistências no modelo analítico final.

---
---

# Data Quality Checks *(English)*

This directory contains SQL scripts dedicated to **validating and auditing** data at each layer of the ETL pipeline, ensuring integrity and consistency before advancing to the next step.

## Folder Structure

| Folder | Description |
|--------|-------------|
| `bronze_check/` | Bronze layer validations: nulls in primary keys, duplicates and unwanted whitespace in source data. |
| `silver_check/` | Silver layer validations: verifying that transformations (standardization, calculations and cleaning) were correctly applied. |
| `gold_check/` | Gold layer validations: referential integrity between Facts and Dimensions, checking for orphaned records in joins. |

## Scripts per Layer

**Bronze** (6 scripts):
- `crm_cust_info`, `crm_prd_info`, `crm_sales_details`
- `erp_cust_az12`, `erp_loc_a101`, `erp_px_cat_g1v2`

**Silver** (5 scripts):
- `crm_cust_info`, `crm_prd_info`, `crm_sales_details`
- `erp_cust_az12`, `erp_loc_a101`

**Gold** (1 script):
- `dimension_table_join_check` — checks whether joins between facts and dimensions return null records.

## Objective

Ensure that only reliable and consistent data progresses through the pipeline, preventing inconsistencies in the final analytical model.