# Gold Layer — Dimensional Model

This directory contains the scripts that define the **analytical layer** of the Data Warehouse, implementing a dimensional model following the **Star Schema** pattern.

## Files

| File | Description |
|------|-------------|
| `ddl_gold.sql` | DDL definition of the Gold layer Views. |
| `dim_customers.sql` | View `gold.dim_customers`: customer dimension with Surrogate Key. |
| `dim_products.sql` | View `gold.dim_products`: product dimension with Surrogate Key. |
| `fact_sales.sql` | View `gold.fact_sales`: sales fact table relating customers and products. |

## Dimensional Model (Star Schema)

![Star Schema](../../docs/DataMart(StarSchema).png)

```
         dim_customers
              |
fact_sales ---+--- dim_products
```

Views use **Surrogate Keys** (`ROW_NUMBER()`) as identifiers independent from source systems, ensuring stability and traceability in the analytical model.

For column details and table definitions, see the [Data Catalog](../../docs/DataCatalog.md).

## Features

- Implemented as SQL Server **Views**, without additional materialization.
- Surrogate Keys generated via `ROW_NUMBER() OVER (ORDER BY ...)`.
- Ready for consumption by BI tools (Power BI, Tableau, etc.).

---
---

# Camada Gold — Modelo Dimensional *(Português)*

Este diretório contém os scripts que definem a **camada analítica** do Data Warehouse, implementando um modelo dimensional no padrão **Star Schema** (Esquema Estrela).

## Arquivos

| Arquivo | Descrição |
|---------|-----------|
| `ddl_gold.sql` | Definição (DDL) das Views da camada Gold. |
| `dim_customers.sql` | View `gold.dim_customers`: dimensão de clientes com Surrogate Key. |
| `dim_products.sql` | View `gold.dim_products`: dimensão de produtos com Surrogate Key. |
| `fact_sales.sql` | View `gold.fact_sales`: tabela fato de vendas relacionando clientes e produtos. |

## Modelo Dimensional (Star Schema)

![Star Schema](../../docs/DataMart(StarSchema).png)

```
         dim_customers
              |
fact_sales ---+--- dim_products
```

As Views utilizam **Surrogate Keys** (`ROW_NUMBER()`) para identificadores independentes dos sistemas de origem, garantindo estabilidade e rastreabilidade no modelo analítico.

Para detalhes das colunas e definições das tabelas, consulte o [Data Catalog](../../docs/DataCatalog.md).

## Características

- Implementado como **Views** SQL Server, sem materialização adicional.
- Chaves substitutas (Surrogate Keys) geradas via `ROW_NUMBER() OVER (ORDER BY ...)`.
- Pronto para consumo por ferramentas de BI (Power BI, Tableau, etc.).
