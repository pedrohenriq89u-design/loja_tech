# TechStore — Consultas SQL e Stored Procedures

## 1. Sobre o projeto

Este projeto foi desenvolvido como atividade prática de Banco de Dados, utilizando o **MySQL** e o **MySQL Workbench**.

O cenário utilizado é uma loja fictícia de produtos tecnológicos chamada **TechStore**. O objetivo é praticar consultas SQL e desenvolver Stored Procedures para realizar operações de consulta, inserção, atualização e contagem de dados.

O projeto utiliza o banco de dados `loja_tech` e trabalha principalmente com as tabelas de clientes, produtos, categorias e pedidos.

## 2. Objetivos

O desenvolvimento desta atividade tem como objetivos:

- Praticar comandos básicos de SQL.
- Consultar informações armazenadas no banco de dados.
- Utilizar filtros para encontrar registros específicos.
- Organizar resultados utilizando ordenação.
- Aplicar funções de agregação, como `COUNT()` e `SUM()`.
- Relacionar tabelas utilizando `INNER JOIN`.
- Compreender o funcionamento das Stored Procedures.
- Utilizar parâmetros de entrada (`IN`) e saída (`OUT`).
- Realizar operações de inserção e atualização por meio de procedimentos armazenados.

## 3. Tecnologias utilizadas

| Tecnologia | Utilização |
|---|---|
| MySQL | Sistema de gerenciamento do banco de dados |
| MySQL Workbench | Ambiente para executar e administrar comandos SQL |
| SQL | Linguagem utilizada nas consultas e procedimentos armazenados |
| GitHub | Plataforma para armazenar e apresentar o projeto |

## 4. Banco de dados

O banco utilizado na atividade possui o nome:

`loja_tech`

Ele representa uma loja virtual de produtos tecnológicos.

### Principais tabelas utilizadas

**categorias**

Armazena as categorias dos produtos cadastrados na loja.

Principais campos:
- `id_categoria`: identificador da categoria.
- `nome`: nome da categoria.
- `descricao`: descrição da categoria.
- `ativo`: informa se a categoria está ativa.
- `criado_em`: data de criação do registro.

**produtos**

Armazena os produtos disponíveis na loja.

Principais campos:
- `id_produto`: identificador do produto.
- `id_categoria`: categoria à qual o produto pertence.
- `nome`: nome do produto.
- `descricao`: descrição do produto.
- `preco`: preço do produto.
- `estoque`: quantidade disponível.
- `estoque_minimo`: quantidade mínima de estoque.
- `ativo`: informa se o produto está ativo.

**clientes**

Armazena os dados dos clientes cadastrados.

Principais campos utilizados:
- `id_cliente`: identificador do cliente.
- `nome`: nome do cliente.
- `email`: endereço de e-mail.
- `telefone`: número de telefone.

**pedidos**

Armazena os pedidos realizados pelos clientes.

Principais campos utilizados:
- `id_pedido`: identificador do pedido.
- `id_cliente`: cliente responsável pelo pedido.
- `data_pedido`: data de realização.
- `status`: situação atual do pedido.
- `valor_total`: valor total do pedido.

## 5. Consultas SQL desenvolvidas

Foram desenvolvidas 10 consultas SQL para atender às solicitações da atividade.

### Consulta 1 — Listagem de clientes

Exibe o nome e o e-mail de todos os clientes cadastrados.

```sql
SELECT nome, email
FROM clientes;
```

**Conteúdo aprendido:** utilização do comando `SELECT` para selecionar colunas específicas de uma tabela.

### Consulta 2 — Produtos com preço menor que R$ 500

Exibe o nome e o preço dos produtos que custam menos de R$ 500,00.

```sql
SELECT nome, preco
FROM produtos
WHERE preco < 500;
```

**Conteúdo aprendido:** utilização do `WHERE` para filtrar registros por uma condição.

### Consulta 3 — Pedidos pendentes

Exibe todos os dados dos pedidos que possuem o status pendente.

```sql
SELECT *
FROM pedidos
WHERE status = 'pendente';
```

**Conteúdo aprendido:** filtragem de informações utilizando uma condição de igualdade.

### Consulta 4 — Ordenação de produtos

Exibe o nome e o preço dos produtos, começando pelo mais caro.

```sql
SELECT nome, preco
FROM produtos
ORDER BY preco DESC;
```

**Conteúdo aprendido:** utilização do `ORDER BY` para ordenar resultados. O `DESC` define a ordem decrescente.

### Consulta 5 — Busca por produtos com Monitor no nome

Localiza os produtos que possuem a palavra Monitor em qualquer parte do nome.

```sql
SELECT id_produto, nome, preco
FROM produtos
WHERE nome LIKE '%Monitor%';
```

**Conteúdo aprendido:** utilização do `LIKE` para realizar buscas por partes de um texto. O símbolo `%` representa qualquer sequência de caracteres.

### Consulta 6 — Periféricos com estoque maior que 40

