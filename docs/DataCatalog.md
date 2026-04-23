# Data Catalog - Camada Gold

## 1. View: `gold.dim_customers`
- **Propósito**: Consolidar as informações cadastrais de clientes provenientes dos sistemas CRM e ERP em uma única dimensão, aplicando padronização de gênero e integrando dados geográficos e de nascimento.

| Nome da Coluna | Datatype | Descrição |
| :--- | :--- | :--- |
| `customer_key` | INT | Surrogate Key (chave substituta) gerada pelo `ROW_NUMBER()` para identificar o registro de forma única no DW. |
| `customer_id` | INT | Identificador original do cliente (cst_id) vindo da camada silver. |
| `customer_number` | NVARCHAR(50) | Código de negócio único do cliente (cst_key). |
| `first_name` | NVARCHAR(50) | Primeiro nome do cliente. |
| `last_name` | NVARCHAR(50) | Sobrenome do cliente. |
| `marital_status` | NVARCHAR(50) | Estado civil padronizado (Married, Single). |
| `gender` | NVARCHAR(50) | Gênero do cliente, consolidado entre CRM e ERP. |
| `birthdate` | DATE | Data de nascimento do cliente no formato **YYYY-MM-DD**. |
| `country` | NVARCHAR(50) | País de residência do cliente. |
| `create_date` | DATE | Data de criação do registro no sistema de origem no formato **YYYY-MM-DD**. |

---

## 2. View: `gold.dim_products`
- **Propósito**: Armazenar os detalhes dos produtos e suas hierarquias de categoria, filtrando apenas os registros vigentes onde a data de fim é nula.

| Nome da Coluna | Datatype | Descrição |
| :--- | :--- | :--- |
| `product_key` | INT | Surrogate Key gerada de forma sequencial para o produto. |
| `product_id` | INT | Identificador interno do produto no CRM. |
| `product_number` | NVARCHAR(50) | Código/chave de negócio do produto (prd_key). |
| `product_name` | NVARCHAR(50) | Nome descritivo do produto. |
| `category_id` | NVARCHAR(50) | Identificador extraído da chave original do produto. |
| `category` | NVARCHAR(50) | Nome da categoria principal. |
| `subcategory` | NVARCHAR(50) | Nome da subcategoria. |
| `maintence` | NVARCHAR(50) | Informações sobre manutenção. |
| `cost` | INT | Custo unitário do produto. |
| `product_line` | NVARCHAR(50) | Linha do produto padronizada (ex: Mountain, Road). |
| `start_date` | DATE | Data de início da vigência do registro no formato **YYYY-MM-DD**. |

---

## 3. View: `gold.fact_sales`
- **Propósito**: Tabela de fatos que registra as transações de vendas, relacionando as dimensões de produto e cliente através de suas chaves substitutas.

| Nome da Coluna | Datatype | Descrição |
| :--- | :--- | :--- |
| `order_number` | NVARCHAR(50) | Número de identificação do pedido de venda. |
| `product_key` | INT | Chave estrangeira que referencia a `gold.dim_products`. |
| `customer_key` | INT | Chave estrangeira que referencia a `gold.dim_customers`. |
| `order_date` | DATE | Data do pedido no formato **YYYY-MM-DD**. |
| `shipping_date` | DATE | Data de envio no formato **YYYY-MM-DD**. |
| `due_date` | DATE | Data de vencimento no formato **YYYY-MM-DD**. |
| `sales_amount` | INT | Valor total da venda. |
| `quantity` | INT | Quantidade vendida. |
| `price` | INT | Preço unitário aplicado. |