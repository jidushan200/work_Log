--DECLARE  cur_test CURSOR FOR SELECT [id] FROM [user]                          --声明游标
--OPEN cur_test                                                           --打开游标
--DECLARE @str   NVARCHAR (3000)
--SET @str = ''
--DECLARE @ID   NVARCHAR (50)
--FETCH NEXT FROM cur_test   INTO @ID
--WHILE (@@FETCH_STATUS = 0)
--BEGIN
--   SET @str = @str + @ID + ','
--   FETCH NEXT FROM cur_test   INTO @ID
--END
--CLOSE cur_test                                                          --关闭游标
--DEALLOCATE cur_test                                               --释放游标资源
--SELECT CASE WHEN len (@str) > 0 THEN left (@str, len (@str) - 1) END  --去除最后的逗号

DECLARE @Num INT,@Count INT--定义变量
DECLARE My_Cursor CURSOR --定义游标
FOR(SELECT num FROM (VALUES (100), (200), (330), (450), (560)) [1 to 5](num)) --查询5个数

OPEN My_Cursor; --打开游标
FETCH NEXT FROM My_Cursor INTO @Num
WHILE(@@FETCH_STATUS = 0)
	BEGIN
		SELECT @Num
		FETCH NEXT FROM My_Cursor INTO @Num
	END
	CLOSE My_Cursor; --关闭游标
DEALLOCATE My_Cursor; --释放游标