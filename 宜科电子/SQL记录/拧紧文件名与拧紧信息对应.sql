use [VWNFDB_TJ]

declare @Path varchar(2000)
--��ȡ·���µ��ļ�

set @Path='D:\Photo\èè�濧��\'

--��ȡ����Ŀ¼�е��ļ��б�
if OBJECT_ID('tempdb..#FileText') is not null drop table #FileText;
create table #FileText
	(
		id int identity ,  --���
		filename varchar(200) ,  --�ļ���
		depth int , --��ȣ������@path
		IsFile bit
	);
insert  #FileText
exec master.dbo.xp_dirtree @Path,0,1;

--select * from #FileText order by IsFile;

insert into [ftpdatafile] select [filename],[depth],[IsFile] from #FileText