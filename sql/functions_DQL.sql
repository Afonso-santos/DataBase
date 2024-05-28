-- R44: É permitido pelo sistema obter o custo total de um caso, através da soma de todas as despesas relativas ao mesmo.
-- Salários de detetives não estão incluídos.
DELIMITER //
CREATE FUNCTION CustoTotalCaso (ID INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE custo_total DECIMAL(10, 2) DEFAULT 0;
    SELECT COALESCE(0, SUM(Valor)) INTO custo_total FROM Despesa
        WHERE Despesa.Caso = ID;
    RETURN custo_total;
END //
DELIMITER ;
-- SELECT CustoTotalCaso(1) AS CustoTotal;
-- DROP FUNCTION CustoTotalCaso;

-- R45: É permitido pelo sistema obter o rendimento total de um caso, através da soma de todos os pagamentos
-- relativos ao mesmo.
DELIMITER //
CREATE FUNCTION RendimentoTotalCaso (ID INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE rendimento_total DECIMAL(10, 2) DEFAULT 0;
    SELECT COALESCE(0, SUM(Valor)) INTO rendimento_total FROM Pagamento
        WHERE Pagamento.Caso = ID;
    RETURN rendimento_total;
END //
DELIMITER ;
-- SELECT RendimentoTotalCaso(1) AS RendimentoTotal;
-- DROP FUNCTION RendimentoTotalCaso;

-- R46: É permitido pelo sistema obter o lucro/prejuízo de um caso, através da subtração do valor obtido em R45
-- (rendimento) pelo valor obtido em R44 (custo).
DELIMITER //
CREATE FUNCTION LucroCaso (ID INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE lucro_prejuizo DECIMAL(10, 2) DEFAULT 0;
    DECLARE rendimento_total DECIMAL(10, 2) DEFAULT 0;
    DECLARE custo_total DECIMAL(10, 2) DEFAULT 0;

    SET rendimento_total = RendimentoTotalCaso(ID);
    SET custo_total = CustoTotalCaso(ID);

    SET lucro_prejuizo = rendimento_total - custo_total;
    RETURN lucro_prejuizo;
END //
DELIMITER ;
-- SELECT LucroCaso(1) AS Lucro;
-- DROP FUNCTION LucroCaso;
