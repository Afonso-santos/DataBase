USE CDC;

-- Povoar tabela CasoEstado (Requisito 3)
INSERT INTO CasoEstado (ID, Designação) VALUES
    (1, 'aberto'),
    (2, 'resolvido'),
    (3, 'arquivado');

-- Povoar tabela CasoCategoria (Requisito 4)
INSERT INTO CasoCategoria (ID, Designação) VALUES
    (1, 'Criminal'),
    (2, 'Civil'),
    (3, 'Financeiro'),
    (4, 'Cibernético'),
    (5, 'Laboral'),
    (6, 'Administrativo'),
    (7, 'Ético');

-- Povoar tabela DetetiveEspecialidade (Requisito 16)
INSERT INTO DetetiveEspecialidade (ID, Designação) VALUES
    (1, 'Investigação e descoberta de esquemas de fraude'),
    (2, 'Investigações de natureza jurídica'),
    (3, 'Busca e apreensão'),
    (4, 'Serviços corporativos'),
    (5, 'Aplicativo espião sobre identidades particulares'),
    (6, 'Aplicativo espião sobre identidades cooperativas'),
    (7, 'Detetive particular criminalista'),
    (8, 'Investigações cibernéticas');

-- Povoar tabela DetetiveEstado (Requisito 17)
INSERT INTO DetetiveEstado (ID, Designação) VALUES
    (1, 'contratado'),
    (2, 'demitido'),
    (3, 'aposentado');

-- Povoar tabela EvidênciaTipo (Requisito 36)
INSERT INTO EvidênciaTipo (ID, Designação) VALUES
    (1, 'testemunhal'),
    (2, 'documental'),
    (3, 'pericial'),
    (4, 'indicial'),
    (5, 'real');

-- Povoar tabela Cliente
INSERT INTO Cliente (ID, Nome, Telefone, Email, Morada) VALUES
    (1, 'Cliente 1', '123456789', 'cliente1@example.com', 'Morada 1'),
    (2, 'Cliente 2', '987654321', 'cliente2@example.com', 'Morada 2');

-- Povoar tabela Caso
INSERT INTO Caso (ID, Cliente, Categoria, Estado, Descrição, DataAbertura, DataFechamento) VALUES
    (1, 1, 1, 1, 'Descrição do Caso 1', '2023-01-01', NULL),
    (2, 1, 2, 2, 'Descrição do Caso 2', '2023-02-01', NULL),
    (3, 2, 3, 3, 'Descrição do Caso 3', '2023-03-01', NULL),
    (4, 2, 4, 1, 'Descrição do Caso 4', '2023-04-01', NULL),
    (5, 1, 5, 2, 'Descrição do Caso 5', '2023-05-01', NULL),
    (6, 1, 1, 3, 'Descrição do Caso 6', '2023-06-01', NULL);

-- Povoar tabela Pagamento
INSERT INTO Pagamento (Caso, Descrição, Valor, Data) VALUES
    (1, 'Pagamento 1 do Caso 1', 100.00, '2023-01-05'),
    (2, 'Pagamento 1 do Caso 2', 200.00, '2023-02-05'),
    (2, 'Pagamento 2 do Caso 2', 150.00, '2023-03-05');

-- Povoar tabela Despesa
INSERT INTO Despesa (Caso, Descrição, Valor, Data) VALUES
    (1, 'Despesa 1 do Caso 1', 50.00, '2023-01-10'),
    (1, 'Despesa 2 do Caso 1', 60.00, '2023-01-17'),
    (2, 'Despesa 1 do Caso 2', 75.00, '2023-02-10');

-- Povoar tabela Evidência
INSERT INTO Evidência (ID, Caso, Tipo, DataColeta, Descrição, Arquivo) VALUES
    (1, 1, 1, '2023-01-02', 'Evidência 1 do Caso 1', NULL),
    (2, 1, 2, '2023-01-03', 'Evidência 2 do Caso 1', NULL),
    (3, 2, 1, '2023-02-02', 'Evidência 1 do Caso 2', NULL),
    (4, 2, 3, '2023-02-03', 'Evidência 2 do Caso 2', NULL),
    (5, 3, 2, '2023-03-02', 'Evidência 1 do Caso 3', NULL),
    (6, 3, 1, '2023-03-03', 'Evidência 2 do Caso 3', NULL),
    (7, 5, 1, '2023-05-02', 'Evidência 1 do Caso 5', NULL);

