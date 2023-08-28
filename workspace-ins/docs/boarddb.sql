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


-- -----------------------------------------------------
-- Table `boarddb`.`board`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boarddb`.`board` ;

CREATE TABLE IF NOT EXISTS `boarddb`.`board` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '게시물 아이디',
  `userId` INT NOT NULL COMMENT '작성자 아이디',
  `title` VARCHAR(1024) NOT NULL COMMENT '제목',
  `content` VARCHAR(1024) NOT NULL COMMENT '내용',
  `filePath` VARCHAR(1024) NULL COMMENT '첨부파일 경로',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
  `updatedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_board_userId`
    FOREIGN KEY (`userId`)
    REFERENCES `boarddb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_board_userId_idx` ON `boarddb`.`board` (`userId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `boarddb`.`board_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `boarddb`.`board_comment` ;

CREATE TABLE IF NOT EXISTS `boarddb`.`board_comment` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '댓글 아이디',
  `boardId` INT NOT NULL COMMENT '게시물 아이디',
  `userId` INT NOT NULL COMMENT '작성자 아이디',
  `content` VARCHAR(1024) NOT NULL COMMENT '댓글 내용',
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_board_comment_boardId`
    FOREIGN KEY (`boardId`)
    REFERENCES `boarddb`.`board` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_board_comment_userId`
    FOREIGN KEY (`userId`)
    REFERENCES `boarddb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_board_comment_boardId_idx` ON `boarddb`.`board_comment` (`boardId` ASC) VISIBLE;

CREATE INDEX `fk_board_comment_userId_idx` ON `boarddb`.`board_comment` (`userId` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
