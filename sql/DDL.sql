CREATE SCHEMA IF NOT EXISTS CDC DEFAULT CHARACTER SET utf8;
USE CDC;

CREATE TABLE IF NOT EXISTS CasoEstado (
    ID INT NOT NULL AUTO_INCREMENT,
    Designação VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS CasoCategoria (
    ID INT NOT NULL AUTO_INCREMENT,
    Designação VARCHAR(75) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS DetetiveEspecialidade (
    ID INT NOT NULL AUTO_INCREMENT,
    Designação VARCHAR(75) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS DetetiveEstado (
    ID INT NOT NULL AUTO_INCREMENT,
    Designação VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS EvidênciaTipo (
    ID INT NOT NULL AUTO_INCREMENT,
    Designação VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Cliente (
    ID INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Email VARCHAR(320) NULL,
    Morada VARCHAR(250) NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Caso (
    ID INT NOT NULL AUTO_INCREMENT,
    Cliente INT NOT NULL,
    Categoria INT NOT NULL,
    Estado INT NOT NULL,
    Descrição TEXT(2000) NOT NULL,
    DataAbertura DATE NOT NULL,
    DataFechamento DATE NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_Caso_Categoria
        FOREIGN KEY (Categoria)
        REFERENCES CasoCategoria (ID),
    CONSTRAINT fk_Caso_Estado
        FOREIGN KEY (Estado)
        REFERENCES CasoEstado (ID),
    CONSTRAINT fk_Caso_Cliente
        FOREIGN KEY (Cliente)
        REFERENCES Cliente (ID)
    -- INDEX fk_Caso_CasoCategoria1_idx (Categoria ASC) VISIBLE,
    -- INDEX fk_Caso_CasoEstado1_idx (Estado ASC) VISIBLE,
    -- INDEX fk_Caso_Cliente1_idx (Cliente ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS Pagamento (
    Caso INT NOT NULL,
    Descrição TEXT(300) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Data DATE NOT NULL,
    PRIMARY KEY (Caso, Descrição(300), Valor, Data),
    CONSTRAINT fk_Pagamento_Caso
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
);

CREATE TABLE IF NOT EXISTS Despesa (
    Caso INT NOT NULL,
    Descrição TEXT(300) NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Data DATE NOT NULL,
    PRIMARY KEY (Caso, Descrição(300), Valor, Data),
    CONSTRAINT fk_Despesa_Caso
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
);

CREATE TABLE IF NOT EXISTS Evidência (
    ID INT NOT NULL AUTO_INCREMENT,
    Caso INT NOT NULL,
    Tipo INT NOT NULL,
    DataColeta DATE NOT NULL,
    Descrição TEXT(1000) NOT NULL,
    Arquivo VARCHAR(300) NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_Evidência_Tipo
        FOREIGN KEY (Tipo)
        REFERENCES EvidênciaTipo (ID),
    CONSTRAINT fk_Evidência_Caso
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
    -- INDEX fk_Evidência_EvidênciaTipo1_idx (Tipo ASC) VISIBLE,
    -- INDEX fk_Evidência_Caso1_idx (Caso ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS Detetive (
    ID INT NOT NULL AUTO_INCREMENT,
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
    Efetivo BIT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (ID),
    CONSTRAINT fk_Detetive_Especialidade
        FOREIGN KEY (Especialidade)
        REFERENCES DetetiveEspecialidade (ID),
    CONSTRAINT fk_Detetive_Estado
        FOREIGN KEY (Estado)
        REFERENCES DetetiveEstado (ID)
    -- INDEX fk_Detetive_DetetiveEspecialidade1_idx (Especialidade ASC) VISIBLE,
    -- INDEX fk_Detetive_DetetiveEstado1_idx (Estado ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS Vinculado (
    Detetive INT NOT NULL,
    Caso INT NOT NULL,
    DataVinculação DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    DataDesvinculação DATETIME NULL,
    Descrição TEXT(400) NOT NULL,
    PRIMARY KEY (Detetive, Caso, DataVinculação),
    CONSTRAINT fk_Vinculado_Detetive
        FOREIGN KEY (Detetive)
        REFERENCES Detetive (ID),
    CONSTRAINT fk_Vinculado_Caso
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
);

CREATE TABLE IF NOT EXISTS Suspeito (
    ID INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL,
    Email VARCHAR(320) NULL,
    Telefone VARCHAR(20) NULL,
    DataNascimento DATE NULL,
    Sexo CHAR(1) NULL CHECK (Sexo IN ('M', 'F') OR Sexo IS NULL),
    Morada VARCHAR(250) NULL,
    Descrição TEXT(1000) NULL,
    DataRegisto DATE NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS CasoSuspeito (
    Caso INT NOT NULL,
    Suspeito INT NOT NULL,
    PRIMARY KEY (Caso, Suspeito),
    CONSTRAINT fk_CasoSuspeito_Suspeito
        FOREIGN KEY (Suspeito)
        REFERENCES Suspeito (ID),
    CONSTRAINT fk_CasoSuspeito_Caso
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID)
    -- INDEX fk_CasoSuspeito_Suspeito1_idx (Suspeito ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS Testemunha (
    ID INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL,
    Email VARCHAR(320) NULL,
    Telefone VARCHAR(20) NULL,
    Morada VARCHAR(250) NULL,
    DataRegisto DATE NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS CasoTestemunha (
    Caso INT NOT NULL,
    Testemunha INT NOT NULL,
    PRIMARY KEY (Caso, Testemunha),
    CONSTRAINT fk_CasoTestemunha_Caso
        FOREIGN KEY (Caso)
        REFERENCES Caso (ID),
    CONSTRAINT fk_CasoTestemunha_Testemunha
        FOREIGN KEY (Testemunha)
        REFERENCES Testemunha (ID)
    -- INDEX fk_CasoTestemunha_Caso1_idx (Caso ASC) VISIBLE
);
