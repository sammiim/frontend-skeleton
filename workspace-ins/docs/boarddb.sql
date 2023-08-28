-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema boarddb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `boarddb` ;

-- -----------------------------------------------------
-- Schema boarddb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `boarddb` DEFAULT CHARACTER SET utf8 ;
USE `boarddb` ;

-- -----------------------------------------------------
-- Table `boarddb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boarddb`.`user` ;

CREATE TABLE IF NOT EXISTS `boarddb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '사용자 아이디',
  `name` VARCHAR(45) NOT NULL COMMENT '사용자 이름',
  `email` VARCHAR(45) NOT NULL COMMENT '사용자 이메일',
  `cellphone` VARCHAR(11) NULL COMMENT '사용자 휴대폰 번호',
  `password` VARCHAR(45) NOT NULL COMMENT '사용자 비밀번호',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
  `updatedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
