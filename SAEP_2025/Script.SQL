-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema saep_db1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema saep_db1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `saep_db1` DEFAULT CHARACTER SET utf8mb4 ;
USE `saep_db1` ;

-- -----------------------------------------------------
-- Table `saep_db1`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saep_db1`.`usuario` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `nome` VARCHAR(255) NULL DEFAULT NULL,
  `senha` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UK5171l57faosmj8myawaucatdw` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `saep_db1`.`tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saep_db1`.`tipo` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `saep_db1`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saep_db1`.`produto` (
  `estoqueatual` DECIMAL(38,2) NULL DEFAULT NULL,
  `estoqueminimo` DECIMAL(38,2) NULL DEFAULT NULL,
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `idtipo` BIGINT(20) NULL DEFAULT NULL,
  `descproduto` VARCHAR(255) NULL DEFAULT NULL,
  `unidmedida` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKlst54ox3v32japd50yf7c8nxy` (`idtipo` ASC) VISIBLE,
  CONSTRAINT `FKlst54ox3v32japd50yf7c8nxy`
    FOREIGN KEY (`idtipo`)
    REFERENCES `saep_db1`.`tipo` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `saep_db1`.`movimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saep_db1`.`movimento` (
  `qtdmovto` DECIMAL(38,2) NULL DEFAULT NULL,
  `tipomovto` CHAR(1) NOT NULL,
  `datahoramovto` DATETIME(6) NULL DEFAULT NULL,
  `idproduto` BIGINT(20) NULL DEFAULT NULL,
  `idtransacao` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `idusuario` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`idtransacao`),
  INDEX `FK9xpdvg7vpkmp5idn9ktpqmmkr` (`idproduto` ASC) VISIBLE,
  INDEX `FK6w8wkc08esf60b4gndee3p9a0` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `FK6w8wkc08esf60b4gndee3p9a0`
    FOREIGN KEY (`idusuario`)
    REFERENCES `saep_db1`.`usuario` (`id`),
  CONSTRAINT `FK9xpdvg7vpkmp5idn9ktpqmmkr`
    FOREIGN KEY (`idproduto`)
    REFERENCES `saep_db1`.`produto` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ========================================
-- DADOS INICIAIS - SAEP 2025
-- ========================================

-- USUÁRIO PADRÃO (senha: adm)
INSERT INTO usuario (nome, email, senha)
VALUES ('Administrador', 'admin@saep.com',
        '$2a$10$0omgADneSOBADv2v0OTXk.PHuUwiIjT12HoTalmHzZstKUW93LHJ2');

INSERT INTO usuario (nome, email, senha)
VALUES ('Colaborador', 'colab@saep.com',
        '$2a$10$0omgADneSOBADv2v0OTXk.PHuUwiIjT12HoTalmHzZstKUW93LHJ2');

INSERT INTO usuario (nome, email, senha)
VALUES ('Karize', 'karize@saep.com', 
        '$2a$10$fNoNFpC2OkJlSM.bteD.sOHC9126CS8Wdr7BZdjRhb8NMn1YRZSAG');

-- TIPOS PADRÃO
INSERT INTO tipo (descricao) VALUES
('Corante'),
('Alvejante'),
('Auxiliar'),
('Não definido');

-- PRODUTOS INICIAIS
INSERT INTO produto (descproduto, unidmedida, estoqueatual, estoqueminimo, idtipo)
VALUES
('Corante Azul', 'L', 10, 3, 1),
('Alvejante Branco', 'L', 25, 5, 2),
('Produto Auxiliar X', 'kg', 15, 4, 3);

-- MOVIMENTOS INICIAIS
INSERT INTO movimento (datahoramovto, qtdmovto, tipomovto, idproduto, idusuario)
VALUES
(NOW(), 5.00, 'E', 1, 1),
(NOW(), 2.00, 'S', 2, 1),
(NOW(), 3.00, 'E', 3, 1);
