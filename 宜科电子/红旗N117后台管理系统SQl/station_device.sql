/*
SQLyog Community v13.1.4  (64 bit)
MySQL - 8.0.15 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `tighten_device` (
	`id` int (11),
	`name` varchar (120),
	`type` int (11),
	`use` int (11),
	`host` varchar (120),
	`use_op` int (11),
	`port_op` varchar (120),
	`use_scan` int (11),
	`use_nut` int (11),
	`use_xml` int (11),
	`port_a` varchar (120),
	`port_b` varchar (120),
	`timestamp` timestamp 
); 
insert into `tighten_device` (`id`, `name`, `type`, `use`, `host`, `use_op`, `port_op`, `use_scan`, `use_nut`, `use_xml`, `port_a`, `port_b`, `timestamp`) values('1','扳手1','0','1','181.167.100.6','1','4545','0','0','1','4700','4710','2019-04-07 10:46:11');
insert into `tighten_device` (`id`, `name`, `type`, `use`, `host`, `use_op`, `port_op`, `use_scan`, `use_nut`, `use_xml`, `port_a`, `port_b`, `timestamp`) values('2','扳手2','0','1','181.167.100.8','1','4545','0','0','1','4700','4710','2019-04-07 10:46:11');
insert into `tighten_device` (`id`, `name`, `type`, `use`, `host`, `use_op`, `port_op`, `use_scan`, `use_nut`, `use_xml`, `port_a`, `port_b`, `timestamp`) values('3','扳手3','0','0','181.167.100.7','1','4545','0','0','1','4700','4710','2019-04-07 10:46:11');
insert into `tighten_device` (`id`, `name`, `type`, `use`, `host`, `use_op`, `port_op`, `use_scan`, `use_nut`, `use_xml`, `port_a`, `port_b`, `timestamp`) values('4','扳手4','0','0','181.167.100.9','1','4545','0','0','1','4700','4710','2019-04-07 10:46:11');
insert into `tighten_device` (`id`, `name`, `type`, `use`, `host`, `use_op`, `port_op`, `use_scan`, `use_nut`, `use_xml`, `port_a`, `port_b`, `timestamp`) values('5','扳手5','0','0','181.167.100.11','1','4545','0','0','1','4700','4710','2019-04-07 10:46:11');
