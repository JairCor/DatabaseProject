-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema projectdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projectdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projectdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `projectdb` ;

-- -----------------------------------------------------
-- Table `projectdb`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`artist` (
  `ARTIST_ID` VARCHAR(7) NOT NULL,
  `ARTIST_NAME` VARCHAR(100) NULL,
  PRIMARY KEY (`ARTIST_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`genre` (
  `GENRE_ID` VARCHAR(7) NOT NULL,
  `GENRE_NAME` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`GENRE_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`lyrics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`lyrics` (
  `LYRICS_ID` VARCHAR(15) NOT NULL,
  `LYRICS_TEXT` TEXT NULL DEFAULT NULL,
  `WORD_COUNT` VARCHAR(4) NULL DEFAULT NULL,
  `SONG_ID` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`LYRICS_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`mood`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`mood` (
  `MOOD_ID` VARCHAR(7) NOT NULL,
  `SONG_ID` VARCHAR(15) NULL DEFAULT NULL,
  `DATING_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `VIOLENCE_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `WORLDLIFE_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `NIGHTTIME_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `SHAKING_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `FAM_GOSPEL_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `ROMANTIC_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `COMMS_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `OBSCENE_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `MUSIC_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `MOVMTPLACES_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `VISUAL_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `FAM_SPIRIT_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `LIKE_GIRLS_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `SADNESS_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `FEELINGS_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `DANCE_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `LOUDNESS_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `ACOUSTIC_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `INSTRUMENT_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `VALANCE_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  `ENERGY_VAL` DECIMAL(11,10) NULL DEFAULT NULL,
  PRIMARY KEY (`MOOD_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`playlist` (
  `PLAYLIST_ID` VARCHAR(7) NOT NULL,
  `PLAYLIST_NAME` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`PLAYLIST_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`playlist_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`playlist_genre` (
  `PLAYLIST_ID` VARCHAR(7) NOT NULL,
  `GENRE_ID` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`PLAYLIST_ID`, `GENRE_ID`),
  INDEX `fk_playlist_has_genre_genre1_idx` (`GENRE_ID` ASC) VISIBLE,
  INDEX `fk_playlist_has_genre_playlist1_idx` (`PLAYLIST_ID` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_genre_genre1`
    FOREIGN KEY (`GENRE_ID`)
    REFERENCES `projectdb`.`genre` (`GENRE_ID`),
  CONSTRAINT `fk_playlist_has_genre_playlist1`
    FOREIGN KEY (`PLAYLIST_ID`)
    REFERENCES `projectdb`.`playlist` (`PLAYLIST_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`topic` (
  `TOPIC_ID` VARCHAR(7) NOT NULL,
  `TOPIC_NAME` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`TOPIC_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`song` (
  `SONG_ID` VARCHAR(15) NOT NULL,
  `SONG_NAME` TEXT NULL DEFAULT NULL,
  `ARTIST_ID` VARCHAR(7) NOT NULL,
  `RELEASE_DATE` VARCHAR(4) NULL DEFAULT NULL,
  `GENRE_ID` VARCHAR(7) NOT NULL,
  `LYRICS_ID` VARCHAR(15) NOT NULL,
  `MOOD_ID` VARCHAR(7) NOT NULL,
  `TOPIC_ID` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`SONG_ID`, `ARTIST_ID`, `TOPIC_ID`),
  INDEX `fk_song_genre1_idx` (`GENRE_ID` ASC) VISIBLE,
  INDEX `fk_song_lyrics1_idx` (`LYRICS_ID` ASC) VISIBLE,
  INDEX `fk_song_mood1_idx` (`MOOD_ID` ASC) VISIBLE,
  INDEX `fk_song_topic1_idx` (`TOPIC_ID` ASC) VISIBLE,
  CONSTRAINT `fk_song_genre1`
    FOREIGN KEY (`GENRE_ID`)
    REFERENCES `projectdb`.`genre` (`GENRE_ID`),
  CONSTRAINT `fk_song_lyrics1`
    FOREIGN KEY (`LYRICS_ID`)
    REFERENCES `projectdb`.`lyrics` (`LYRICS_ID`),
  CONSTRAINT `fk_song_mood1`
    FOREIGN KEY (`MOOD_ID`)
    REFERENCES `projectdb`.`mood` (`MOOD_ID`),
  CONSTRAINT `fk_song_topic1`
    FOREIGN KEY (`TOPIC_ID`)
    REFERENCES `projectdb`.`topic` (`TOPIC_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`playlist_songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`playlist_songs` (
  `PLAYLIST_ID` VARCHAR(7) NOT NULL,
  `SONG_ID` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PLAYLIST_ID`, `SONG_ID`),
  INDEX `SONG_ID` (`SONG_ID` ASC) VISIBLE,
  CONSTRAINT `playlist_song_list_ibfk_1`
    FOREIGN KEY (`PLAYLIST_ID`)
    REFERENCES `projectdb`.`playlist` (`PLAYLIST_ID`),
  CONSTRAINT `playlist_song_list_ibfk_2`
    FOREIGN KEY (`SONG_ID`)
    REFERENCES `projectdb`.`song` (`SONG_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`playlist_topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`playlist_topic` (
  `playlist_PLAYLIST_ID` VARCHAR(7) NOT NULL,
  `TOPIC_ID` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`playlist_PLAYLIST_ID`, `TOPIC_ID`),
  INDEX `fk_playlist_has_topic_topic1_idx` (`TOPIC_ID` ASC) VISIBLE,
  INDEX `fk_playlist_has_topic_playlist1_idx` (`playlist_PLAYLIST_ID` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_topic_playlist1`
    FOREIGN KEY (`playlist_PLAYLIST_ID`)
    REFERENCES `projectdb`.`playlist` (`PLAYLIST_ID`),
  CONSTRAINT `fk_playlist_has_topic_topic1`
    FOREIGN KEY (`TOPIC_ID`)
    REFERENCES `projectdb`.`topic` (`TOPIC_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`user` (
  `USER_ID` VARCHAR(5) NOT NULL,
  `USERNAME` VARCHAR(15) NULL DEFAULT NULL,
  `USER_EMAIL` VARCHAR(30) NULL DEFAULT NULL,
  `USER_PW` VARCHAR(15) NULL DEFAULT NULL,
  `ROLE_ID` VARCHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (`USER_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`user_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`user_playlist` (
  `USER_ID` VARCHAR(5) NOT NULL,
  `PLAYLIST_ID` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`PLAYLIST_ID`, `USER_ID`),
  INDEX `PLAYLIST_ID` (`PLAYLIST_ID` ASC) VISIBLE,
  CONSTRAINT `user_playlist_ibfk_1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `projectdb`.`user` (`USER_ID`),
  CONSTRAINT `user_playlist_ibfk_2`
    FOREIGN KEY (`PLAYLIST_ID`)
    REFERENCES `projectdb`.`playlist` (`PLAYLIST_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`user_role` (
  `ROLE_ID` VARCHAR(3) NOT NULL,
  `ROLE_NAME` VARCHAR(15) NULL DEFAULT NULL,
  `USER_ID` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`ROLE_ID`, `USER_ID`),
  INDEX `USER_ID` (`USER_ID` ASC) VISIBLE,
  CONSTRAINT `user_role_ibfk_1`
    FOREIGN KEY (`USER_ID`)
    REFERENCES `projectdb`.`user` (`USER_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `projectdb`.`song_has_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projectdb`.`song_has_artist` (
  `song_SONG_ID` VARCHAR(15) NOT NULL,
  `song_ARTIST_ID` VARCHAR(4) NOT NULL,
  `song_TOPIC_ID` VARCHAR(3) NOT NULL,
  `artist_ARTIST_ID` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`song_SONG_ID`, `song_ARTIST_ID`, `song_TOPIC_ID`, `artist_ARTIST_ID`),
  INDEX `fk_song_has_artist_artist1_idx` (`artist_ARTIST_ID` ASC) VISIBLE,
  INDEX `fk_song_has_artist_song1_idx` (`song_SONG_ID` ASC, `song_ARTIST_ID` ASC, `song_TOPIC_ID` ASC) VISIBLE,
  CONSTRAINT `fk_song_has_artist_song1`
    FOREIGN KEY (`song_SONG_ID` , `song_ARTIST_ID` , `song_TOPIC_ID`)
    REFERENCES `projectdb`.`song` (`SONG_ID` , `ARTIST_ID` , `TOPIC_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_song_has_artist_artist1`
    FOREIGN KEY (`artist_ARTIST_ID`)
    REFERENCES `projectdb`.`artist` (`ARTIST_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
