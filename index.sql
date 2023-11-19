-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projeto_fortes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projeto_fortes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projeto_fortes` DEFAULT CHARACTER SET utf8 ;
USE `projeto_fortes` ;

-- -----------------------------------------------------
-- Table `projeto_fortes`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`cargo` (
  `idcargo` INT(20) auto_increment NOT NULL,
  `nome_cargo` VARCHAR(45) NOT NULL,
  `responsa` TEXT(255) NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  `beneficio` TEXT(255) NULL,
  UNIQUE INDEX `idcargo_UNIQUE` (`idcargo` ASC) VISIBLE,
  PRIMARY KEY (`idcargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`func`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`func` (
  `idfunc` INT NOT NULL,
  `cpf` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cargo_idcargo` INT NOT NULL,
  PRIMARY KEY (`idfunc`, `cargo_idcargo`),
  UNIQUE INDEX `idfunc_UNIQUE` (`idfunc` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  INDEX `fk_func_cargo_idx` (`cargo_idcargo` ASC) VISIBLE,
  CONSTRAINT `fk_func_cargo`
    FOREIGN KEY (`cargo_idcargo`)
    REFERENCES `projeto_fortes`.`cargo` (`idcargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`endereco` (
  `cep` INT(8) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `logradouro` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `cep_UNIQUE` (`cep` ASC) VISIBLE,
  PRIMARY KEY (`cep`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`fornecedor` (
  `cnpj` INT(18) NOT NULL,
  `razao_social` VARCHAR(45) NOT NULL,
  `fornecedorcol` VARCHAR(45) NULL,
  `id_endereco` INT NOT NULL,
  PRIMARY KEY (`cnpj`, `id_endereco`),
  UNIQUE INDEX `idfornecedor_UNIQUE` (`cnpj` ASC) VISIBLE,
  UNIQUE INDEX `razao_social_UNIQUE` (`razao_social` ASC) VISIBLE,
  INDEX `fk_fornecedor_endereco1_idx` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `fk_fornecedor_endereco1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `projeto_fortes`.`endereco` (`cep`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`endereco_obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`endereco_obra` (
  `id_end_obra` INT NOT NULL,
  `cep` INT(8) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `logradouro` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `id_end_obra_UNIQUE` (`id_end_obra` ASC) VISIBLE,
  PRIMARY KEY (`id_end_obra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`obras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`obras` (
  `idobras` INT(10) auto_increment NOT NULL,
  `status` boolean NOT NULL,
  `id_end_obra` INT NOT NULL,
  PRIMARY KEY (`idobras`),
  UNIQUE INDEX `idobras_UNIQUE` (`idobras` ASC) VISIBLE,
  INDEX `fk_obras_endereco_obra1_idx` (`id_end_obra` ASC) VISIBLE,
  CONSTRAINT `fk_obras_endereco_obra1`
    FOREIGN KEY (`id_end_obra`)
    REFERENCES `projeto_fortes`.`endereco_obra` (`id_end_obra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`func_obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`func_obra` (
  `id_func_obra` INT NOT NULL,
  `func_idfunc` INT NOT NULL,
  `obras_idobras` INT NOT NULL,
  PRIMARY KEY (`id_func_obra`),
  UNIQUE INDEX `id_func_obra_UNIQUE` (`id_func_obra` ASC) VISIBLE,
  INDEX `fk_func_obra_func1_idx` (`func_idfunc` ASC) VISIBLE,
  INDEX `fk_func_obra_obras1_idx` (`obras_idobras` ASC) VISIBLE,
  UNIQUE INDEX `func_idfunc_UNIQUE` (`func_idfunc` ASC) VISIBLE,
  UNIQUE INDEX `obras_idobras_UNIQUE` (`obras_idobras` ASC) VISIBLE,
  CONSTRAINT `fk_func_obra_func1`
    FOREIGN KEY (`func_idfunc`)
    REFERENCES `projeto_fortes`.`func` (`idfunc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_func_obra_obras1`
    FOREIGN KEY (`obras_idobras`)
    REFERENCES `projeto_fortes`.`obras` (`idobras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`refeicoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`refeicoes` (
  `id_refeicao` INT(10) auto_increment NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `valor_unitario` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id_refeicao`),
  UNIQUE INDEX `idrefeicoes_UNIQUE` (`id_refeicao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`programa_diario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`programa_diario` (
  `id_programa` INT(10) auto_increment NOT NULL,
  `data` DATE NOT NULL,
  `tipo_dia` VARCHAR(45) NOT NULL,
  `id_refeicao` INT NOT NULL,
  `id_obras` INT NOT NULL,
  PRIMARY KEY (`id_programa`, `id_obras`),
  UNIQUE INDEX `id_programa_UNIQUE` (`id_programa` ASC) VISIBLE,
  INDEX `fk_programa_diario_refeicoes1_idx` (`id_refeicao` ASC) VISIBLE,
  INDEX `fk_programa_diario_obras1_idx` (`id_obras` ASC) VISIBLE,
  CONSTRAINT `fk_programa_diario_refeicoes1`
    FOREIGN KEY (`id_refeicao`)
    REFERENCES `projeto_fortes`.`refeicoes` (`id_refeicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_programa_diario_obras1`
    FOREIGN KEY (`id_obras`)
    REFERENCES `projeto_fortes`.`obras` (`idobras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`equipes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`equipes` (
  `id_equipe` VARCHAR(45) NOT NULL,
  `id_func` INT NOT NULL,
  `id_obras` INT NOT NULL,
  `cargo_equipe` VARCHAR(45) NULL,
  PRIMARY KEY (`id_equipe`),
  INDEX `fk_func_has_obras_obras1_idx` (`id_obras` ASC) VISIBLE,
  INDEX `fk_func_has_obras_func1_idx` (`id_func` ASC) VISIBLE,
  UNIQUE INDEX `id_equipe_UNIQUE` (`id_equipe` ASC) VISIBLE,
  CONSTRAINT `fk_func_has_obras_func1`
    FOREIGN KEY (`id_func`)
    REFERENCES `projeto_fortes`.`func` (`idfunc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_func_has_obras_obras1`
    FOREIGN KEY (`id_obras`)
    REFERENCES `projeto_fortes`.`obras` (`idobras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`consumo_refeicoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`consumo_refeicoes` (
  `id_consumo` INT NOT NULL,
  `id_func` INT NOT NULL,
  `quant_consumida` VARCHAR(45) NULL,
  `programa_diario_id_programa` INT NOT NULL,
  PRIMARY KEY (`id_consumo`),
  UNIQUE INDEX `id_cons_ref_UNIQUE` (`id_consumo` ASC) VISIBLE,
  INDEX `fk_consumo_refeicoes_func1_idx` (`id_func` ASC) VISIBLE,
  INDEX `fk_consumo_refeicoes_programa_diario1_idx` (`programa_diario_id_programa` ASC) VISIBLE,
  CONSTRAINT `fk_consumo_refeicoes_func1`
    FOREIGN KEY (`id_func`)
    REFERENCES `projeto_fortes`.`func` (`idfunc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consumo_refeicoes_programa_diario1`
    FOREIGN KEY (`programa_diario_id_programa`)
    REFERENCES `projeto_fortes`.`programa_diario` (`id_programa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`medicoes_pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`medicoes_pagamento` (
  `id_medicao` INT NOT NULL,
  `programa_diario_id_programa` INT NOT NULL,
  `valor total` DECIMAL(10,2) NULL,
  `quantidade_consumida_total` INT(45) NULL,
  `pago` CHAR(1) NULL,
  PRIMARY KEY (`id_medicao`),
  UNIQUE INDEX `id_medicao_UNIQUE` (`id_medicao` ASC) VISIBLE,
  INDEX `fk_medicoes_pagamento_programa_diario1_idx` (`programa_diario_id_programa` ASC) VISIBLE,
  CONSTRAINT `fk_medicoes_pagamento_programa_diario1`
    FOREIGN KEY (`programa_diario_id_programa`)
    REFERENCES `projeto_fortes`.`programa_diario` (`id_programa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projeto_fortes`.`medicoes_pagamento_has_fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projeto_fortes`.`medicoes_pagamento_has_fornecedor` (
  `medicao_fornecedor` INT NOT NULL,
  `fornecedor_cnpj` INT NOT NULL,
  INDEX `fk_medicoes_pagamento_has_fornecedor_fornecedor1_idx` (`fornecedor_cnpj` ASC) VISIBLE,
  INDEX `fk_medicoes_pagamento_has_fornecedor_medicoes_pagamento1_idx` (`medicao_fornecedor` ASC) VISIBLE,
  PRIMARY KEY (`medicao_fornecedor`),
  CONSTRAINT `fk_medicoes_pagamento_has_fornecedor_medicoes_pagamento1`
    FOREIGN KEY (`medicao_fornecedor`)
    REFERENCES `projeto_fortes`.`medicoes_pagamento` (`id_medicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicoes_pagamento_has_fornecedor_fornecedor1`
    FOREIGN KEY (`fornecedor_cnpj`)
    REFERENCES `projeto_fortes`.`fornecedor` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
