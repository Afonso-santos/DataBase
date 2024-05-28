DELIMITER //
CREATE VIEW CasosAtivos AS
    SELECT
        C.ID AS CasoID,
        C.Descrição,
        C.DataAbertura,
        CC.Designação AS Categoria,
        CL.Nome AS 'Nome do cliente',
        CL.Telefone AS 'Telefone do cliente',
        CL.Email AS 'Email do cliente'
    FROM Caso AS C
    INNER JOIN Cliente AS CL
    ON C.Cliente = CL.ID
    INNER JOIN CasoCategoria AS CC
    ON C.Categoria = CC.ID
    WHERE
        C.Estado = 1; -- 'aberto'
//
DELIMITER ;

DELIMITER //
CREATE VIEW DetetivesAtivos AS
    SELECT
        D.ID AS DetetiveID,
        D.Nome,
        D.Email,
        D.Telefone,
        D.DataNascimento,
        D.Morada,
        D.Salário,
        D.DataContratação,
        D.Efetivo,
        DE.Designação AS Especialidade
    FROM Detetive AS D
    JOIN DetetiveEspecialidade AS DE
    ON D.Especialidade = DE.ID
    WHERE
        D.Estado = 1; -- 'contratado'
//
DELIMITER ;

DELIMITER //
CREATE VIEW TodosSuspeitos AS
    SELECT * FROM Suspeito;
//
DELIMITER ;
