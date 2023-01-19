use [VWNFDB_TJ]

update lasttime set timestamp = GETDATE() where code = 'T13';

update rfidscan set ID_Code = 'PE202340210110',model = 'AU253' where code = 'T13';


delete from tm_resultcurrent where code = 'T13';

insert into tm_resultcurrent(id,code,timestamp,ip,Tightening_Status) values
		(9,'T13',GETDATE(),'192.168.1.10:4545',0),
		(10,'T13',GETDATE(),'192.168.1.10:4545',0),
		(11,'T13',GETDATE(),'192.168.1.10:4545',1),
		(12,'T13',GETDATE(),'192.168.1.10:4545',0),
		(13,'T13',GETDATE(),'192.168.1.10:4545',0),
		(14,'T13',GETDATE(),'192.168.1.10:4545',1)
