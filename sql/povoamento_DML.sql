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
INSERT INTO Cliente (Nome, Telefone, Email, Morada) VALUES
    ('Manuel Alves', '911882553', 'manuel1974@example.com', 'Rua das Amoreiras, 74'),
    ('Catarina Rodrigues', '963417253', 'catrodrigues@example.com', 'Bairro das Tulipas, 707'),
    ('Diana Costa', '912345678', 'dianacosta@example.com', 'Rua de Santa Marinha, 10'),
    ('Margarida Dias', '934567890', 'guidadias@example.com', 'Avenida do Pico, 93'),
    ('Rui Gomes', '915678901', 'gomesrui@example.com', 'Alameda de Covas, 10'),
    ('Joana Albuquerque', '913789422', 'joana12alb@example.com', 'Avenida da Paz, 3');

-- Povoar tabela Caso
INSERT INTO Caso (ID, Cliente, Categoria, Estado, Descrição, DataAbertura, DataFechamento) VALUES
    (1, 1, 1, 1, 'Assalto à residência', '2024-02-23', NULL),
    (2, 1, 2, 2, 'Disputa de propriedade de terras', '2022-05-25', '2022-06-10'),
    (3, 2, 3, 3, 'Evasão fiscal', '2024-03-09', '2024-05-27'),
    (4, 3, 4, 1, 'Ataque de phishing', '2024-04-12', NULL),
    (5, 4, 5, 2, 'Violação de direitos trabalhistas', '2023-02-06', '2023-02-20'),
    (6, 5, 1, 3, 'Investigação de homicídio', '2023-12-01', '2024-01-11'),
	(7, 6, 6, 1, 'Corrupção administrativa', '2024-04-21', NULL);
    

-- Povoar tabela Pagamento
INSERT INTO Pagamento (Caso, Descrição, Valor, Data) VALUES
    (1, 'Pagamento: Análise Forense', 100.00, '2024-03-01'),
    (2, 'Pagamento: Custos de Deslocação', 200.00, '2022-06-10'),
    (2, 'Pagamento: Investigação de Registos de Propriedade', 153.30, '2022-06-10'),
	(3, 'Pagamento: Consultoria Fiscal', 125.00, '2023-03-28'),
    (4, 'Pagamento: Vigilância das Atividades Online', 357.50, '2024-04-20'),
    (5, 'Pagamento: Coleta de Provas Documentais', 150.00, '2024-02-12'),
    (6, 'Pagamento: Análise Forense', 120.50, '2023-12-05'),
    (6, 'Pagamento: Consulta de Registos Policiais', 190.30, '2023-12-30'),
    (7, 'Pagamento: Investigação de Registos Administrativos', 157.50, '2024-04-28');
    
-- Povoar tabela Despesa
INSERT INTO Despesa (Caso, Descrição, Valor, Data) VALUES
	(1, 'Análise Forense', 100.00, '2024-02-24'),
    (2, 'Custos de Deslocação', 200.00, '2022-05-31'),
    (2, 'Investigação de Registos de Propriedade', 153.30, '2022-06-02'),
	(3, 'Consultoria Fiscal', 125.00, '2023-03-14'),
    (4, 'Vigilância das Atividades Online', 357.50, '2024-04-15'),
    (5, 'Coleta de Provas Documentais', 150.00, '2024-02-08'),
    (6, 'Análise Forense', 120.50, '2023-12-02'),
    (6, 'Consulta de Registos Policiais', 190.30, '2023-12-27'),
    (7, 'Investigação de Registos Administrativos', 157.50, '2024-04-24');