Exibe o nome e a quantidade em estoque dos produtos pertencentes à categoria de periféricos, identificada pelo ID 3, que possuem mais de 40 unidades.

```sql
SELECT nome, estoque
FROM produtos
WHERE id_categoria = 3
AND estoque > 40;
```

**Conteúdo aprendido:** utilização de duas condições com o operador `AND`.

### Consulta 7 — Quantidade total de clientes

Calcula quantos clientes estão cadastrados na tabela.

```sql
SELECT COUNT(*) AS total_clientes
FROM clientes;
```

**Conteúdo aprendido:** utilização da função `COUNT()` para contar registros e do `AS` para definir um nome para a coluna do resultado.

### Consulta 8 — Soma dos valores dos pedidos

Calcula a soma dos valores de todos os pedidos cadastrados.

```sql
SELECT SUM(valor_total) AS faturamento_bruto
FROM pedidos;
```

**Conteúdo aprendido:** utilização da função `SUM()` para somar valores de uma coluna.

### Consulta 9 — Produtos e suas categorias

Exibe o nome de cada produto junto com o nome da categoria correspondente.

```sql
SELECT produtos.nome, categorias.nome AS categoria
FROM produtos
INNER JOIN categorias
ON produtos.id_categoria = categorias.id_categoria;
```

**Conteúdo aprendido:** utilização do `INNER JOIN` para relacionar informações de duas tabelas por meio de uma chave correspondente.

### Consulta 10 — Pedidos da cliente Ana Silva

Exibe o número, o status e o valor total dos pedidos realizados pela cliente Ana Silva.

```sql
SELECT pedidos.id_pedido, pedidos.status, pedidos.valor_total
FROM pedidos
INNER JOIN clientes
ON pedidos.id_cliente = clientes.id_cliente
WHERE clientes.nome = 'Ana Silva';
```

**Conteúdo aprendido:** utilização do `INNER JOIN` em conjunto com o `WHERE` para localizar informações relacionadas a um cliente específico.

## 6. Stored Procedures desenvolvidas

Foram desenvolvidas cinco Stored Procedures.

Uma Stored Procedure é um conjunto de comandos SQL armazenado no banco de dados que pode ser executado sempre que necessário por meio do comando `CALL`.

Elas ajudam a reutilizar comandos, organizar operações e centralizar determinadas funcionalidades dentro do banco de dados.

### 6.1 — listar_categorias_ativas

**Objetivo:** listar todas as categorias que estão ativas.

A procedure retorna:
- ID da categoria.
- Nome.
- Descrição.

Os resultados são organizados em ordem alfabética pelo nome.

```sql
DROP PROCEDURE IF EXISTS listar_categorias_ativas;

DELIMITER //

CREATE PROCEDURE listar_categorias_ativas()
BEGIN
    SELECT id_categoria, nome, descricao
    FROM categorias
    WHERE ativo = TRUE
    ORDER BY nome ASC;
END //

DELIMITER ;
```

**Execução:**

```sql
CALL listar_categorias_ativas();
```

### 6.2 — buscar_pedidos_por_status

**Objetivo:** buscar pedidos de acordo com o status informado.

Recebe um parâmetro de entrada chamado `p_status`.

Retorna:
- ID do pedido.
- ID do cliente.
- Data do pedido.
- Valor total.

```sql
DROP PROCEDURE IF EXISTS buscar_pedidos_por_status;

DELIMITER //

CREATE PROCEDURE buscar_pedidos_por_status(
    IN p_status VARCHAR(20)
)
BEGIN
    SELECT id_pedido, id_cliente, data_pedido, valor_total
    FROM pedidos
    WHERE status = p_status;
END //

DELIMITER ;
```

**Execução:**

```sql
CALL buscar_pedidos_por_status('pendente');
```

Nesse exemplo, são apresentados os pedidos que possuem o status pendente.

### 6.3 — inserir_categoria

**Objetivo:** cadastrar uma nova categoria na tabela `categorias`.

Recebe dois parâmetros:
- `p_nome`: nome da nova categoria.
- `p_descricao`: descrição da nova categoria.

```sql
DROP PROCEDURE IF EXISTS inserir_categoria;

DELIMITER //

CREATE PROCEDURE inserir_categoria(
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT
)
BEGIN
    INSERT INTO categorias (nome, descricao)
    VALUES (p_nome, p_descricao);
END //

DELIMITER ;
```

**Execução:**

```sql
CALL inserir_categoria(
    'Acessórios',
    'Produtos e acessórios de tecnologia'
);
```

### 6.4 — atualizar_telefone_cliente

**Objetivo:** atualizar o telefone de um cliente já cadastrado.

Recebe dois parâmetros:
- `p_id_cliente`: identificador do cliente.
- `p_telefone`: novo número de telefone.

