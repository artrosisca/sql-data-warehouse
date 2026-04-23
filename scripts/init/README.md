# Inicialização do Data Warehouse

Este diretório contém o script de inicialização do ambiente, responsável por preparar toda a infraestrutura necessária antes da execução do pipeline de dados.

## O que o script faz

O `init_datawarehouse.sql` executa as seguintes etapas em ordem:

1. **Verifica a existência do banco** — se o banco `DataWarehouse` já existir, encerra conexões ativas e o remove.
2. **Cria o banco de dados** — cria um novo banco `DataWarehouse` do zero.
3. **Cria os schemas da Arquitetura Medalhão**:
   - `bronze` — dados brutos ingeridos diretamente das fontes.
   - `silver` — dados limpos e transformados.
   - `gold` — modelo dimensional pronto para análise.

## ⚠️ Atenção

> Este script **destrói e recria** o banco de dados. Execute-o apenas na inicialização do projeto ou em ambientes de desenvolvimento/testes.

---
---

# Data Warehouse Initialization *(English)*

This directory contains the environment initialization script, responsible for preparing all necessary infrastructure before the data pipeline runs.

## What the script does

`init_datawarehouse.sql` executes the following steps in order:

1. **Checks for existing database** — if `DataWarehouse` already exists, it drops active connections and removes it.
2. **Creates the database** — creates a fresh `DataWarehouse` database from scratch.
3. **Creates the Medallion Architecture schemas**:
   - `bronze` — raw data ingested directly from sources.
   - `silver` — cleaned and transformed data.
   - `gold` — dimensional model ready for analysis.

## ⚠️ Warning

> This script **destroys and recreates** the database. Run it only during project initialization or in development/testing environments.