-- Povoar tabela Detetive com 4 detetives e 1 estagiário
INSERT INTO Detetive (ID, Especialidade, Estado, Nome, Email, Telefone, DataNascimento, Morada, Salário, DataContratação, DataFimContratação, Efetivo) VALUES
    (1, 1, 1, 'Detetive 1', 'detetive1@example.com',  '111111111', '1980-01-01', 'Morada 1', 5000.00, '2020-01-01', NULL, 1),
    (2, 2, 1, 'Detetive 2', 'detetive2@example.com',  '222222222', '1985-02-02', 'Morada 2', 4500.00, '2019-02-02', NULL, 1),
    (3, 3, 1, 'Detetive 3', 'detetive3@example.com',  '333333333', '1990-03-03', 'Morada 3', 4800.00, '2018-03-03', NULL, 1),
    (4, 4, 1, 'Detetive 4', 'detetive4@example.com',  '444444444', '1995-04-04', 'Morada 4', 4600.00, '2021-04-04', NULL, 1),
    (5, 1, 1, 'Estagiário', 'estagiario@example.com', '555555555', '2000-05-05', 'Morada 5', 1500.00, '2022-05-05', NULL, 0);

-- Povoar tabela Vinculado
INSERT INTO Vinculado (Detetive, Caso, DataVinculação, DataDesvinculação, Descrição) VALUES
    (1, 1, '2023-01-01 10:00:00', NULL, 'Detetive 1 vinculado ao Caso 1'),
    (2, 1, '2023-01-01 10:00:00', NULL, 'Detetive 2 vinculado ao Caso 1'),
    (3, 1, '2023-01-01 10:00:00', NULL, 'Detetive 3 vinculado ao Caso 1'),
    (2, 2, '2023-02-01 11:00:00', NULL, 'Detetive 2 vinculado ao Caso 2'),
    (4, 2, '2023-02-01 11:00:00', NULL, 'Detetive 4 vinculado ao Caso 2'),
    (3, 3, '2023-03-01 12:00:00', NULL, 'Detetive 3 vinculado ao Caso 3'),
    (1, 5, '2023-05-01 14:00:00', NULL, 'Detetive 1 vinculado ao Caso 5'),
    (2, 6, '2023-06-01 15:00:00', NULL, 'Detetive 2 vinculado ao Caso 6');

-- Povoar tabela Suspeito
INSERT INTO Suspeito (ID, Nome, Email, Telefone, DataNascimento, Sexo, Morada, Descrição, DataRegisto) VALUES
    (1, 'Suspeito 1', 'suspeito1@example.com', '666666666', '1990-06-06', 'M', 'Morada Suspeito 1', 'Descrição Suspeito 1', CURRENT_DATE()),
    (2, 'Suspeito 2', 'suspeito2@example.com', '777777777', '1985-07-07', 'F', 'Morada Suspeito 2', 'Descrição Suspeito 2', CURRENT_DATE());

-- Povoar tabela CasoSuspeito
INSERT INTO CasoSuspeito (Caso, Suspeito) VALUES
    (1, 1),
    (2, 1),
    (2, 2);

-- Povoar tabela Testemunha
INSERT INTO Testemunha (ID, Nome, Email, Telefone, Morada, DataRegisto) VALUES
    (1, 'Testemunha 1', 'testemunha1@example.com', '888888888', 'Morada Testemunha 1', CURRENT_DATE()),
    (2, 'Testemunha 2', 'testemunha2@example.com', '999999999', 'Morada Testemunha 2', CURRENT_DATE());

-- Povoar tabela CasoTestemunha
INSERT INTO CasoTestemunha (Caso, Testemunha) VALUES
    (1, 1),
    (2, 2);
