use [VWNFDB_TJ]

declare @Path varchar(2000)
--获取路径下的文件

set @Path='D:\Photo\猫猫虫咖波\'

--获取共享目录中的文件列表
if OBJECT_ID('tempdb..#FileText') is not null drop table #FileText;
create table #FileText
	(
		id int identity ,  --编号
		filename varchar(200) ,  --文件名
		depth int , --深度，相对与@path
		IsFile bit
	);
insert  #FileText
exec master.dbo.xp_dirtree @Path,0,1;

--select * from #FileText order by IsFile;

insert into [ftpdatafile] select [filename],[depth],[IsFile] from #FileText