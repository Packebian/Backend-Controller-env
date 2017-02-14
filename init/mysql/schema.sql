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
-- Table `Infos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Infos`;

CREATE TABLE IF NOT EXISTS `Infos` (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	maintainer VARCHAR(255) NOT NULL,
	architecture VARCHAR(255) NOT NULL,
	major VARCHAR(255),
	class VARCHAR(255),
	description TEXT,
	dependencies TEXT,
	createdAt DATETIME DEFAULT NOW(),
	updatedAt DATETIME DEFAULT NOW(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `uq_infos_name` (`name` ASC)
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Tickets`;

CREATE TABLE IF NOT EXISTS `Tickets` (
	id INT NOT NULL AUTO_INCREMENT,
	user_id INT NOT NULL,
	info_id INT NOT NULL,
	status INT DEFAULT 0,
	createdAt DATETIME DEFAULT NOW(),
	updatedAt DATETIME DEFAULT NOW(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `uq_tickets_info` (`info_id` ASC),
	CONSTRAINT `fk_tickets_user_id`
		FOREIGN KEY (`user_id`)
		REFERENCES `Users` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT `fk_tickets_info_id`
		FOREIGN KEY (`info_id`)
		REFERENCES `Infos` (`id`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Packages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Packages`;

CREATE TABLE IF NOT EXISTS `Packages` (
	id INT NOT NULL AUTO_INCREMENT,
	user_id INT NOT NULL,
	info_id INT NOT NULL,
	ticket_id INT,
	createdAt DATETIME DEFAULT NOW(),
	updatedAt DATETIME DEFAULT NOW(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `uq_packages_info` (`info_id` ASC),
	UNIQUE INDEX `uq_packages_ticket` (`ticket_id` ASC),
	CONSTRAINT `fk_packages_user_id`
		FOREIGN KEY (`user_id`)
		REFERENCES `Users` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT `fk_packages_info_id`
		FOREIGN KEY (`info_id`)
		REFERENCES `Infos` (`id`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	CONSTRAINT `fk_packages_ticket_id`
		FOREIGN KEY (`ticket_id`)
		REFERENCES `Tickets` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Versions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Versions`;

CREATE TABLE IF NOT EXISTS `Versions` (
	id INT NOT NULL AUTO_INCREMENT,
	version INT(255) NOT NULL,
	info_id INT NOT NULL,
	createdAt DATETIME DEFAULT NOW(),
	updatedAt DATETIME DEFAULT NOW(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `uq_versions_info` (`version` ASC, `info_id` ASC),
	CONSTRAINT `fk_versions_info_id`
		FOREIGN KEY (`info_id`)
		REFERENCES `Infos` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Builds`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Builds`;

CREATE TABLE IF NOT EXISTS `Builds` (
	id INT NOT NULL AUTO_INCREMENT,
	start DATETIME NOT NULL,
	version INT NOT NULL,
	package_id INT NOT NULL,
	result INT,
	createdAt DATETIME DEFAULT NOW(),
	updatedAt DATETIME DEFAULT NOW(),
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_builds_package_id`
		FOREIGN KEY (`package_id`)
		REFERENCES `Packages` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Votes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Votes`;

CREATE TABLE IF NOT EXISTS `Votes` (
	id INT NOT NULL AUTO_INCREMENT,
	user_id INT NOT NULL,
	ticket_id INT NOT NULL,
	vote INT,
	createdAt DATETIME DEFAULT NOW(),
	updatedAt DATETIME DEFAULT NOW(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `uq_votes_userTicket` (`user_id` ASC, `ticket_id` ASC),
	CONSTRAINT `fk_votes_ticket_id`
		FOREIGN KEY (`ticket_id`)
		REFERENCES `Tickets` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
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
-- Data for table `Infos`
-- -----------------------------------------------------
INSERT INTO `Infos` (`id`, `name`, `maintainer`, `architecture`, `major`, `class`, `description`, `dependencies`) VALUES (1, 'paraview', 'vincent.danjean@imag.fr', 'all', 'RICM5', 'VISU', 'open-source photoshop', 'python');
INSERT INTO `Infos` (`id`, `name`, `maintainer`, `architecture`, `major`, `class`, `description`, `dependencies`) VALUES (2, 'lustre', 'nicolas.palix@imag.fr', 'all', 'RICM3', 'ALM1', 'boole algebra', '');
INSERT INTO `Infos` (`id`, `name`, `maintainer`, `architecture`, `major`, `class`, `description`, `dependencies`) VALUES (3, 'r-studio', 'vincent.danjean@imag.fr', 'all', 'RICM3', 'PS', 'IDE for R', 'r');
INSERT INTO `Infos` (`id`, `name`, `maintainer`, `architecture`, `major`, `class`, `description`, `dependencies`) VALUES (4, 'python', 'vincent.danjean@imag.fr', 'all', 'RICM4', 'CSE', 'python language', '');
INSERT INTO `Infos` (`id`, `name`, `maintainer`, `architecture`, `major`, `class`, `description`, `dependencies`) VALUES (5, 'eclipse', 'vincent.danjean@imag.fr', 'all', 'RICM', 'AOO', 'IDE for java', 'java javac');

-- -----------------------------------------------------
-- Data for table `Tickets`
-- -----------------------------------------------------
INSERT INTO `Tickets` (`id`, `user_id`, `info_id`, `status`) VALUES (1, 3, 1, 1);
INSERT INTO `Tickets` (`id`, `user_id`, `info_id`, `status`) VALUES (2, 3, 4, 0);
INSERT INTO `Tickets` (`id`, `user_id`, `info_id`, `status`) VALUES (3, 3, 5, -1);

-- -----------------------------------------------------
-- Data for table `Packages`
-- -----------------------------------------------------
INSERT INTO `Packages` (`id`, `user_id`, `info_id`, `ticket_id`) VALUES (1, 1, 1, 1);
INSERT INTO `Packages` (`id`, `user_id`, `info_id`, `ticket_id`) VALUES (2, 2, 2, NULL);
INSERT INTO `Packages` (`id`, `user_id`, `info_id`, `ticket_id`) VALUES (3, 3, 3, NULL);

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
