use [VWNFDB_TJ]
exec gtnew_querydata_sel 'CJ202241511608', 'NF', 0
--exec gtnew_querydata_sel 'CJ201840210111', 'NF', 0
--exec [gtnew_querydata_sel] 'CJ201840210110', 'NF', 0
--select LEN('')

--declare @output table([line] nvarchar(1000))

--delete from @output
--insert into @output([line])
--exec [master].dbo.xp_cmdshell 'dir D:\ftpdata\'

--select * from @output where charindex('192.168.1.10PRG_320190504_104538_4_OK.txt',line) > 0



--declare @IP nvarchar(50),@PRG NVARCHAR(3) ,@TighteningTime NVARCHAR(100),@OkCount nvarchar(10),@Result nvarchar(10),@id bigint
--set @id = 3;

--set @IP = (select ip from tm_result where id = @id);
--set @PRG = (select Program_ID from tm_result where id = @id);
--set @TighteningTime = (select convert(NVARCHAR(100), (select timestamp from tm_result where id = @id), 120));
--set @OkCount = (select OkCount from tm_result where id = @id);
--set @Result = (select Tightening_Status from tm_result where id = @id);

----select @IP,@PRG,@TighteningTime,@OkCount,@Result

--declare @STR nvarchar(200)

--set @IP = SUBSTRING(@IP,0,CHARINDEX(':',@ip))
--set @PRG = (select substring(@PRG,PATINDEX ('%[1-9]%',@PRG),LEN(@PRG)))
--set @TighteningTime = (select REPLACE(Substring(@TighteningTime,1, 10),'-','') ) + '_' + (select REPLACE(Substring(@TighteningTime,12, 9),':','') )
--set @Result = (select case @Result when '1' then 'OK' when '0' then 'NOK'end)


--set @STR = @IP + 'PRG_' + @PRG+@TighteningTime + '_' + @OkCount + '_' + @Result + '.txt'

----select @IP,@PRG,@TighteningTime,@OkCount,@Result
--select @STR


--declare @output table([line] nvarchar(1000))

--delete from @output
--insert into @output([line])
--exec [master].dbo.xp_cmdshell 'dir D:\ftpdata\'


--if (select COUNT(*) from @output where charindex(@STR,line) > 0) > 0
--begin
--	select 'спнд╪Ч'
--end

--select * from tm_result where id = 3



--select  *  from tm_result;
--select right('099',CHARINDEX('0','099'))

--set @PRG = '129'
--select LEN(@PRG)
--select PATINDEX ('%[1-9]%',@PRG)

--select isnull (1, '')
--select isnull (0, '')
--select isnull (null, '')