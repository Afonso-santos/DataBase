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
