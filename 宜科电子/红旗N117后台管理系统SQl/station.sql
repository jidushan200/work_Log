/*
SQLyog Community v13.1.4  (64 bit)
MySQL - 8.0.15 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `station` (
	`id` int (11),
	`name` varchar (120),
	`site` int (11),
	`type` varchar (120),
	`id_position` int (11),
	`name_position` varchar (120),
	`host` varchar (120),
	`port` varchar (120),
	`host_data` varchar (120),
	`port_data` varchar (120),
	`use_ec` int (11),
	`id_ec` int (11),
	`use_scan` int (11),
	`id_scan` int (11),
	`use_nut` int (11),
	`id_nut` int (11),
	`use_entry` int (11),
	`id_entry` int (11),
	`fix` int (11),
	`timestamp` timestamp ,
	`pdm` text 
); 
insert into `station` (`id`, `name`, `site`, `type`, `id_position`, `name_position`, `host`, `port`, `host_data`, `port_data`, `use_ec`, `id_ec`, `use_scan`, `id_scan`, `use_nut`, `id_nut`, `use_entry`, `id_entry`, `fix`, `timestamp`, `pdm`) values('70101','车门拧紧','0','0','1','左后门拧紧','181.167.100.1','4545','','','1','1','1','1','0','0','0','0','0','2021-09-01 13:35:00','{\"img\":\"pdm/70101-1-1.png\",\"pos\":[{\"idx\":\"1\",\"x\":\"582\",\"y\":\"20\"},{\"idx\":\"2\",\"x\":\"574\",\"y\":\"319\"},{\"idx\":\"3\",\"x\":\"509\",\"y\":\"94\"},{\"idx\":\"4\",\"x\":\"498\",\"y\":\"348\"},{\"idx\":\"5\",\"x\":\"493\",\"y\":\"487\"}]}');
insert into `station` (`id`, `name`, `site`, `type`, `id_position`, `name_position`, `host`, `port`, `host_data`, `port_data`, `use_ec`, `id_ec`, `use_scan`, `id_scan`, `use_nut`, `id_nut`, `use_entry`, `id_entry`, `fix`, `timestamp`, `pdm`) values('70101','车门拧紧','0','0','2','左后门拧紧','181.167.100.1','4545','','','1','2','1','1','0','0','0','0','0','2022-05-18 09:22:19','{\"img\":\"pdm/70101-2-1.png\",\"pos\":[{\"idx\":\"1\",\"x\":\"554\",\"y\":\"45\"}]}');
insert into `station` (`id`, `name`, `site`, `type`, `id_position`, `name_position`, `host`, `port`, `host_data`, `port_data`, `use_ec`, `id_ec`, `use_scan`, `id_scan`, `use_nut`, `id_nut`, `use_entry`, `id_entry`, `fix`, `timestamp`, `pdm`) values('70102','车门拧紧','0','0','1','右后门拧紧','181.167.100.1','4545','','','1','1','1','1','0','0','0','0','0','2022-05-18 09:21:56','{\"img\":\"pdm/70102-1-2.png\",\"pos\":[{\"idx\":\"1\",\"x\":\"102\",\"y\":\"30\"},{\"idx\":\"2\",\"x\":\"102\",\"y\":\"296\"},{\"idx\":\"3\",\"x\":\"173\",\"y\":\"72\"},{\"idx\":\"4\",\"x\":\"185\",\"y\":\"350\"},{\"idx\":\"5\",\"x\":\"186\",\"y\":\"491\"}]}');
insert into `station` (`id`, `name`, `site`, `type`, `id_position`, `name_position`, `host`, `port`, `host_data`, `port_data`, `use_ec`, `id_ec`, `use_scan`, `id_scan`, `use_nut`, `id_nut`, `use_entry`, `id_entry`, `fix`, `timestamp`, `pdm`) values('70102','车门拧紧','0','0','2','右后门拧紧','181.167.100.1','4545','','','1','2','1','1','0','0','0','0','0','2022-05-18 10:40:16','{\"img\":\"pdm/70102-2-2.png\",\"pos\":[{\"idx\":\"1\",\"x\":\"146\",\"y\":\"46\"}]}');
insert into `station` (`id`, `name`, `site`, `type`, `id_position`, `name_position`, `host`, `port`, `host_data`, `port_data`, `use_ec`, `id_ec`, `use_scan`, `id_scan`, `use_nut`, `id_nut`, `use_entry`, `id_entry`, `fix`, `timestamp`, `pdm`) values('70103','车门拧紧','0','0','1','左前门拧紧','181.167.100.1','4545','','','1','1','1','1','0','0','0','0','0','2022-05-18 11:08:37','{\"img\":\"pdm/70103-1-3.png\",\"pos\":[{\"idx\":\"1\",\"x\":\"684\",\"y\":\"18\"},{\"idx\":\"2\",\"x\":\"673\",\"y\":\"337\"},{\"idx\":\"3\",\"x\":\"582\",\"y\":\"81\"},{\"idx\":\"4\",\"x\":\"580\",\"y\":\"397\"}]}');
insert into `station` (`id`, `name`, `site`, `type`, `id_position`, `name_position`, `host`, `port`, `host_data`, `port_data`, `use_ec`, `id_ec`, `use_scan`, `id_scan`, `use_nut`, `id_nut`, `use_entry`, `id_entry`, `fix`, `timestamp`, `pdm`) values('70103','车门拧紧','0','0','2','左前门拧紧','181.167.100.1','4545','','','1','2','1','1','0','0','0','0','0','2022-05-18 11:10:02','{\"img\":\"pdm/70103-2-3.png\",\"pos\":[{\"idx\":\"1\",\"x\":\"627\",\"y\":\"40\"},{\"idx\":\"2\",\"x\":\"604\",\"y\":\"366\"}]}');
insert into `station` (`id`, `name`, `site`, `type`, `id_position`, `name_position`, `host`, `port`, `host_data`, `port_data`, `use_ec`, `id_ec`, `use_scan`, `id_scan`, `use_nut`, `id_nut`, `use_entry`, `id_entry`, `fix`, `timestamp`, `pdm`) values('70104','车门拧紧','0','0','1','右前门拧紧','181.167.100.1','4545','','','1','1','1','1','0','0','0','0','0','2022-05-18 11:20:12','{\"img\":\"pdm/70104-1-4.png\",\"pos\":[{\"idx\":\"1\",\"x\":\"91\",\"y\":\"19\"},{\"idx\":\"2\",\"x\":\"112\",\"y\":\"349\"},{\"idx\":\"3\",\"x\":\"183\",\"y\":\"85\"},{\"idx\":\"4\",\"x\":\"177\",\"y\":\"411\"}]}');
insert into `station` (`id`, `name`, `site`, `type`, `id_position`, `name_position`, `host`, `port`, `host_data`, `port_data`, `use_ec`, `id_ec`, `use_scan`, `id_scan`, `use_nut`, `id_nut`, `use_entry`, `id_entry`, `fix`, `timestamp`, `pdm`) values('70104','车门拧紧','0','0','2','右前门拧紧','181.167.100.1','4545','','','1','2','1','1','0','0','0','0','0','2022-05-18 11:20:46','{\"img\":\"pdm/70104-2-4.png\",\"pos\":[{\"idx\":\"1\",\"x\":\"140\",\"y\":\"48\"},{\"idx\":\"2\",\"x\":\"162\",\"y\":\"382\"}]}');