-- Povoar tabela Evidência
INSERT INTO Evidência (ID, Caso, Tipo, DataColeta, Descrição, Arquivo) VALUES
    (1, 1, 1, '2024-02-24', 'Depoimento dos vizinhos que testemunharam o assalto', 'https://cdc.com/detetetive-1/dep1.mp3'),
	(2, 1, 3, '2024-02-26', 'Relatório sobre a análise de impressões digitais', 'https://cdc.com/detetetive-1/relatorio-2.pdf'),
    (3, 2, 2, '2022-06-02', 'Documentos legais antigos relacionados à propriedade', NULL),
    (4, 3, 3, '2023-03-16', 'Relatório de contabilidade forense', 'https://cdc.com/detetetive-2/relatorio-4.pdf'),
    (5, 4, 1, '2024-04-15', 'Depoimento de um funcionário sobre o ataque de phishing', NULL),
    (6, 4, 3, '2024-04-16', 'Relatório de segurança cibernética', 'https://cdc.com/detetetive-5/relatorio-6.pdf'),
	(8, 6, 2, '2024-02-25', 'Fotografia da cena do crime', 'https://cdc.com/detetetive-6/cena-crime8.png'),
    (9, 6, 3, '2024-02-26', 'Relatório sobre a análise de impressões digitais', 'https://cdc.com/detetetive-1/relatorio-9.pdf'),
    (10, 7, 2, '2024-04-25', 'Documentos administrativos indicando irregularidades', NULL);


-- Povoar tabela Detetive com 4 detetives e 1 estagiário
INSERT INTO Detetive (ID, Especialidade, Estado, Nome, Email, Telefone, DataNascimento, Morada, Salário, DataContratação, DataFimContratação, Efetivo) VALUES
    (1, 3, 1, 'Joana Santos', 'joanasantos@example.com',  '912314572', '1980-01-27', 'Alameda do Mar, 7', 4600.00, '2020-02-12', NULL, 1),
    (2, 1, 1, 'Álvaro Torres', 'alvarotorres@example.com',  '967408292', '1985-08-01', 'Praça da Boa Vista, 203', 4500.00, '2022-01-12', NULL, 1),
    (3, 2, 1, 'Miguel Campos', 'miguelcampos@example.com',  '964433021', '1990-07-23', 'Bairro Novo, 34', 4800.00, '2018-06-03', NULL, 1),
    (4, 4, 3, 'António Valadares', 'antoniovaladares@example.com',  '965544236', '1954-08-03', 'Rua dos Lírios, 12', 5000.00, '2017-03-29', '2024-01-26', 1),
    (5, 8, 1, 'Manuela Carvalho', 'manuelacarvalho@example.com',  '960253777', '1997-04-20', 'Bairro do Mar, 10', 4600.00, '2022-05-20', NULL, 1),
    (6, 7, 2, 'Juliana Sousa', 'julianasousa@example.com',  '916572398', '2000-04-27', 'Rua de Castro, 98', 4600.00, '2023-01-01', '2024-05-27', 1),
    (7, 6, 1, 'André Silva', 'andresilva@example.com', '912098467', '2002-05-09', 'Alameda das Rosas, 2', 1500.00, '2024-02-05', NULL, 0);


-- Povoar tabela Vinculado
INSERT INTO Vinculado (Detetive, Caso, DataVinculação, DataDesvinculação, Descrição) VALUES
	(1, 1, '2024-02-23 10:00:00', NULL, 'Detetive Joana Santos - Assalto à residência'),
	(3, 2, '2022-05-25 14:30:00', '2022-06-10 12:00:00', 'Detetive Miguel Campos - Disputa de propriedade de terras'),
    (2, 3, '2023-03-09 17:30:00', '2023-05-27 16:00:00', 'Detetive Álvaro Torres - Evasão Fiscal'),
    (5, 4, '2024-04-12 10:00:00', NULL, 'Detetive Manuela Carvalho - Ataque de phishing'),
    (4, 5, '2023-02-06 09:45:00', '2023-02-20 14:00:00', 'Detetive António Valadares - Violação de direitos trabalhistas'),
    (1, 6, '2023-12-20 12:00:00', '2024-01-11 17:00:00', 'Detetive Joana Santos - Investigação de homicídio'),
    (6, 6, '2023-12-01 12:00:00', '2024-01-11 17:00:00', 'Detetive Juliana Sousa - Investigação de homicídio'),
    (2, 7, '2024-04-21 08:00:00', NULL, 'Detetive Álvaro Torres - Corrupção administrativa');

