USE loja_tech;

-- 1. Listagem básica de clientes
SELECT nome, email
FROM clientes;


-- 2. Produtos com preço abaixo de R$ 500
SELECT nome, preco
FROM produtos
WHERE preco < 500;


-- 3. Pedidos com status pendente
SELECT *
FROM pedidos
WHERE status = 'pendente';


-- 4. Produtos do mais caro para o mais barato
SELECT nome, preco
FROM produtos
ORDER BY preco DESC;


-- 5. Produtos que possuem Monitor no nome
SELECT id_produto, nome, preco
FROM produtos
WHERE nome LIKE '%Monitor%';


-- 6. Periféricos com estoque acima de 40 unidades
SELECT nome, estoque
FROM produtos
WHERE id_categoria = 3
AND estoque > 40;


-- 7. Quantidade total de clientes
SELECT COUNT(*) AS total_clientes
FROM clientes;


-- 8. Soma do valor de todos os pedidos
SELECT SUM(valor_total) AS faturamento_bruto
FROM pedidos;


-- 9. Produtos e suas respectivas categorias
SELECT
    produtos.nome AS produto,
    categorias.nome AS categoria
FROM produtos
INNER JOIN categorias
ON produtos.id_categoria = categorias.id_categoria;


-- 10. Pedidos realizados pela cliente Ana Silva
SELECT
    pedidos.id_pedido,
    pedidos.status,
    pedidos.valor_total
FROM pedidos
INNER JOIN clientes
ON pedidos.id_cliente = clientes.id_cliente
WHERE clientes.nome = 'Ana Silva';