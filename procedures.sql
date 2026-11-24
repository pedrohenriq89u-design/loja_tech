USE loja_tech;

-- 1. Listar categorias ativas

DROP PROCEDURE IF EXISTS listar_categorias_ativas;

DELIMITER //

CREATE PROCEDURE listar_categorias_ativas()
BEGIN
    SELECT id_categoria, nome, descricao
    FROM categorias
    WHERE ativo = TRUE
    ORDER BY nome ASC;
END //


-- 2. Buscar pedidos por status

DROP PROCEDURE IF EXISTS buscar_pedidos_por_status;

CREATE PROCEDURE buscar_pedidos_por_status(
    IN p_status VARCHAR(20)
)
BEGIN
    SELECT id_pedido, id_cliente, data_pedido, valor_total
    FROM pedidos
    WHERE status = p_status;
END //


-- 3. Inserir uma categoria

DROP PROCEDURE IF EXISTS inserir_categoria;

CREATE PROCEDURE inserir_categoria(
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT
)
BEGIN
    INSERT INTO categorias (nome, descricao)
    VALUES (p_nome, p_descricao);
END //


-- 4. Atualizar telefone do cliente

DROP PROCEDURE IF EXISTS atualizar_telefone_cliente;

CREATE PROCEDURE atualizar_telefone_cliente(
    IN p_id_cliente INT,
    IN p_telefone VARCHAR(15)
)
BEGIN
    UPDATE clientes
    SET telefone = p_telefone
    WHERE id_cliente = p_id_cliente;
END //


-- 5. Contar produtos por categoria

DROP PROCEDURE IF EXISTS contar_produtos_categoria;

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


-- TESTES DAS PROCEDURES

CALL listar_categorias_ativas();

CALL buscar_pedidos_por_status('pendente');

CALL inserir_categoria('Acessórios', 'Produtos e acessórios de tecnologia');

CALL atualizar_telefone_cliente(1, '11999999999');

CALL contar_produtos_categoria(3, @total);

SELECT @total AS total_produtos;