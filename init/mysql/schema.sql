create database if not exists Packebian;

use Packebian;

alter table LOGS drop foreign key fk_LOG_ID_PACKETS;
alter table PACKETS drop foreign key fk_PACKET_ID_TICKETS;
alter table PACKETS drop foreign key fk_PACKET_ID_USERS;
alter table TICKETS drop foreign key fk_TICKET_ID_USERS;

drop table if exists LOGS, PACKETS, TICKETS, USERS;

create table USERS (
	ID int not null auto_increment,
	LASTNAME varchar(255),
	FIRSTNAME varchar(255),
	EMAIL varchar(255),
	-- STATUS :
	-- 0 : simple user by default
	-- 1 : administrator
	-- 2 : super-administrator
	STATUS int default 0,
	primary key (ID)
);

create table TICKETS (
	ID int not null auto_increment,
	ID_USER int not null,
	NAME varchar(255),
	VERSION varchar(255),
	ARCHITECTURE varchar(255),
	MAINTAINER varchar(255),
	FILIERE varchar(255),
	CLASS varchar(255),
	DESCRIPTION text,
	DEPENDENCIES text,
	-- STATUS :
	-- -1 : refused
	--  0 : waiting (default)
	--  1 : validated
	STATUS int default 0,
	primary key (ID),
	constraint fk_TICKETS_ID_USER foreign key (ID_USER) references USERS(ID) on delete cascade
);

create table PACKETS (
	ID int not null auto_increment,
	ID_USER int not null,
	-- ID_TICKET :
	-- even administrator must create a ticket to create a package. These tickets will be automatically be validated though.
	ID_TICKET int not null,
	primary key (ID),
	constraint fk_PACKETS_ID_USER foreign key (ID_USER) references USERS(ID) on delete cascade,
	constraint fk_PACKETS_ID_TICKET foreign key (ID_TICKET) references TICKETS(ID) on delete cascade
);

create table LOGS (
	ID int not null auto_increment,
	ID_PACKET int not null,
	DATE_BUILD date,
	DETAILS text,
	primary key (ID),
	constraint fk_LOGS_ID_PACKET foreign key (ID_PACKET) references PACKETS(ID) on delete cascade
);
