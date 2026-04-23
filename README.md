# SQL Data Warehouse Project

Este projeto consiste na implementação de um Data Warehouse ponta a ponta, utilizando a **Arquitetura Medalhão** (Bronze → Silver → Gold) para transformar dados brutos de sistemas CRM e ERP em informações prontas para análise dimensional.

---

## 📂 Estrutura de Pastas

```
sql-data-warehouse/
├── datasets/               # Arquivos de dados brutos (fontes CRM e ERP)
├── docs/                   # Documentação técnica e Data Catalog
└── scripts/
    ├── init/               # Inicialização: criação do banco e dos schemas
    ├── bronze/             # DDL e Stored Procedure de carga bruta (Truncate & Load)
    ├── silver/             # DDL, Stored Procedure e scripts de transformação dos dados
    │   └── transformations/  # Scripts modulares individuais de transformação (base da procedure)
    ├── gold/               # DDL e Views do modelo dimensional (Star Schema)
    └── checks/             # Scripts de auditoria e qualidade de dados (Data Quality)
        ├── bronze_check/
        ├── silver_check/
        └── gold_check/
```

---

## 🏗️ Arquitetura Medalhão

| Camada | Descrição |
|--------|-----------|
| 🥉 **Bronze** | Ingestão dos dados brutos no SQL Server sem transformação. Carga via `Truncate & Load`. |
| 🥈 **Silver** | Limpeza, padronização de tipos, deduplicação e aplicação de regras de negócio. |
| 🥇 **Gold** | Modelo dimensional (Star Schema) com Views de Fatos e Dimensões, pronto para consumo analítico. |

---

## 🚀 Como Executar

1. **Inicialização** — Execute `scripts/init/init_datawarehouse.sql` para criar o banco e os schemas.
2. **Carga Bronze** — Execute a Stored Procedure 'procedure_load_bronze.sql' em `scripts/bronze/` para importar os dados brutos.
3. **Transformação Silver** — Execute a Stored Procedure 'procedure_load_silver.sql' em `scripts/silver/` para limpeza e padronização.
4. **Camada Analítica Gold** — Execute o script 'ddl_gold.sql' em `scripts/gold/` para criar as Views dimensionais.
5. **Qualidade de Dados** — Utilize os scripts em `scripts/checks/` para verificar cada camada se necessário.

---

## 🛠️ Tecnologias Utilizadas

- **Banco de Dados**: SQL Server (T-SQL)
- **Modelagem**: Arquitetura Medalhão (Medallion Architecture) + Star Schema
- **Ferramenta de Desenvolvimento**: Azure Data Studio / VS Code

---
---

# SQL Data Warehouse Project *(English)*

This project implements an end-to-end Data Warehouse using the **Medallion Architecture** (Bronze → Silver → Gold) to transform raw data from CRM and ERP systems into information ready for dimensional analysis.

---

## 📂 Folder Structure

```
sql-data-warehouse/
├── datasets/               # Raw source data files (CRM and ERP)
├── docs/                   # Technical documentation and Data Catalog
└── scripts/
    ├── init/               # Initialization: database and schema creation
    ├── bronze/             # DDL and Stored Procedure for raw data load (Truncate & Load)
    ├── silver/             # DDL, Stored Procedure and transformation scripts
    │   └── transformations/  # Individual modular transformation scripts (procedure base)
    ├── gold/               # DDL and Views for the dimensional model (Star Schema)
    └── checks/             # Audit and data quality scripts
        ├── bronze_check/
        ├── silver_check/
        └── gold_check/
```

---

## 🏗️ Medallion Architecture

| Layer | Description |
|-------|-------------|
| 🥉 **Bronze** | Ingests raw data into SQL Server without transformation. Loaded via `Truncate & Load`. |
| 🥈 **Silver** | Cleaning, type standardization, deduplication and business rule application. |
| 🥇 **Gold** | Dimensional model (Star Schema) with Fact and Dimension Views, ready for analytical consumption. |

---

## 🚀 How to Run

1. **Initialization** — Run `scripts/init/init_datawarehouse.sql` to create the database and schemas.
2. **Bronze Load** — Run the Stored Procedure 'procedure_load_bronze.sql' in `scripts/bronze/` to import raw data.
3. **Silver Transformation** — Run the Stored Procedure 'procedure_load_silver.sql' in `scripts/silver/` for cleaning and standardization.
4. **Gold Analytical Layer** — Run the script 'ddl_gold.sql' in `scripts/gold/` to create the dimensional Views.
5. **Data Quality** — Use the scripts in `scripts/checks/` to audit each layer if needed.

---

## 🛠️ Technologies Used

- **Database**: SQL Server (T-SQL)
- **Modeling**: Medallion Architecture + Star Schema
- **Development Tool**: SQL Server Management Studio (SSMS)