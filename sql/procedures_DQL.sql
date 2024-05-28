USE CDC;

-- R11: Os dados relativos de cada caso - evidências, suspeitos e testemunhas - devem ser apresentados por ordem cronológica.
DELIMITER //
CREATE PROCEDURE RelatorioCronologico(IN caso_id INT)
BEGIN
    -- Selecionar evidências do caso
    SELECT 'Evidência' AS Tipo, e.ID AS ID, e.DataColeta AS Data, e.Descrição AS Descrição, e.Arquivo AS Arquivo FROM Evidência AS e
		WHERE e.Caso = caso_id
	    UNION ALL

    -- Selecionar suspeitos do caso
    SELECT 'Suspeito' AS Tipo, s.ID AS ID, NULL AS Data, s.Nome AS Descrição, NULL AS Arquivo FROM Suspeito AS s
		INNER JOIN CasoSuspeito AS cs
		ON (s.ID = cs.Suspeito)
		WHERE cs.Caso = caso_id
        UNION ALL

    -- Selecionar testemunhas do caso
    SELECT 'Testemunha' AS Tipo, t.ID AS ID, NULL AS Data, t.Nome AS Descrição, NULL AS Arquivo FROM Testemunha AS t
		INNER JOIN CasoTestemunha AS ct
        ON (t.ID = ct.Testemunha)
        WHERE ct.Caso = caso_id
        ORDER BY Data;
END //
DELIMITER ;

-- R12:  Dado o identificador do caso, deve ser possível aceder a todos os detetives que já estiveram envolvidos,
-- bem como detetives envolvidos no momento.
DELIMITER //
CREATE PROCEDURE ConsultarDetetivesCaso (IN CasoID INT)
BEGIN
    SELECT * FROM Detetive AS D
        INNER JOIN Vinculado AS V
        ON D.ID = V.Detetive
        WHERE V.Caso = CasoID;
END //
DELIMITER ;

-- R13: O sistema permite a pesquisa de características comuns entre casos,
-- através da pesquisa de descrições nas seguintes entidades: casos, evidências, suspeitos e testemunhas.
DROP PROCEDURE IF EXISTS PesquisaCaracteristicasComuns;
DELIMITER //
CREATE PROCEDURE PesquisaCaracteristicasComuns (IN Input TEXT)
    BEGIN
    SELECT ID, Cliente, Categoria, Estado, Descrição, DataAbertura, DataFechamento FROM Caso
        WHERE Descrição LIKE Input;
    SELECT ID, Caso, Tipo, DataColeta, Descrição, Arquivo FROM Evidência
        WHERE Descrição LIKE Input;
    SELECT ID, Nome, Email, Telefone, DataNascimento, Sexo, Morada, Descrição FROM Suspeito
        WHERE Descrição LIKE Input;
END //
DELIMITER ;
-- CALL PesquisaCaracteristicasComuns('1');

-- R21: Os dados relativos a um detetive devem ser acedidos através do seu identificador único.
DELIMITER //
CREATE PROCEDURE InfoDetetive (IN ID INT)
BEGIN
    SELECT * FROM Detetive
        WHERE Detetive.ID = ID;
END //
DELIMITER ;

-- R47: É permitido pelo sistema obter todas as despesas efetuadas por um detetive em diferentes casos em que este participou.
DELIMITER //
CREATE PROCEDURE DespesasPorDetetive (IN detetive_id INT)
BEGIN
    SELECT d.* FROM Despesa AS d
        INNER JOIN Vinculado AS v
        ON (d.Caso = v.Caso)
        WHERE v.Detetive = detetive_id;
END //
DELIMITER ;

-- R48: É permitido pelo sistema obter todos os pagamentos efetuados por um cliente em diferentes casos.
DELIMITER //
CREATE PROCEDURE PagamentosPorCliente (IN cliente_id INT)
BEGIN
    SELECT p.* FROM Pagamento AS p
        INNER JOIN Caso AS c
	    ON (p.Caso = c.ID)
        WHERE c.Cliente = cliente_id;
END //
DELIMITER ;

-- R49: No encerramento de cada dia, o sistema deverá gerar um relatório que inclua todas as despesas e pagamentos efetuados.
-- Este deve apresentar individualmente cada despesa e pagamento, se existirem, por caso. Adicionalmente, o relatório deve fornecer
-- o somatório total de despesas, pagamentos, bem como os lucros ou prejuízos acumulados nesse dia.

-- R50: No encerramento de cada dia, o sistema deverá gerar um relatório para cada caso que inclua novas evidências, testemunhas e suspeitos.

-- R51: No encerramento de cada semana, o sistema deverá gerar um relatório com informações e estatísticas relativas a novos casos abertos, fechados e/ou arquivados.

