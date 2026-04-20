# Verificações de Qualidade de Dados (Data Quality)

Este diretório contém scripts SQL destinados à validação e garantia da qualidade dos dados durante o processo de ETL.

## Estrutura de Pastas
* **/bronze_check/**: Scripts de validação aplicados na camada Bronze para identificar problemas na origem, como nulos, duplicados em chaves primárias e espaços em branco desnecessários.
* **/silver_check/**: Scripts aplicados na camada Silver para garantir que as transformações e limpezas (como padronização de nomes e cálculos de vendas) foram executadas corretamente.

## Objetivo
Assegurar a integridade e consistência dos dados, garantindo que apenas informações confiáveis avancem para as camadas analíticas.

# Data Quality Checks

This directory contains SQL scripts dedicated to validating and ensuring data quality during the ETL process.

## Folder Structure
* **/bronze_check/**: Validation scripts applied to the Bronze layer to identify source issues such as nulls, primary key duplicates, and unnecessary whitespace.
* **/silver_check/**: Scripts applied to the Silver layer to ensure that transformations and cleanups (such as name standardization and sales calculations) were correctly executed.

## Objective
To ensure data integrity and consistency, guaranteeing that only reliable information advances to the analytical layers.