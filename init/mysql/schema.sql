create database if not exists Packebian;

use Packebian;

alter table LOG drop foreign key fk_LOG_ID_PACKET;
alter table PACKET drop foreign key fk_PACKET_ID_TICKET;
alter table PACKET drop foreign key fk_PACKET_ID_UTILISATEUR;
alter table TICKET drop foreign key fk_TICKET_ID_UTILISATEUR;

drop table if exists LOG, PACKET, TICKET, UTILISATEUR;
 
create table UTILISATEUR (
	ID int not null auto_increment,
	NOM varchar(255),
	PRENOM varchar(255),
	MAIL varchar(255),
	-- STATUT :
	-- 0 : utilisateur simple par défaut
	-- 1 : administrateur
	-- 2 : super-administrateur
	STATUT int default 0,
	primary key (ID)
);

create table TICKET (
	ID int not null auto_increment,
	ID_UTILISATEUR int not null,
	NOM varchar(255),
	VERSION varchar(255),
	-- ARCHITECTURE : changer en int si les choix sont récurents
	ARCHITECTURE varchar(255),
	MAINTAINER varchar(255),
	FILIERE varchar(255),
	MATIERE varchar(255),
	DESCRIPTION text,
	DEPENDANCES text,
	-- ETAT :
	-- -1 : refusé
	--  0 : en attente par défaut
	--  1 : validé
	ETAT int default 0,
	primary key (ID),
	constraint fk_TICKET_ID_UTILISATEUR foreign key (ID_UTILISATEUR) references UTILISATEUR(ID) on delete cascade
);

create table PACKET (
	ID int not null auto_increment,
	ID_UTILISATEUR int not null,
	-- ID_TICKET :
	-- les administrateurs doivent passer par un ticket qui sera automatiquement validé
	-- dans le but de créer un package
	ID_TICKET int not null,
	primary key (ID),
	constraint fk_PACKET_ID_UTILISATEUR foreign key (ID_UTILISATEUR) references UTILISATEUR(ID) on delete cascade,
	constraint fk_PACKET_ID_TICKET foreign key (ID_TICKET) references TICKET(ID) on delete cascade
);

create table LOG (
	ID int not null auto_increment,
	ID_PACKET int not null,
	DATE_BUILD date,
	DETAILS text,
	primary key (ID),
	constraint fk_LOG_ID_PACKET foreign key (ID_PACKET) references PACKET(ID) on delete cascade
);
