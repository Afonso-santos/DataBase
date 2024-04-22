-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`DetetiveEspecialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DetetiveEspecialidade` (
  `ID` INT NOT NULL,
  `Designação` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DetetiveEstado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DetetiveEstado` (
  `ID` INT NOT NULL,
  `Designação` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Detetive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Detetive` (
  `ID` INT NOT NULL,
  `Especialidade` INT NOT NULL,
  `Estado` INT NOT NULL,
  `Nome` VARCHAR(150) NOT NULL,
  `Email` VARCHAR(320) NOT NULL,
  `Telefone` VARCHAR(20) NOT NULL,
  `DataNascimento` DATE NOT NULL,
  `Morada` VARCHAR(250) NULL,
  `Salário` DECIMAL(10,2) NOT NULL,
  `DataContratação` DATE NOT NULL,
  `DataFimContratação` DATE NULL,
  `Efetivo` BIT(1) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Detetive_DetetiveEspecialidade1_idx` (`Especialidade` ASC) VISIBLE,
  INDEX `fk_Detetive_DetetiveEstado1_idx` (`Estado` ASC) VISIBLE,
  CONSTRAINT `fk_Detetive_DetetiveEspecialidade1`
    FOREIGN KEY (`Especialidade`)
    REFERENCES `mydb`.`DetetiveEspecialidade` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detetive_DetetiveEstado1`
    FOREIGN KEY (`Estado`)
    REFERENCES `mydb`.`DetetiveEstado` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EvidênciaTipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EvidênciaTipo` (
  `ID` INT NOT NULL,
  `Designação` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CasoCategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CasoCategoria` (
  `ID` INT NOT NULL,
  `Designação` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CasoEstado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CasoEstado` (
  `ID` INT NOT NULL,
  `Designação` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(150) NOT NULL,
  `Telefone` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(320) NULL,
  `Morada` VARCHAR(250) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Caso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Caso` (
  `ID` INT NOT NULL,
  `Cliente` INT NOT NULL,
  `Categoria` INT NOT NULL,
  `Estado` INT NOT NULL,
  `Descrição` TEXT(2000) NOT NULL,
  `DataAbertura` DATE NOT NULL,
  `DataFechamento` DATE NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Caso_CasoCategoria1_idx` (`Categoria` ASC) VISIBLE,
  INDEX `fk_Caso_CasoEstado1_idx` (`Estado` ASC) VISIBLE,
  INDEX `fk_Caso_Cliente1_idx` (`Cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Caso_CasoCategoria1`
    FOREIGN KEY (`Categoria`)
    REFERENCES `mydb`.`CasoCategoria` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caso_CasoEstado1`
    FOREIGN KEY (`Estado`)
    REFERENCES `mydb`.`CasoEstado` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Caso_Cliente1`
    FOREIGN KEY (`Cliente`)
    REFERENCES `mydb`.`Cliente` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Evidência`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Evidência` (
  `ID` INT NOT NULL,
  `Caso` INT NOT NULL,
  `Tipo` INT NOT NULL,
  `DataColeta` DATE NOT NULL,
  `Descrição` TEXT(1000) NOT NULL,
  `Arquivo` VARCHAR(300) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Evidência_EvidênciaTipo1_idx` (`Tipo` ASC) VISIBLE,
  INDEX `fk_Evidência_Caso1_idx` (`Caso` ASC) VISIBLE,
  CONSTRAINT `fk_Evidência_EvidênciaTipo1`
    FOREIGN KEY (`Tipo`)
    REFERENCES `mydb`.`EvidênciaTipo` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evidência_Caso1`
    FOREIGN KEY (`Caso`)
    REFERENCES `mydb`.`Caso` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vinculado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vinculado` (
  `Detetive` INT NOT NULL,
  `Caso` INT NOT NULL,
  `DataVinculação` DATETIME NOT NULL,
  `DataDesvinculação` DATETIME NULL,
  `Descrição` TEXT(400) NOT NULL,
  PRIMARY KEY (`Detetive`, `Caso`, `DataVinculação`),
  INDEX `fk_Vinculado_Caso1_idx` (`Caso` ASC) VISIBLE,
  CONSTRAINT `fk_Vinculado_Detetive1`
    FOREIGN KEY (`Detetive`)
    REFERENCES `mydb`.`Detetive` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vinculado_Caso1`
    FOREIGN KEY (`Caso`)
    REFERENCES `mydb`.`Caso` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Suspeito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Suspeito` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(150) NOT NULL,
  `Email` VARCHAR(320) NULL,
  `Telefone` VARCHAR(20) NULL,
  `DataNascimento` DATE NULL,
  `Sexo` CHAR(1) NULL,
  `Morada` VARCHAR(250) NULL,
  `Descrição` TEXT(1000) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CasoSuspeito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CasoSuspeito` (
  `Caso` INT NOT NULL,
  `Suspeito` INT NOT NULL,
  INDEX `fk_CasoSuspeito_Suspeito1_idx` (`Suspeito` ASC) VISIBLE,
  PRIMARY KEY (`Caso`, `Suspeito`),
  CONSTRAINT `fk_CasoSuspeito_Suspeito1`
    FOREIGN KEY (`Suspeito`)
    REFERENCES `mydb`.`Suspeito` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CasoSuspeito_Caso1`
    FOREIGN KEY (`Caso`)
    REFERENCES `mydb`.`Caso` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
  `Caso` INT NOT NULL,
  `Descrição` TEXT(300) NOT NULL,
  `Valor` DECIMAL(10,2) NOT NULL,
  `Data` DATE NOT NULL,
  PRIMARY KEY (`Caso`, `Descrição`(300), `Valor`, `Data`),
  CONSTRAINT `fk_Pagamento_Caso1`
    FOREIGN KEY (`Caso`)
    REFERENCES `mydb`.`Caso` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Testemunha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Testemunha` (
  `ID` INT NOT NULL,
  `Nome` VARCHAR(150) NOT NULL,
  `Email` VARCHAR(320) NULL,
  `Telefone` VARCHAR(20) NULL,
  `Morada` VARCHAR(250) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CasoTestemunha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CasoTestemunha` (
  `Caso` INT NOT NULL,
  `Testemunha` INT NOT NULL,
  INDEX `fk_CasoTestemunha_Caso1_idx` (`Caso` ASC) VISIBLE,
  PRIMARY KEY (`Caso`, `Testemunha`),
  CONSTRAINT `fk_CasoTestemunha_Caso1`
    FOREIGN KEY (`Caso`)
    REFERENCES `mydb`.`Caso` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CasoTestemunha_Testemunha1`
    FOREIGN KEY (`Testemunha`)
    REFERENCES `mydb`.`Testemunha` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Despesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Despesa` (
  `Caso` INT NOT NULL,
  `Descrição` TEXT(300) NOT NULL,
  `Valor` DECIMAL(10,2) NOT NULL,
  `Data` DATE NOT NULL,
  PRIMARY KEY (`Caso`, `Descrição`(300), `Valor`, `Data`),
  CONSTRAINT `fk_Pagamento_Caso10`
    FOREIGN KEY (`Caso`)
    REFERENCES `mydb`.`Caso` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
