--DECLARE  cur_test CURSOR FOR SELECT [id] FROM [user]                          --�����α�
--OPEN cur_test                                                           --���α�
--DECLARE @str   NVARCHAR (3000)
--SET @str = ''
--DECLARE @ID   NVARCHAR (50)
--FETCH NEXT FROM cur_test   INTO @ID
--WHILE (@@FETCH_STATUS = 0)
--BEGIN
--   SET @str = @str + @ID + ','
--   FETCH NEXT FROM cur_test   INTO @ID
--END
--CLOSE cur_test                                                          --�ر��α�
--DEALLOCATE cur_test                                               --�ͷ��α���Դ
--SELECT CASE WHEN len (@str) > 0 THEN left (@str, len (@str) - 1) END  --ȥ�����Ķ���

DECLARE @Num INT,@Count INT--�������
DECLARE My_Cursor CURSOR --�����α�
FOR(SELECT num FROM (VALUES (100), (200), (330), (450), (560)) [1 to 5](num)) --��ѯ5����

OPEN My_Cursor; --���α�
FETCH NEXT FROM My_Cursor INTO @Num
WHILE(@@FETCH_STATUS = 0)
	BEGIN
		SELECT @Num
		FETCH NEXT FROM My_Cursor INTO @Num
	END
	CLOSE My_Cursor; --�ر��α�
DEALLOCATE My_Cursor; --�ͷ��α