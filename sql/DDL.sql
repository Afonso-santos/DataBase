CREATE SCHEMA IF NOT EXISTS CDC DEFAULT CHARACTER SET utf8;
USE CDC;

CREATE TABLE IF NOT EXISTS DetetiveEspecialidade (
    ID INT NOT NULL,
    Designação VARCHAR(75) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS DetetiveEstado (
    ID INT NOT NULL,
    Designação VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Detetive (
    ID INT NOT NULL,
    Especialidade INT NOT NULL,
    Estado INT NOT NULL,
    Nome VARCHAR(150) NOT NULL,
    Email VARCHAR(320) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    DataNascimento DATE NOT NULL,
    Morada VARCHAR(250) NULL,
    Salário DECIMAL(10,2) NOT NULL,
    DataContratação DATE NOT NULL,
    DataFimContratação DATE NULL,
    Efetivo BIT(1) NOT NULL,
    PRIMARY KEY (ID),
    INDEX fk_Detetive_DetetiveEspecialidade1_idx (Especialidade ASC) VISIBLE,
    INDEX fk_Detetive_DetetiveEstado1_idx (Estado ASC) VISIBLE,
    CONSTRAINT fk_Detetive_DetetiveEspecialidade1
        FOREIGN KEY (Especialidade)
        REFERENCES DetetiveEspecialidade (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_Detetive_DetetiveEstado1
        FOREIGN KEY (Estado)
        REFERENCES DetetiveEstado (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS EvidênciaTipo (
    ID INT NOT NULL,
    Designação VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS CasoCategoria (
    ID INT NOT NULL,
    Designação VARCHAR(75) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS CasoEstado (
    ID INT NOT NULL,
    Designação VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Cliente (
    ID INT NOT NULL,
    Nome VARCHAR(150) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(320) NULL,
    Morada VARCHAR(250) NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Caso (
    ID INT NOT NULL,
    Cliente INT NOT NULL,
    Categoria INT NOT NULL,
    Estado INT NOT NULL,
    Descrição TEXT(2000) NOT NULL,
    DataAbertura DATE NOT NULL,
    DataFechamento DATE NULL,
    PRIMARY KEY (ID),
    INDEX fk_Caso_CasoCategoria1_idx (Categoria ASC) VISIBLE,
    INDEX fk_Caso_CasoEstado1_idx (Estado ASC) VISIBLE,
    INDEX fk_Caso_Cliente1_idx (Cliente ASC) VISIBLE,
    CONSTRAINT fk_Caso_CasoCategoria1
        FOREIGN KEY (Categoria)
        REFERENCES CasoCategoria (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_Caso_CasoEstado1
        FOREIGN KEY (Estado)
        REFERENCES CasoEstado (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_Caso_Cliente1
        FOREIGN KEY (Cliente)
        REFERENCES Cliente (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS Evidência (
    ID INT NOT NULL,
    Caso INT NOT NULL,
    Tipo INT NOT NULL,
    DataColeta DATE NOT NULL,
    Descrição TEXT(1000) NOT NULL,
    Arquivo VARCHAR(300) NULL,
    PRIMARY KEY (ID),
    INDEX fk_Evidência_EvidênciaTipo1_idx (Tipo ASC) VISIBLE,
    INDEX fk_Evidência_Caso1_idx (Caso ASC) VISIBLE,
    CONSTRAINT fk_Evidência_EvidênciaTipo1
        FOREIGN KEY (Tipo)
        REFERENCES EvidênciaTipo (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_Evidência_Caso1
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS Vinculado (
    Detetive INT NOT NULL,
    Caso INT NOT NULL,
    DataVinculação DATETIME NOT NULL,
    DataDesvinculação DATETIME NULL,
    Descrição TEXT(400) NOT NULL,
    PRIMARY KEY (Detetive, Caso, DataVinculação),
    INDEX fk_Vinculado_Caso1_idx (Caso ASC) VISIBLE,
    CONSTRAINT fk_Vinculado_Detetive1
        FOREIGN KEY (Detetive)
        REFERENCES Detetive (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_Vinculado_Caso1
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS Suspeito (
    ID INT NOT NULL,
    Nome VARCHAR(150) NOT NULL,
    Email VARCHAR(320) NULL,
    Telefone VARCHAR(20) NULL,
    DataNascimento DATE NULL,
    Sexo CHAR(1) NULL,
    Morada VARCHAR(250) NULL,
    Descrição TEXT(1000) NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS CasoSuspeito (
    Caso INT NOT NULL,
    Suspeito INT NOT NULL,
    INDEX fk_CasoSuspeito_Suspeito1_idx (Suspeito ASC) VISIBLE,
    PRIMARY KEY (Caso, Suspeito),
    CONSTRAINT fk_CasoSuspeito_Suspeito1
        FOREIGN KEY (Suspeito)
        REFERENCES Suspeito (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_CasoSuspeito_Caso1
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS Pagamento (
    Caso INT NOT NULL,
    Descrição TEXT(300) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Data DATE NOT NULL,
    PRIMARY KEY (Caso, Descrição(300), Valor, Data),
    CONSTRAINT fk_Pagamento_Caso1
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS Testemunha (
    ID INT NOT NULL,
    Nome VARCHAR(150) NOT NULL,
    Email VARCHAR(320) NULL,
    Telefone VARCHAR(20) NULL,
    Morada VARCHAR(250) NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS CasoTestemunha (
    Caso INT NOT NULL,
    Testemunha INT NOT NULL,
    INDEX fk_CasoTestemunha_Caso1_idx (Caso ASC) VISIBLE,
    PRIMARY KEY (Caso, Testemunha),
    CONSTRAINT fk_CasoTestemunha_Caso1
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT fk_CasoTestemunha_Testemunha1
        FOREIGN KEY (Testemunha)
        REFERENCES Testemunha (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS Despesa (
    Caso INT NOT NULL,
    Descrição TEXT(300) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Data DATE NOT NULL,
    PRIMARY KEY (Caso, Descrição(300), Valor, Data),
    CONSTRAINT fk_Pagamento_Caso10
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
