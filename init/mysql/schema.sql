-- -----------------------------------------------------
-- Begin of sql script
-- -----------------------------------------------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema `Packebian`
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Packebian` ;

CREATE SCHEMA IF NOT EXISTS `Packebian` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Packebian`;

-- -----------------------------------------------------
-- Table `Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Users`;

CREATE TABLE IF NOT EXISTS `Users` (
	id INT NOT NULL AUTO_INCREMENT,
	username VARCHAR(255),
	lastname VARCHAR(255),
	firstname VARCHAR(255),
	email VARCHAR(255),
	-- userlevel :
	-- 0 : simple user by default
	-- 1 : administrator
	-- 2 : super-administrator
	userlevel INT DEFAULT 0,
	createdAt DATETIME DEFAULT NOW(),
	updatedAt DATETIME DEFAULT NOW(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `uq_users_username` (`username` ASC),
	UNIQUE INDEX `uq_users_email` (`email` ASC)
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Begin of transaction (data insertion)
-- -----------------------------------------------------
START TRANSACTION;

-- -----------------------------------------------------
-- Data for table `Users`
-- -----------------------------------------------------
INSERT INTO `Users` (`id`, `username`, `lastname`, `firstname`, `email`, `userlevel`) VALUES (1, 'vdanjean', 'DANJEAN', 'Vincent', 'vincent.danjean@imag.fr', 2);
INSERT INTO `Users` (`id`, `username`, `lastname`, `firstname`, `email`, `userlevel`) VALUES (2, 'npalix', 'PALIX', 'Nicolas', 'nicolas.palix@imag.fr', 1);
INSERT INTO `Users` (`id`, `username`, `lastname`, `firstname`, `email`, `userlevel`) VALUES (3, 'pmorat', 'MORAT', 'Philippe', 'phillipe.morat@imag.fr', 0);

-- -----------------------------------------------------
-- End of transaction (data insertion)
-- -----------------------------------------------------
COMMIT;

-- -----------------------------------------------------
-- End of script
-- -----------------------------------------------------

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