```sql
DROP PROCEDURE IF EXISTS atualizar_telefone_cliente;

DELIMITER //

CREATE PROCEDURE atualizar_telefone_cliente(
    IN p_id_cliente INT,
    IN p_telefone VARCHAR(15)
)
BEGIN
    UPDATE clientes
    SET telefone = p_telefone
    WHERE id_cliente = p_id_cliente;
END //

DELIMITER ;
```

**Execução:**

```sql
CALL atualizar_telefone_cliente(1, '11999999999');
```

Nesse exemplo, o telefone do cliente de ID 1 é atualizado.

### 6.5 — contar_produtos_categoria

**Objetivo:** contar quantos produtos pertencem a uma categoria específica.

Recebe:
- `p_id_categoria`: identificador da categoria.

Retorna:
- `p_total`: quantidade de produtos encontrados.

Essa procedure utiliza os parâmetros `IN` e `OUT`.

```sql
DROP PROCEDURE IF EXISTS contar_produtos_categoria;

DELIMITER //

CREATE PROCEDURE contar_produtos_categoria(
    IN p_id_categoria INT,
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*)
    INTO p_total
    FROM produtos
    WHERE id_categoria = p_id_categoria;
END //

DELIMITER ;
```

**Execução:**

```sql
CALL contar_produtos_categoria(3, @total);

SELECT @total AS total_produtos;
```

O resultado é armazenado na variável `@total` e apresentado por meio do `SELECT`.

## 7. Conceitos importantes utilizados

### SELECT

Utilizado para consultar informações armazenadas nas tabelas.

### WHERE

Permite filtrar registros de acordo com uma condição.

### ORDER BY

Organiza os resultados de uma consulta.

- `ASC`: ordem crescente.
- `DESC`: ordem decrescente.

### LIKE

Permite pesquisar textos utilizando padrões.

### COUNT()

Conta a quantidade de registros encontrados.

### SUM()

Realiza a soma dos valores de uma coluna.

### INNER JOIN

Relaciona duas ou mais tabelas utilizando uma condição de correspondência.

### CREATE PROCEDURE

Cria uma Stored Procedure no banco de dados.

### DROP PROCEDURE IF EXISTS

Remove uma Stored Procedure caso ela já exista. É utilizado antes da criação para permitir que o procedimento seja recriado sem gerar erro por já existir.

### DELIMITER

Altera temporariamente o delimitador utilizado pelo MySQL. É necessário para que os comandos internos da Stored Procedure sejam interpretados corretamente até o encerramento do bloco.

### CALL

Executa uma Stored Procedure que já foi criada.

### IN

Define um parâmetro de entrada, permitindo enviar informações para a procedure.

### OUT

Define um parâmetro de saída, permitindo que a procedure devolva um resultado.

## 8. Como executar o projeto

Para executar o projeto no MySQL Workbench, siga as etapas:

1. Abra o MySQL Workbench.
2. Conecte-se ao servidor MySQL.
3. Certifique-se de que o banco de dados `loja_tech` foi criado e que suas tabelas e dados iniciais estão disponíveis.
4. Abra uma nova aba de consulta SQL.
5. Execute as 10 consultas SQL.
6. Execute o código de criação das cinco Stored Procedures.
7. Execute os comandos `CALL` para testar cada procedure.
8. Confira os resultados apresentados na área de resultados do MySQL Workbench.

**Importante:** o script da atividade utiliza o banco e as tabelas preparados no material da aula. Portanto, é necessário executar a preparação inicial do banco antes das consultas e Stored Procedures.

## 9. Resultados esperados

Ao executar o projeto, será possível:

- Consultar os clientes cadastrados.
- Localizar produtos de acordo com seus preços.
- Consultar pedidos pendentes.
- Organizar produtos por preço.
- Pesquisar produtos pelo nome.
- Encontrar periféricos com estoque elevado.
- Contar a quantidade de clientes.
- Calcular a soma dos valores dos pedidos.
- Relacionar produtos com suas categorias.
- Consultar pedidos de um cliente específico.
- Listar categorias ativas.
- Buscar pedidos pelo status.
- Inserir novas categorias.
- Atualizar telefones de clientes.
- Contar produtos de uma categoria.

Os resultados dependem dos registros existentes no banco de dados.

## 10. Conclusão

A realização desta atividade permitiu colocar em prática conceitos importantes de Banco de Dados utilizando o MySQL.

Com as consultas SQL, foi possível aprender a buscar, filtrar, organizar e relacionar informações de diferentes tabelas. Já com as Stored Procedures, foi possível compreender como armazenar comandos SQL no banco de dados e reutilizá-los por meio de parâmetros.

Dessa forma, o projeto contribuiu para o desenvolvimento dos conhecimentos sobre consultas SQL e procedimentos armazenados, além de proporcionar uma experiência prática com o MySQL Workbench.

## 11. Referências

- Material de aula: **Aula Stored Procedures**.
- Material de atividade: **Atividade Consultas e Stored Procedures**.
- Documentação oficial do MySQL: https://dev.mysql.com/doc/

**Projeto desenvolvido para fins educacionais, utilizando o cenário fictício da loja TechStore.**
