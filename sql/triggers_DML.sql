USE CDC;

-- R5: Quando um caso é resolvido ou arquivado o seu estado é atualizado respetivamente, assim como a 
-- data de fechamento e é feita a desvinculação dos seus detetives.
DELIMITER //
CREATE TRIGGER UpdateCasoEstado
AFTER UPDATE ON Caso
FOR EACH ROW
BEGIN
    -- Verifica se o estado do caso foi alterado para "resolvido" ou "arquivado"
    IF NEW.Estado IN (SELECT ID FROM CasoEstado WHERE Designação IN ('resolvido', 'arquivado')) THEN
        -- Atualiza a data de fechamento do caso
        SET NEW.DataFechamento = CURRENT_DATE;

        -- Desvincula os detetives associados ao caso
        UPDATE Vinculado
        SET DataDesvinculação = CURRENT_TIMESTAMP
        WHERE Caso = NEW.ID AND DataDesvinculação IS NULL;
    END IF;
END//
DELIMITER ;



-- R20: Quando um detetive é demitido ou se aposenta o seu atributo "estado" deve ser atualizado respetivamente, 
-- assim como o atributo "data de desvinculação" de todas as suas vinculações a casos.
DELIMITER //

CREATE TRIGGER UpdateDetetiveEstado
AFTER UPDATE ON Detetive
FOR EACH ROW
BEGIN
    -- Verifica se o estado do detetive foi alterado para "demitido" ou "aposentado"
    IF NEW.Estado IN (SELECT ID FROM DetetiveEstado WHERE Designação IN ('demitido', 'aposentado')) THEN
        -- Atualiza a data de desvinculação de todas as suas vinculações a casos
        UPDATE Vinculado
        SET DataDesvinculação = CURRENT_TIMESTAMP
        WHERE Detetive = NEW.ID AND DataDesvinculação IS NULL;
    END IF;
END//

DELIMITER ;