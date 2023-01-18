--exec gtnew_querydata_sel 'CJ202241511608', 'NF', 0
--exec gtnew_querydata_sel 'CJ201840210111', 'NF', 0

--select Top(1) *  from tm_result;

--select * from tm_result where [Additional] is not null 
/****** SSMS µÄ SelectTopNRows ÃüÁîµÄ½Å±¾  ******/
--SELECT TOP (1000) [model]
--      ,[code]
--      ,[number]
--      ,[column]
--      ,[screwname]
--  FROM [VWNFDB_TJ].[dbo].[tm_screw]
--  where [column] = '0'


--  --exec gtnew_querydata_sel 'CJ202241511608', 'NF', 0

select isnull (1, '')
select isnull (0, '')
select isnull (null, '')