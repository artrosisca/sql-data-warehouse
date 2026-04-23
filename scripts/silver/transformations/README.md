# Camada Silver — Scripts de Transformação

Este diretório contém os scripts SQL **modulares e individuais** com a lógica de transformação por tabela, desenvolvidos como etapa de construção e referência antes da procedure centralizada ser criada.

> **Contexto**: Estes scripts representam a evolução do processo — cada transformação foi primeiro desenvolvida e validada aqui de forma isolada, e depois consolidada na Stored Procedure `silver.load_silver`. Eles servem como documentação viva da lógica aplicada em cada tabela.

## Arquivos

| Arquivo | Tabela de Destino |
|---------|------------------|
| `insert_into_silver_crm_cust_info.sql` | `silver.crm_cust_info` |
| `insert_into_silver_crm_prd_info.sql` | `silver.crm_prd_info` |
| `insert_into_silver_crm_sales_details.sql` | `silver.crm_sales_details` |
| `insert_into_silver_erp_cust_az12.sql` | `silver.erp_cust_az12` |
| `insert_into_silver_erp_loc_a101.sql` | `silver.erp_loc_a101` |
| `insert_into_silver_erp_px_cat_g1v2.sql` | `silver.erp_px_cat_g1v2` |

## Transformações Aplicadas

- **Limpeza e Padronização**: Remoção de espaços com `TRIM()`, padronização de gênero e estado civil via `CASE WHEN`, e tratamento de texto com `UPPER()`.
- **Tratamento de Datas**: Conversão de formatos numéricos/texto para o tipo `DATE` e gestão de períodos de validade com `LEAD()`.
- **Deduplicação**: Uso de `ROW_NUMBER()` para selecionar o registro mais recente baseado na data de criação.
- **Regras de Negócio**: Validação de integridade financeira, garantindo que o valor de vendas corresponda à multiplicação da quantidade pelo preço.

---
---

# Silver Layer — Transformation Scripts *(English)*

This directory contains **individual, modular** SQL scripts with per-table transformation logic, developed as a construction and reference step before the centralized procedure was created.

> **Context**: These scripts represent the process evolution — each transformation was first developed and validated here in isolation, then consolidated into the `silver.load_silver` Stored Procedure. They serve as living documentation of the logic applied to each table.

## Files

| File | Target Table |
|------|-------------|
| `insert_into_silver_crm_cust_info.sql` | `silver.crm_cust_info` |
| `insert_into_silver_crm_prd_info.sql` | `silver.crm_prd_info` |
| `insert_into_silver_crm_sales_details.sql` | `silver.crm_sales_details` |
| `insert_into_silver_erp_cust_az12.sql` | `silver.erp_cust_az12` |
| `insert_into_silver_erp_loc_a101.sql` | `silver.erp_loc_a101` |
| `insert_into_silver_erp_px_cat_g1v2.sql` | `silver.erp_px_cat_g1v2` |

## Applied Transformation Logic

- **Cleaning and Standardization**: Space removal with `TRIM()`, gender and marital status standardization via `CASE WHEN`, and text handling with `UPPER()`.
- **Date Handling**: Converting numeric/text formats to the `DATE` type and managing validity periods using `LEAD()`.
- **Deduplication**: Using `ROW_NUMBER()` to select the most recent record based on the creation date.
- **Business Rules**: Financial integrity validation ensuring sales values match quantity multiplied by price.