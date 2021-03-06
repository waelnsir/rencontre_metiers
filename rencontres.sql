-- MySQL Script generated by MySQL Workbench
-- Wed Oct  7 00:16:29 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rencontres
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rencontres
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rencontres` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
-- -----------------------------------------------------
-- Schema rencontres3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rencontres3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rencontres3` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `rencontres` ;

-- -----------------------------------------------------
-- Table `rencontres`.`metiers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`metiers` (
  `idmetiers` INT(11) NOT NULL,
  `titre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idmetiers`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`membres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`membres` (
  `idmembres` INT(11) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NULL DEFAULT NULL,
  `photo` VARCHAR(200) NULL DEFAULT NULL,
  `idmetiers` INT(11) NULL,
  PRIMARY KEY (`idmembres`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE,
  INDEX `fk_membres_mstiers_idx` (`idmetiers` ASC) VISIBLE,
  CONSTRAINT `fk_membres_mstiers`
    FOREIGN KEY (`idmetiers`)
    REFERENCES `rencontres`.`metiers` (`idmetiers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`fichiers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`fichiers` (
  `idfichiers` INT(11) NOT NULL,
  `nom` VARCHAR(200) NULL DEFAULT NULL,
  `date_created` DATETIME NULL DEFAULT NULL,
  `sources` VARCHAR(45) NULL DEFAULT NULL,
  `idmembres` INT NOT NULL,
  PRIMARY KEY (`idfichiers`),
  INDEX `fk_fichiers_membres_idx` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `fk_fichiers_membres`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres`.`membres` (`idmembres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`forums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`forums` (
  `idforums` INT(11) NOT NULL,
  `titre` VARCHAR(45) NOT NULL,
  `idmembres` INT(11) NOT NULL,
  `idmetiers` INT(11) NOT NULL,
  PRIMARY KEY (`idforums`),
  INDEX `fk_forums_metiers` (`idmetiers` ASC) VISIBLE,
  INDEX `fk_forums_membres` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `fk_forums_membres`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres`.`membres` (`idmembres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`login` (
  `idlogin` INT(11) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `pass` VARCHAR(10) NOT NULL,
  `idmembres` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idlogin`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `idmembres_UNIQUE` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `login_membres_ibfk_1`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres`.`membres` (`idmembres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`messages` (
  `idmessages` INT(11) NOT NULL,
  `idforums` INT(11) NULL DEFAULT NULL,
  `idmembres` INT(11) NULL DEFAULT NULL,
  `contenu` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`idmessages`),
  INDEX `fk_forums_messages` (`idforums` ASC) VISIBLE,
  INDEX `fk_messages_membres` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `fk_messages_membres`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres`.`membres` (`idmembres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_messages_forums`
    FOREIGN KEY (`idforums`)
    REFERENCES `rencontres`.`forums` (`idforums`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`produits_materiels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`produits_materiels` (
  `idproduits_materiels` INT(11) NOT NULL,
  `titre` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `idmetiers` INT(11) NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `type_produits` VARCHAR(45) NULL DEFAULT NULL,
  `idmembres` INT(11) NOT NULL,
  `type_action` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idproduits_materiels`),
  INDEX `fk_produits_membres` (`idmembres` ASC) VISIBLE,
  INDEX `fk_produits_metiers` (`idmetiers` ASC) VISIBLE,
  CONSTRAINT `fk_produits_metiers`
    FOREIGN KEY (`idmetiers`)
    REFERENCES `rencontres`.`metiers` (`idmetiers`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`reponses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`reponses` (
  `idreponses` INT(11) NOT NULL,
  `idmessages` INT(11) NULL DEFAULT NULL,
  `contenu` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idreponses`),
  INDEX `fk_reponses_messages` (`idmessages` ASC) VISIBLE,
  CONSTRAINT `fk_reponses_messages`
    FOREIGN KEY (`idmessages`)
    REFERENCES `rencontres`.`messages` (`idmessages`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`services` (
  `idservices` INT(11) NOT NULL,
  `titre` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `idmetiers` INT(11) NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `type_services` VARCHAR(45) NULL DEFAULT NULL,
  `idmembres` INT(11) NOT NULL,
  `type_action` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idservices`),
  INDEX `fk_services_metiers` (`idmetiers` ASC) VISIBLE,
  INDEX `fk_services_membres` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `fk_services_membres`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres`.`membres` (`idmembres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_services_metiers`
    FOREIGN KEY (`idmetiers`)
    REFERENCES `rencontres`.`metiers` (`idmetiers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;

USE `rencontres3` ;

-- -----------------------------------------------------
-- Table `rencontres3`.`fichiers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres3`.`fichiers` (
  `idfichiers` INT(11) NOT NULL,
  `nom` VARCHAR(200) NULL DEFAULT NULL,
  `date_created` DATETIME NULL DEFAULT NULL,
  `sources` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idfichiers`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`metiers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`metiers` (
  `idmetiers` INT(11) NOT NULL,
  `titre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idmetiers`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres3`.`membres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres3`.`membres` (
  `idmembres` INT(11) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NULL DEFAULT NULL,
  `photo` VARCHAR(200) NULL DEFAULT NULL,
  `idmetiers` INT(11) NULL,
  PRIMARY KEY (`idmembres`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE,
  INDEX `fk_membres_metiers_idx` (`idmetiers` ASC) VISIBLE,
  CONSTRAINT `fk_membres_metiers`
    FOREIGN KEY (`idmetiers`)
    REFERENCES `rencontres`.`metiers` (`idmetiers`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres3`.`forums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres3`.`forums` (
  `idforums` INT(11) NOT NULL,
  `titre` VARCHAR(45) NOT NULL,
  `idmembres` INT(11) NOT NULL,
  `idmetiers` INT(11) NOT NULL,
  PRIMARY KEY (`idforums`),
  INDEX `fk_forums_metiers` (`idmetiers` ASC) VISIBLE,
  INDEX `fk_forums_membres` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `fk_forums_membres`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres3`.`membres` (`idmembres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres3`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres3`.`login` (
  `idlogin` INT(11) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `pass` VARCHAR(10) NOT NULL,
  `idmembres` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idlogin`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `idmembres_UNIQUE` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `login_membres_ibfk_1`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres3`.`membres` (`idmembres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres3`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres3`.`messages` (
  `idmessages` INT(11) NOT NULL,
  `idforums` INT(11) NULL DEFAULT NULL,
  `idmembres` INT(11) NULL DEFAULT NULL,
  `contenu` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`idmessages`),
  INDEX `fk_forums_messages` (`idforums` ASC) VISIBLE,
  INDEX `fk_messages_membres` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `fk_messages_membres`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres3`.`membres` (`idmembres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres3`.`metiers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres3`.`metiers` (
  `idmetiers` INT(11) NOT NULL,
  `titre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idmetiers`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres`.`membres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`membres` (
  `idmembres` INT(11) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NULL DEFAULT NULL,
  `photo` VARCHAR(200) NULL DEFAULT NULL,
  `idmetiers` INT(11) NULL,
  PRIMARY KEY (`idmembres`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telephone_UNIQUE` (`telephone` ASC) VISIBLE,
  INDEX `fk_membres_mstiers_idx` (`idmetiers` ASC) VISIBLE,
  CONSTRAINT `fk_membres_mstiers`
    FOREIGN KEY (`idmetiers`)
    REFERENCES `rencontres`.`metiers` (`idmetiers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres3`.`produits_materiels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres3`.`produits_materiels` (
  `idproduits_materiels` INT(11) NOT NULL,
  `titre` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `idmetiers` INT(11) NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `type_produits` VARCHAR(45) NULL DEFAULT NULL,
  `idmembres` INT(11) NOT NULL,
  `type_action` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idproduits_materiels`),
  INDEX `fk_produits_membres` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `fk_produits_membres`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres`.`membres` (`idmembres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres3`.`reponses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres3`.`reponses` (
  `idreponses` INT(11) NOT NULL,
  `idmessages` INT(11) NULL DEFAULT NULL,
  `contenu` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idreponses`),
  INDEX `fk_reponses_messages` (`idmessages` ASC) VISIBLE,
  CONSTRAINT `fk_reponses_messages`
    FOREIGN KEY (`idmessages`)
    REFERENCES `rencontres3`.`messages` (`idmessages`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `rencontres3`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres3`.`services` (
  `idservices` INT(11) NOT NULL,
  `titre` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `idmetiers` INT(11) NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  `type_services` VARCHAR(45) NULL DEFAULT NULL,
  `idmembres` INT(11) NOT NULL,
  `type_action` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idservices`),
  INDEX `fk_services_metiers` (`idmetiers` ASC) VISIBLE,
  INDEX `fk_services_membres` (`idmembres` ASC) VISIBLE,
  CONSTRAINT `fk_services_membres`
    FOREIGN KEY (`idmembres`)
    REFERENCES `rencontres3`.`membres` (`idmembres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;

USE `rencontres` ;

-- -----------------------------------------------------
-- Placeholder table for view `rencontres`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rencontres`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `rencontres`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rencontres`.`view1`;
USE `rencontres`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
