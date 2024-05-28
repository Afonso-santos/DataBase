-- R33: Uma desvinculação de um detetive a um caso, sejam os motivos aposentamento/demissão/remoção do
-- detetive, deve atualizar o atributo "data de desvinculção".
DELIMITER //

CREATE PROCEDURE DesvincularDetetive (IN detetive_id INT, IN caso_id INT, IN descrição_desv TEXT(400))
BEGIN
    UPDATE Vinculado
    SET DataDesvinculação = CURRENT_TIMESTAMP,
        Descrição = descrição_desv
    WHERE Detetive = detetive_id
        AND Caso = caso_id
        AND DataDesvinculação IS NULL;
END //

DELIMITER ;
-- CALL DesvincularDetetive(1, 1, 'Aposentamento');
-- SELECT * FROM Vinculado WHERE Detetive = 1 AND Caso = 1;

-- Procedimento que cria um novo cliente e um caso associado
-- a esse cliente, recorrendo a uma transação.
USE CDC;

DELIMITER //
CREATE PROCEDURE CriaClienteECaso (
    IN cliente_nome VARCHAR(150),
    IN cliente_telefone VARCHAR(20),
    IN cliente_email VARCHAR(320),
    IN cliente_morada VARCHAR(250),
    IN caso_categoria INT,
    IN caso_descrição TEXT(2000)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK; -- Rollback in case of error
    END;

    START TRANSACTION;
    
    SET @cliente_id = (SELECT COALESCE(MAX(ID) + 1, 1) FROM Cliente);

    INSERT INTO Cliente (ID, Nome, Telefone, Email, Morada)
    VALUES (@cliente_id, cliente_nome, cliente_telefone, cliente_email, cliente_morada);

    INSERT INTO Caso (Cliente, Categoria, Estado, Descrição, DataAbertura, DataFechamento)
    VALUES (@cliente_id, caso_categoria, 1, caso_descrição, CURRENT_TIMESTAMP, NULL);
    -- Estado 1: 'aberto'

    COMMIT; -- Commit the transaction if no error occurred
END //
DELIMITER ;

-- DROP PROCEDURE CriaClienteECaso;
-- CALL CriaClienteECaso('João', '912345678', 'joao@example.com', 'Rua do João', 1, 'Descrição do caso teste');
-- SELECT * FROM Cliente ORDER BY ID DESC LIMIT 1;
-- SELECT * FROM Caso ORDER BY ID DESC LIMIT 1;
