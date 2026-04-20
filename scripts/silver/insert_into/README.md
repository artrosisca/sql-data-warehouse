# Camada Silver - Scripts de Transformação (Insert Into)

Este diretório contém a lógica individual para processar e mover os dados da camada Bronze para a Silver.

## Lógicas de Transformação Aplicadas
* **Limpeza e Padronização**: Remoção de espaços com `TRIM()`, padronização de gênero e estado civil via `CASE WHEN`, e tratamento de textos com `UPPER()`.
* **Tratamento de Datas**: Conversão de formatos numéricos/texto para o tipo `DATE` e gestão de períodos de validade com `LEAD()`.
* **Deduplicação**: Uso de `ROW_NUMBER()` para selecionar o registro mais recente baseado na data de criação.
* **Regras de Negócio**: Validação de integridade financeira, garantindo que o valor de vendas corresponda à multiplicação da quantidade pelo preço.

## Fluxo de Trabalho
Estes scripts servem como base modular para a execução da procedure principal `silver.load_silver`.

# Silver Layer - Transformation Scripts (Insert Into)

This directory contains the individual logic for processing and moving data from the Bronze layer to the Silver layer.

## Applied Transformation Logic
* **Cleaning and Standardization**: Removing spaces with `TRIM()`, standardizing gender and marital status via `CASE WHEN`, and text handling with `UPPER()`.
* **Date Handling**: Converting numeric/text formats to the `DATE` type and managing validity periods using `LEAD()`.
* **Deduplication**: Using `ROW_NUMBER()` to select the most recent record based on the creation date.
* **Business Rules**: Validating financial integrity by ensuring sales values match the quantity multiplied by the price.

## Workflow
These scripts serve as a modular basis for the execution of the main `silver.load_silver` procedure.