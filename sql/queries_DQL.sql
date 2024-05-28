USE CDC;

-- 1. Aceder a identificadores de detetives que estão vinculados a um
-- caso em específico (exemplo: ID do caso = 1), nessa instância.
SELECT * FROM Vinculado
	WHERE Caso = 1 AND DataDesvinculação IS NULL;

-- 2. Aceder a casos onde um detetive em específico (exemplo:
-- ID do detetive = 1) está ativamente vinculado, nessa instância.
SELECT * FROM Vinculado
	WHERE Detetive = 1 AND DataDesvinculação IS NULL;

-- 3. Relatório completo de pagamentos com data, descrição e
-- valor para um caso em específico (exemplo: ID do caso = 1).
SELECT Data, Valor, Descrição FROM Pagamento
	WHERE Caso = 1;

-- 4. Estatísticas de casos abertos, fechados e arquivados numa
-- semana específica (exemplo: de 14/03/2024 a 20/04/2024).
SELECT C.ID, C.DataAbertura, C.DataFechamento, CE.Designação
	FROM Caso AS C
    INNER JOIN CasoEstado AS CE
    ON C.Estado = CE.ID
	WHERE (C.DataAbertura >= '2024-03-14' AND C.DataAbertura <= '2024-04-20')
		OR (C.DataFechamento >= '2024-03-14' AND C.DataFechamento <= '2024-04-20');

-- 5. Apresentar os dados de um caso (exemplo: ID do caso = 1) -
-- evidências, suspeitos e testemunhas - por ordem cronológica.
SELECT * FROM Evidência
	WHERE Caso = 1
	ORDER BY DataColeta ASC;

SELECT S.* FROM Suspeito AS S
	INNER JOIN CasoSuspeito AS CS
    ON CS.Caso = 1
    ORDER BY S.DataRegisto ASC;

SELECT T.* FROM Testemunha AS T
	INNER JOIN CasoTestemunha AS CT
    ON CT.Caso = 1
    ORDER BY T.DataRegisto ASC;

-- 6. Relatório diário de novas evidências, suspeitos e testemunhas
-- de um caso em específico (exemplo: ID do caso = 1 e data = 20/03/2024).

-- 6. versão alternativa
WITH Target AS (
	SELECT
		'2024-03-20' AS Data,
		'1' AS Caso
),
ES AS (
	SELECT
		E.Caso AS E_Caso,
		E.ID AS E_ID,
		E.Tipo AS E_Tipo,
		E.Descrição AS E_Descrição,
		E.Arquivo AS E_Arquivo
	FROM Evidência AS E, Target
		WHERE E.Caso = Target.Caso
			AND E.DataColeta = Target.Data
),
SS AS (
	SELECT
		CS.Caso AS S_Caso,
		S.ID AS S_ID,
		S.Nome AS S_Nome,
		S.Email AS S_Email,
		S.Telefone AS S_Telefone,
		S.DataNascimento AS S_DataNascimento,
		S.Sexo AS S_Sexo,
		S.Morada AS S_Morada,
		S.Descrição AS S_Descrição
	FROM Suspeito AS S, Target
		INNER JOIN CasoSuspeito AS CS
		ON CS.Caso = Target.Caso
		WHERE S.DataRegisto = Target.Data
),
TS AS (
	SELECT
		CT.Caso AS T_Caso,
		T.Nome AS T_Nome,
		T.Email AS T_Email,
		T.Telefone AS T_Telefone,
		T.Morada AS T_Morada
	FROM Testemunha AS T, Target
		INNER JOIN CasoTestemunha AS CT
		ON CT.Caso = Target.Caso
		WHERE T.DataRegisto = Target.Data
),
Result AS (
	SELECT * FROM ES
		LEFT JOIN SS ON ES.E_Caso = SS.S_Caso
		LEFT JOIN TS ON ES.E_Caso = TS.T_Caso
)
SELECT * FROM Result;
