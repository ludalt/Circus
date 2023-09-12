SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema circus2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema circus2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `circus2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `circus2` ;

-- -----------------------------------------------------
-- Table `circus2`.`специализация сотрудника`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`специализация сотрудника` (
  `id специализации` INT NOT NULL,
  `Наименование` VARCHAR(45) NULL DEFAULT NULL,
  `Краткое описание` VARCHAR(512) NULL DEFAULT NULL,
  PRIMARY KEY (`id специализации`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Артисты`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Артисты` (
  `ID сотрудника` INT NOT NULL AUTO_INCREMENT,
  `Фамилия` VARCHAR(45) NOT NULL,
  `Имя` VARCHAR(45) NOT NULL,
  `Отчество` VARCHAR(45) NOT NULL,
  `Пол` VARCHAR(45) NOT NULL,
  `Дата рождения` DATETIME NOT NULL,
  `Номер телефона` VARCHAR(45) NOT NULL,
  `Логин` VARCHAR(45) NOT NULL,
  `Пароль` VARCHAR(45) NOT NULL,
  `ID специализации` INT NOT NULL,
  PRIMARY KEY (`ID сотрудника`),
  INDEX `артисты_idx` (`ID специализации` ASC) VISIBLE,
  CONSTRAINT `артисты`
    FOREIGN KEY (`ID специализации`)
    REFERENCES `circus2`.`специализация сотрудника` (`id специализации`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 122
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Категории билетов`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Категории билетов` (
  `ID Категории` INT NOT NULL AUTO_INCREMENT,
  `Наименование` VARCHAR(45) NOT NULL,
  `Информация о категории билета(скидка)` FLOAT NOT NULL,
  PRIMARY KEY (`ID Категории`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Зрители`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Зрители` (
  `ID Зрителя` INT NOT NULL AUTO_INCREMENT,
  `Фамилия` VARCHAR(45) NOT NULL,
  `Имя` VARCHAR(45) NOT NULL,
  `Отчество` VARCHAR(45) NULL DEFAULT NULL,
  `Пол` VARCHAR(45) NOT NULL,
  `Дата рождения` DATETIME NOT NULL,
  `Логин` VARCHAR(45) NOT NULL,
  `Пароль` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID Зрителя`))
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Жанры`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Жанры` (
  `id Жанра` INT NOT NULL AUTO_INCREMENT,
  `Название` VARCHAR(45) NOT NULL,
  `Описание жанра` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id Жанра`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Постановка`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Постановка` (
  `id Постановки` INT NOT NULL AUTO_INCREMENT,
  `Название` VARCHAR(45) NOT NULL,
  `Режиссер-постановщик` VARCHAR(45) NULL DEFAULT NULL,
  `Художник-постановщик` VARCHAR(45) NULL DEFAULT NULL,
  `Дерижер-постановщик` VARCHAR(45) NULL DEFAULT NULL,
  `Автор` VARCHAR(45) NULL DEFAULT NULL,
  `ID жанра` INT NOT NULL,
  `Длительность` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id Постановки`),
  INDEX `постановка_idx` (`ID жанра` ASC) VISIBLE,
  CONSTRAINT `постановка`
    FOREIGN KEY (`ID жанра`)
    REFERENCES `circus2`.`Жанры` (`id Жанра`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Города`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Города` (
  `id Города` INT NOT NULL AUTO_INCREMENT,
  `Наименование` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id Города`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Площадка`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Площадка` (
  `id Площадки` INT NOT NULL AUTO_INCREMENT,
  `Название` VARCHAR(256) NOT NULL,
  `Адрес` VARCHAR(256) NOT NULL,
  `Контактная информация` VARCHAR(256) NOT NULL,
  `ID города` INT NOT NULL,
  PRIMARY KEY (`id Площадки`),
  INDEX `город_idx` (`ID города` ASC) VISIBLE,
  CONSTRAINT `город`
    FOREIGN KEY (`ID города`)
    REFERENCES `circus2`.`Города` (`id Города`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Выступление`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Выступление` (
  `ID выступления` INT NOT NULL AUTO_INCREMENT,
  `Дата` DATETIME NOT NULL,
  `Время начала` DATETIME NOT NULL,
  `Время окончания` DATETIME NOT NULL,
  `ID площадки` INT NOT NULL,
  `Тип выступления` VARCHAR(45) NOT NULL,
  `ID постановки` INT NOT NULL,
  PRIMARY KEY (`ID выступления`),
  INDEX `выступление_idx` (`ID постановки` ASC) VISIBLE,
  INDEX `выступление_idx1` (`ID площадки` ASC) VISIBLE,
  CONSTRAINT `выступление`
    FOREIGN KEY (`ID постановки`)
    REFERENCES `circus2`.`Постановка` (`id Постановки`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `выступление`
    FOREIGN KEY (`ID площадки`)
    REFERENCES `circus2`.`Площадка` (`id Площадки`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 50
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Билеты`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Билеты` (
  `ID Билета` INT NOT NULL AUTO_INCREMENT,
  `ID Категории` INT NOT NULL,
  `ID Зрителя` INT NOT NULL,
  `ID выступления` INT NOT NULL,
  PRIMARY KEY (`ID Билета`),
  INDEX `категории_idx` (`ID Категории` ASC) VISIBLE,
  INDEX `зрители_idx` (`ID Зрителя` ASC) VISIBLE,
  INDEX `выступление_idx` (`ID выступления` ASC) VISIBLE,
  CONSTRAINT `категории`
    FOREIGN KEY (`ID Категории`)
    REFERENCES `circus2`.`Категории билетов` (`ID Категории`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `зрители`
    FOREIGN KEY (`ID Зрителя`)
    REFERENCES `circus2`.`Зрители` (`ID Зрителя`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `выступление`
    FOREIGN KEY (`ID выступления`)
    REFERENCES `circus2`.`Выступление` (`ID выступления`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Выступающие артисты`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Выступающие артисты` (
  `ID выступления` INT NOT NULL,
  `ID сотрудника` INT NOT NULL,
  INDEX `выступающие артисты_idx` (`ID сотрудника` ASC) VISIBLE,
  INDEX `выступающие_idx` (`ID выступления` ASC) VISIBLE,
  CONSTRAINT `выступающие`
    FOREIGN KEY (`ID выступления`)
    REFERENCES `circus2`.`Выступление` (`ID выступления`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `выступающие`
    FOREIGN KEY (`ID сотрудника`)
    REFERENCES `circus2`.`Артисты` (`ID сотрудника`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Ряд`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Ряд` (
  `id Рядя` INT NOT NULL AUTO_INCREMENT,
  `ID площадки` INT NOT NULL,
  `Номер ряда` INT NULL DEFAULT NULL,
  `Количество мест` INT NULL DEFAULT NULL,
  `Форма ряда` VARCHAR(45) NULL DEFAULT NULL,
  `Тип ряда` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id Рядя`),
  INDEX `ряд_idx` (`ID площадки` ASC) VISIBLE,
  CONSTRAINT `ряд`
    FOREIGN KEY (`ID площадки`)
    REFERENCES `circus2`.`Площадка` (`id Площадки`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Место`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Место` (
  `id Места` INT NOT NULL AUTO_INCREMENT,
  `ID ряда` INT NOT NULL,
  `Номер места` INT NOT NULL,
  `Категория места` VARCHAR(45) NOT NULL,
  `Цена базовая` INT NOT NULL,
  PRIMARY KEY (`id Места`),
  INDEX `место_idx` (`ID ряда` ASC) VISIBLE,
  CONSTRAINT `место`
    FOREIGN KEY (`ID ряда`)
    REFERENCES `circus2`.`Ряд` (`id Рядя`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 83
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `circus2`.`Сотрудники`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `circus2`.`Сотрудники` (
  `ID сотрудника` INT NOT NULL AUTO_INCREMENT,
  `Фамилия` VARCHAR(45) NULL DEFAULT NULL,
  `Имя` VARCHAR(45) NULL DEFAULT NULL,
  `Отчество` VARCHAR(45) NULL DEFAULT NULL,
  `Пол` VARCHAR(45) NULL DEFAULT NULL,
  `Дата рождения` DATETIME NULL DEFAULT NULL,
  `Номер телефона` VARCHAR(45) NULL DEFAULT NULL,
  `Логин` VARCHAR(45) NULL DEFAULT NULL,
  `Пароль` VARCHAR(45) NULL DEFAULT NULL,
  `ID специализации` INT NOT NULL,
  PRIMARY KEY (`ID сотрудника`),
  INDEX `id специализации_idx` (`ID специализации` ASC) VISIBLE,
  CONSTRAINT `сотрудники`
    FOREIGN KEY (`ID специализации`)
    REFERENCES `circus2`.`специализация сотрудника` (`id специализации`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;