-- Povoar tabela Suspeito
INSERT INTO Suspeito (ID, Nome, Email, Telefone, DataNascimento, Sexo, Morada, Descrição, DataRegisto) VALUES
    (1, 'Carlos Silva', 'carlossilva@example.com', '912345678', '1988-02-15', 'M', 'Rua das Palmeiras, 123', 'Homem, olhos castanhos, cabelo castanho, altura média, em forma. Suspeito de assalto à residência devido a impressões digitais encontradas na cena do crime.', '2024-02-25'),
    (2, 'Ana Costa', 'anacosta@example.com', '923456789', '1992-05-20', 'F', 'Avenida das Flores, 45', 'Mulher, olhos verdes, cabelo loiro, baixa estatura, jovem. Suspeita de assalto à residência devido a testemunhas que a viram perto do local.', '2024-02-25'),
    (3, 'João Mendes', 'joaomendes@example.com', '956789012', '1975-08-25', 'M', 'Alameda dos Pinhais, 10', 'Homem, olhos verdes, cabelo preto, alto, magro. Suspeito de evasão fiscal devido a documentos falsificados encontrados em sua posse.', '2024-03-10'),
    (4, 'Sofia Almeida', 'sofiaalmeida@example.com', '967890123', '1990-06-14', 'F', 'Rua das Acácias, 33', 'Mulher, olhos castanhos claros, cabelo ruivo, estatura média, jovem. Suspeita de ataque de phishing devido a registros de transações fraudulentas ligadas ao seu computador.', '2024-04-13'),
    (5, 'Fernando Rocha', 'fernandorocha@example.com', '978901234', '1982-07-19', 'M', 'Avenida dos Oceanos, 21', 'Homem, olhos pretos, cabelo preto, estatura média, forte. Suspeito de violação de direitos trabalhistas devido a denúncias de vários empregados.', '2023-02-07'),
    (6, 'Helena Martins', 'helenamartins@example.com', '989012345', '1995-09-22', 'F', 'Rua das Pedras, 55', 'Mulher, olhos azuis, cabelo loiro, estatura média, jovem. Suspeita de violação de direitos trabalhistas devido a participação em reuniões ilegais.', '2023-02-07'),
    (7, 'Ricardo Lopes', 'ricardolopes@example.com', '990123456', '1986-12-02', 'M', 'Bairro da Serra, 77', 'Homem, olhos verdes, cabelo castanho, estatura média, atlético. Suspeito de investigação de homicídio devido a provas de ADN encontradas na cena do crime.', '2023-12-02'),
    (8, 'Patrícia Duarte', 'patriciaduarte@example.com', '991234567', '1981-04-27', 'F', 'Rua do Sol, 99', 'Mulher, olhos castanhos, cabelo preto, estatura média, robusta. Suspeita de corrupção administrativa devido a transferências bancárias suspeitas.', '2024-04-22');


-- Povoar tabela CasoSuspeito
INSERT INTO CasoSuspeito (Caso, Suspeito) VALUES
    (1, 1),
    (1, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (5, 6),
    (6, 7),
    (7, 8);


-- Povoar tabela Testemunha
INSERT INTO Testemunha (ID, Nome, Email, Telefone, Morada, DataRegisto) VALUES
	(1, 'João Ferreira', 'joaoferreira@example.com', '934003983', 'Rua das Palmeiras, 123', '2024-02-24'),
    (2, 'Maria Santos', 'mariasantos@example.com', '912098444', 'Rua das Palmeiras, 123', '2024-02-24'),
    (3, 'Carlos Pereira', 'carlospereira@example.com', '923456822', 'Praça do Comércio, 67', '2024-04-15');

-- Povoar tabela CasoTestemunha
INSERT INTO CasoTestemunha (Caso, Testemunha) VALUES
    (1, 1),
    (1, 2),
    (4, 3);
