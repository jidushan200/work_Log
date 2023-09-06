### 数据库

临时表的作用空间

Table变量使用
with as使用方法
几个字符串函数
DateTime数据转换位字符串显示格式：
保留小数点显示位数
日期比较函数DateDiff
在SQL脚本里获得存储过程返回的数据集

强制锁表
left join和right join
group by with rollup数据分组统计
partition by数据分组帅选
游标使用
xml解析和遍历方法
PIVOT进行行列转换
例外处理
计算字段创建与使用

临时表的作用域：
本地临时表的名称以单个数字符号 (#) 打头
它们仅对当前的用户连接可见
当用户从 SQL Server 实例断开连接时本地临时表被删除。
临时表操作数据库不记录log，效率高
测试临时表是否存在：（使用连接池时必须测试和删除）
   IF OBJECT_ID ('tempdb..#temp') IS NOT NULL
      DROP TABLE #temp



#### Table变量使用

变形的临时表
举例：

```sql
  DECLARE @tb_test TABLE
                   (
                      [ID]           INT,
                      [Name]         NVARCHAR (20),
                      [timestamp]    DATETIME
                   )
  INSERT INTO @tb_test ([ID], [Name], [TimeStamp])
  VALUES (1, 'test', getdate ())
  SELECT * FROM @tb_test
```

OBJECT_ID()——该方法用于查找#temp是否存在，并提供返回值

```sql
IF OBJECT_ID ('tempdb..#temp') IS NOT NULL
   DROP TABLE #temp                                         --删除临时表
SELECT T.C.value ('id[1]', 'int') AS 'id',
       T.C.value ('name[1]', 'nvarchar(50)') AS 'name'
INTO #temp
FROM @items.nodes ('/root/item') AS T (C)    --提取xml解析结果存入临时表
SELECT * FROM #temp                      --显示
```



#### with as使用方法：

CTE公共表达式，主要是代替临时表，避免降低效率。CTE使用场景极少。
select中多次引用CTE部分才应该使用with as，只引用一次的应该直接写在select中。
举例：用GouBuliDB测试
    WITH
       cr1 AS (SELECT * FROM [user]),
       cr2 AS (SELECT * FROM [userrole])
    SELECT *
    FROM cr1 INNER JOIN cr2 ON cr1.id = cr2.userid

    WITH cte ([id], [name], [hide])
           AS (SELECT a.[id], a.[name], isnull (a.[hide], 0)
                 FROM organization a
                WHERE [id] = 1
               UNION ALL
               SELECT b.[id], b.[name], isnull (b.[hide], 0)
                 FROM organization b
                      INNER JOIN cte c ON c.[id] = b.[pid])
      SELECT * FROM cte



#### 字符串函数

##### 字符串定位：CharIndex

语法：
CHARINDEX ( expressionToFind , expressionToSearch [ , start_location ] )
expressionToFind：目标字符串，就是想要找到的字符串，最大长度为8000 。
expressionToSearch：用于被查找的字符串。
start_location：开始查找的位置，为空时默认从第一位开始查找。
通过CHARINDEX如果能够找到对应的字符串，则返回该字符串位置，否则返回0，索引从1开始。
举例：
select charindex('cd','abcdefg', 1)
select charindex(',1,10,100,', ',10,' )

##### 截取子字符串：Substring

语法：
SUBSTRING ( expression, start, length ) 
expression：字符串、二进制字符串、文本、图像、列或包含列的表达式。请勿使用包含聚合函数的表达式。 
start：整数或可以隐式转换为 int 的表达式，指定子字符串的开始位置，索引是从1开始。 
length： 整数或可以隐式转换为 int 的表达式，指定子字符串的长度，必须大于等于0。
1.如果 expression 是一种支持的二进制数据类型，则返回二进制数据，这种情况我们暂且不讨论。
2.如果 expression 是一种支持的字符数据类型，则返回字符数据。
举例：
select substring('abcdefg', 4, 0)
select substring('abcdefg', 4, 2)

##### 截取左侧子字符串：

语法：
LEFT (<character_expression>， <integer_expression>)
返回character_expression 左起 integer_expression 个字符。

##### 截取右侧子字符串：

语法：
Right(<character_expression>， <integer_expression>)
返回character_expression 右起 integer_expression 个字符。
举例：
select left('abcdefg', 2)
select right('abcdefg', 2)



#### DateTime数据转换位字符串显示格式：

举例：
转换日期时间为字符串格式

```sql
CONVERT (NVARCHAR (20), getdate(), 120)    
--返回：2023-09-06 16:45:18
```

```sql
select CONVERT (NVARCHAR (10), getdate(), 120)
--返回：2023-09-06
```

##### 注意：NVARCHAR (10) 和 NVARCHAR (20)定义的变量长度不同，可以起到截取日期的作用，而不是记忆后面的 120，120这个位置的参数太多不好记，用裁剪的方式简单很多。



#### 保留小数点显示位数

举例：
保留两位小数

```sql
select Convert(numeric(18,2),1.3 / 0.3)    返回：4.33
```



#### 日期比较函数DateDiff

参考：https://www.w3school.com.cn/sql/func_datediff.asp
语法：
DATEDIFF(datepart,startdate,enddate)
datepart：比较时间的粒度，dd按日，mm按月，yy按年，hh按小时，mi按分钟，ss按秒
startdate：起始日期，必须可转换为DateTime
enddate： 结束日期，必须可转换为DateTime
当起始日期 早于 结束日期时，返回值> 0
当起始日期 等于 结束日期时，返回值= 0
当起始日期 晚于 结束日期时，返回值< 0
返回值等于按比较粒度相减后的差值
举例：

```sql
SELECT DATEDIFF(dd,'2008-12-29','2008-12-31')  返回值：2
SELECT DATEDIFF(dd,'2008-12-31','2008-12-29')  返回值：-2
```



#### 在SQL脚本里获得存储过程返回的数据集

使用Insert Into，将存储过程返回的数据行保存到表变量，临时表字段定义必须与返回数据的字段一致，这是唯一的方法。
举例：
  DECLARE @t TABLE
             (
                table_qualifier    VARCHAR (100),
                table_owner        VARCHAR (20),
                table_name         VARCHAR (100),
                table_type         VARCHAR (50),
                remarks            TEXT
             )
  INSERT INTO @t (table_qualifier,
                  table_owner,
                  table_name,
                  table_type,
                  remarks)
  EXEC sp_tables
  SELECT * FROM @t

##### string_split分割字符串为临时数据表

```sql
select  tpo.modelcode
from	t_ptoption tpo
inner join (select value 'paramModel' from string_split(@modelcode,','))
```



#### 强制锁表：

不同线程同时对多个表写入时，防止死锁和数据混乱。
强制排它锁必须处于Transaction中间，COMMIT或ROLLBACK将是释放表锁
举例：
SELECT *
FROM role WITH (TABLOCKX)
WHERE 1 = 0



#### left join和right join：

举例：
  DECLARE @tabperson TABLE(  [personname]    NVARCHAR (50),  [addr]          NVARCHAR (50))
  INSERT INTO @tabperson ([personname], [addr])  VALUES ('张三', '和平区')
  INSERT INTO @tabperson ([personname], [addr])  VALUES ('李四', '南开区')
  INSERT INTO @tabperson ([personname], [addr])  VALUES ('王五', '河西区')
  DECLARE @tabmac   TABLE ([macname]    NVARCHAR (50), [addr]    NVARCHAR (50))
  INSERT INTO @tabmac ([macname], [addr])  VALUES ('食品街餐厅', '和平区')
  INSERT INTO @tabmac ([macname], [addr])  VALUES ('大悦城餐厅', '和平区')
  INSERT INTO @tabmac ([macname], [addr])  VALUES ('永旺餐厅', '西青区')

  SELECT *  FROM @tabperson t1 LEFT JOIN @tabmac t2 ON t1.[addr] = t2.[addr]
  SELECT *  FROM @tabperson t1 RIGHT JOIN @tabmac t2 ON t1.[addr] = t2.[addr]



#### group by with rollup数据分组统计

用group by子句的分类字段进行数据进行分类汇总，用函数grouping()识别数据列是否正被聚合统计
举例：
DECLARE @tabscore TABLE
                  ([name]     NVARCHAR (10),  [addr]     NVARCHAR (10),  [sex]      NVARCHAR (10),   [class]    NVARCHAR (10),   [score]    NUMERIC (18, 2))
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('赵飞燕', '和平区', '女', '1班', 96)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('冯晓丹', '南开区', '女', '1班', 90)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('陈吉轩', '南开区', '男', '1班', 85.5)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('李媛媛', '河西区', '女', '2班', 88)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('万兴国', '南开区', '男', '2班', 95)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('刘德发', '河东区', '男', '2班', 92.5)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('李健',    '和平区',  '男', '3班', 99)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('汪峰',    '河西区',  '男', '3班', 80)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('刘金武', '南开区',  '男', '3班', 83)
SELECT 
       CASE  WHEN grouping ([class]) = 1  THEN  '总计'
             WHEN grouping ([class]) = 0 AND GROUPING ([addr]) = 1  THEN  [class] + '小计'
             ELSE  [class]   END AS 'class',
       CASE  WHEN grouping ([addr]) = 0 AND grouping ([sex]) = 1 THEN  [addr] + '小计'
             ELSE  [addr]   END AS 'addr',
       [sex],
       count (*) AS 'Persons',
       sum ([score]) AS 'Score'
FROM @tabscore
GROUP BY [class], [addr], [sex] WITH ROLLUP
--HAVING grouping(addr) = 1  --只出班级小计
--HAVING grouping(class) = 1  --只出总计



#### partition by数据分组帅选

##### partition  by用于给结果集分组排序

举例：
DECLARE @tabscore TABLE
                  ([name]     NVARCHAR (10),  [addr]     NVARCHAR (10),  [sex]      NVARCHAR (10),   [class]    NVARCHAR (10),   [score]    NUMERIC (18, 2))
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('赵飞燕', '和平区', '女', '1班', 96)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('冯晓丹', '南开区', '女', '1班', 90)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('陈吉轩', '南开区', '男', '1班', 85.5)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('李媛媛', '河西区', '女', '2班', 88)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('万兴国', '南开区', '男', '2班', 95)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('刘德发', '河东区', '男', '2班', 92.5)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('李健',    '和平区',  '男', '3班', 99)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('汪峰',    '河西区',  '男', '3班', 80)
INSERT INTO @tabscore ([name], [addr], [sex], [class], [score]) VALUES ('刘金武', '南开区',  '男', '3班', 83)
SELECT *,
       Row_Number () OVER (ORDER BY [name]) AS 'NameID',
       Row_Number () OVER (PARTITION BY [sex] ORDER BY [score]) AS 'Num'
FROM @tabscore

SELECT *
FROM (SELECT *,
             Row_Number () OVER (ORDER BY [name]) AS 'NameID',
             Row_Number () OVER (PARTITION BY [sex] ORDER BY [score]) AS 'Num'
      FROM @tabscore) t
WHERE t.Num = 1



#### FOR XML PATH使用：

将多行内容合并成字符串
举例：

```sql
DECLARE @t TABLE([ID] INT,  [Name]  NVARCHAR (10))
INSERT INTO @t ([ID], [Name]) VALUES('1', '爬山')
INSERT INTO @t ([ID], [Name]) VALUES('2', '游泳')
INSERT INTO @t ([ID], [Name]) VALUES('3', '美食')
SELECT * FROM @t FOR XML PATH('')
SELECT * FROM @t FOR XML PATH('ROW')
SELECT STUFF((SELECT ',' + [Name] FROM @t FOR XML PATH('')), 1,1,'')
```



#### CROSS APPLY和OUTER APPLY 使用：

对左表做逐行计算，然后用计算结果与左表连接
```sql
DECLARE @t TABLE([ID] INT,  [ColorList]  NVARCHAR (50))
INSERT INTO @t ([ID], [ColorList]) VALUES('1', '白色,红色,绿色')
INSERT INTO @t ([ID], [ColorList]) VALUES('2', NULL)
INSERT INTO @t ([ID], [ColorList]) VALUES('3', '灰色,黄色,橙色')
SELECT t.[ID], t.[ColorList], t1.[Color] FROM @t t
     CROSS APPLY (SELECT [value] AS 'Color' FROM STRING_SPLIT (t.[ColorList], ',')) t1
SELECT t.[ID], t.[ColorList], t1.[Color] FROM @t t
     OUTER APPLY (SELECT [value] AS 'Color' FROM STRING_SPLIT (t.[ColorList], ',')) t1
```



#### 游标使用：

游标可以对结果集的行进行单独操作，一般会用到的是本地、动态游标。游标会占用资源，用后需要关闭和释放。
例子1：

```sql
DECLARE  cur_test CURSOR FOR SELECT [id] FROM [user]                          --声明游标
OPEN cur_test                                                           --打开游标
DECLARE @str   NVARCHAR (3000)
SET @str = ''
DECLARE @ID   NVARCHAR (50)
FETCH NEXT FROM cur_test   INTO @ID
WHILE (@@FETCH_STATUS = 0)
BEGIN
   SET @str = @str + @ID + ','
   FETCH NEXT FROM cur_test   INTO @ID
END
CLOSE cur_test                                                          --关闭游标
DEALLOCATE cur_test                                               --释放游标资源
SELECT CASE WHEN len (@str) > 0 THEN left (@str, len (@str) - 1) END  --去除最后的逗号
```

例子2：

```sql
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
```

例子3：

```sql
DECLARE @code NVARCHAR(20),@number INT,@model NVARCHAR(10)
DECLARE my_cursor CURSOR

FOR(SELECT code,number,model FROM tm_screw)
OPEN my_cursor;
FETCH NEXT FROM my_cursor INTO @code,@number,@model
WHILE(@@FETCH_STATUS = 0)
	BEGIN
		SELECT * FROM tm_screw WHERE code = @code AND number = @number AND model = @model

		FETCH NEXT FROM my_cursor INTO @code,@number,@model
	END
CLOSE my_cursor;
DEALLOCATE my_cursor;
```





#### xml解析和遍历方法：

使用SQL Server的xml类型变量，能自动对xml字符串进行解析，然后可以用select直接操作。
举例：
DECLARE @items   XML
SET @items = '<root>
              <item><id>1</id><name>张三</name></item>
              <item><id>2</id><name>李四</name></item>
              <item><id>3</id><name>王五</name></item>
              </root>'
IF OBJECT_ID ('tempdb..#temp') IS NOT NULL
   DROP TABLE #temp                                         --删除临时表
SELECT T.C.value ('id[1]', 'int') AS 'id',
       T.C.value ('name[1]', 'nvarchar(50)') AS 'name'
INTO #temp
FROM @items.nodes ('/root/item') AS T (C)    --提取xml解析结果存入临时表
SELECT * FROM #temp                      --显示



#### PIVOT进行行列转换：

PIVOT实际是透视表计算，它实际是对内容字段进行聚合运算，用它进行行列转换时必须保证内容部分是数字类型。
举例：
IF OBJECT_ID ('tempdb..#temp') IS NOT NULL
   DROP TABLE #temp                                         --删除临时表
create table #temp
(   [Name]    nvarchar(10)    null,
    [Course]    nvarchar(10)    null,
    [Score]    int        null)
insert into #temp([Name],[Course],[Score])
select '小李','语文','88' union
select '小李','数学','79' union
select '小李','英语','85' union
select '小明','语文','79' union 
select '小明','数学','89' union
select '小明','英语','87' union
select '小红','语文','84' union
select '小红','数学','76' union
select '小红','英语','92' 
select * from #temp
--手工转换
select a.Name 姓名,a.语文,a.数学,a.英语
from #temp 
pivot
(
    max(Score)    -- 指定作为转换的列的值 的列名
    for Course        -- 指定要转换的列的列名
    in(语文,数学,英语)    -- 自定义的目标列名，即要转换列的不同的值作为列
)a
--手工转换，内连接表
select a.Name 姓名,a.语文,a.数学,a.英语,b.SumScore 课程总分,b.AvgScore 课程平均分
from #temp 
pivot
(
    max(Score)    -- 指定作为转换的列的值 的列名
    for Course        -- 指定要转换的列的列名
    in(语文,数学,英语)    -- 自定义的目标列名，即要转换列的不同的值作为列
)a,
(
    select t.Name,sum(t.Score) SumScore,cast(avg(t.Score) as decimal(18,2)) AvgScore
    from #temp t
    group by t.Name
)b
where a.Name=b.Name

--自动转换，不需要手写列名，下面是网上找的示例
--参数化动态PIVOT行转列
-- =============================================
-- Author:        <听风吹雨>
-- Create date: <2014.05.26>
-- Description:    <参数化动态PIVOT行转列>
-- Blog:        <http://www.cnblogs.com/gaizai/>
-- =============================================
DECLARE @sql_str NVARCHAR(MAX)
DECLARE @sql_col NVARCHAR(MAX)
DECLARE @tableName SYSNAME --行转列表
DECLARE @groupColumn SYSNAME --分组字段
DECLARE @row2column SYSNAME --行变列的字段
DECLARE @row2columnValue SYSNAME --行变列值的字段
SET @tableName = '#temp'
SET @groupColumn = 'Name'
SET @row2column = 'Course'
SET @row2columnValue = 'Score'

--从行数据中获取可能存在的列
SET @sql_str = N'
SELECT @sql_col_out = ISNULL(@sql_col_out + '','','''') + QUOTENAME(['+@row2column+']) 
    FROM ['+@tableName+'] GROUP BY ['+@row2column+']'
--PRINT @sql_str
EXEC sp_executesql @sql_str,N'@sql_col_out NVARCHAR(MAX) OUTPUT',@sql_col_out=@sql_col OUTPUT
select @sql_col   --显示转换后的列

SET @sql_str = N'
SELECT * FROM (
    SELECT ['+@groupColumn+'],['+@row2column+'],['+@row2columnValue+'] FROM ['+@tableName+']) p PIVOT 
    (SUM(['+@row2columnValue+']) FOR ['+@row2column+'] IN ( '+ @sql_col +') ) AS pvt 
ORDER BY pvt.['+@groupColumn+']'
EXEC (@sql_str)



#### 例外处理：

用raiserror语句手工引发错误，测试出错时try/catch结构的工作效果
举例：
  IF OBJECT_ID ('temptable') IS NOT NULL
   DROP TABLE temptable   
   create table temptable([num] int null)
   BEGIN TRY
   BEGIN TRANSACTION
      insert into temptable([num]) values(1)
      --raiserror('测试例外',16,1)
      COMMIT;
   END TRY
   BEGIN CATCH
      ROLLBACK
      DECLARE @MESSAGE   NVARCHAR (4000)
      DECLARE @SEVERITY   INT
      DECLARE @STATE   INT
      SET @MESSAGE = ERROR_MESSAGE ()
      SET @SEVERITY = ERROR_SEVERITY ()
      --RAISERROR (@MESSAGE, @SEVERITY, 1)
   END CATCH
select * from temptable
drop table temptable

	IF @targetnumber < @number
		Begin
	     RAISERROR ('实际数量不可大于设定数量!', 16, 1)
		End

#### 计算字段创建与使用：

使用计算字段，类似于视图，但比视图优越的地方在于可以方便设置索引，提高索引集中度，另外可以避免数据冗余和代码。
直接使用SMSS的数据表编辑界面建立计算字段。

#### SQL类型转换

例：获取某日期的数据，比如获取出生日期为2000-01-01以后的数据，且获得的日期为日期格式。假设表名为table，数据的字段为name，age，country，出生日期的字段是born,born字段储存的是字符串的日期比如“2000-02-23”，SQL支持直接用于比较。
select name,age,country,
cast(born as date) as born 
from table
where born >= "2000-01-01"

例如：将“678”转化为数值型数据，并与123相加进行数学运算。
ACCESS:

	SELECT CINT('678') + 123;
或

	SELECT CLNG('678') + 123;

SQLSERVER：

	SELECT CAST('678' AS INT) + 123;
或

	SELECT CONVERT(INT, '678') + 123;
ORACLE：

	SELECT TO_NUMBER('678') + 123 FROM DUAL;
（ORACLE中DUAL是一个虚拟表，用来构成SELECT的语法规则）

MYSQL：

	SELECT CAST('678' AS SIGNED);



#### EXISTS数据重复解决

```sql
IF EXISTS
	(select  tpo.modelcode
     from	t_ptoption tpo
     inner join (select value 'paramModel' from string_split(@modelcode,',')) 				 cc on tpo.modelcode LIKE ('%' + cc.paramModel + '%'))
	BEGIN
		RAISERROR ('车型不可重复！', 16, 1);
	END
```



#### IN关键字的使用

```sql
SELECT * FROM Customers
  WHERE Country IN (SELECT Country FROM Suppliers);
```

```sql
SELECT * FROM Customers
  WHERE Country IN (SELECT Country FROM String_Split('ff,aa,cc',','));
```

```sql
select * from String_Split('ff,aa,cc',',') cc
	where cc.value in (select value from string_split('aa,bb,cc',','));
```



#### select数据insert插入操作方法

##### 联接查询作为数据

```sql
insert into AddressList(name,address)
	select a.UserName,b.address from SYSTEM_Userts a
	inner join BASE_Customer b on a.code = b.code
```

##### UNION合并多个结果集作为数据

```sql
insert into AddressList(name,address)
	select '张三','洛杉矶'
	union
	select '李四','旧金山'
	union
	select '王五','华盛顿'
```

##### 数据来自其他数据库(跨数据库插入)

```sql
insert into StudentInfo(name)
	select lxr from AgroDB.dbo.BASE_Customer
```



#### CASE WHEN不同数据插入判断

##### case when 多个条件

###### 语法：

SELECT nickname,user_name,
CASE WHEN user_rank = '5' THEN '经销商'
		  WHEN user_rank = '6' THEN '代理商'
		  WHEN user_rank = '7' THEN 'VIP'
		  ELSE '注册用户' END AS user_rank
FROM at_users

###### 执行结果：

![1406722-20180607181837757-1246251178](D:\Photo\文档\1406722-20180607181837757-1246251178.png)

##### case when 权重排序

###### 语法：　(case when 条件 then 9 else 0 end) + (case when 条件 then 5 else 0 end) 

![1406722-20180607182303908-993222518](D:\Photo\文档\1406722-20180607182303908-993222518.png)

这样排序出来的好处就是 "搜索出来的结果 更加符合用户想要的内容"

#### 宜科电子本地脚本过大，导入脚本问题

```bat
osql -S DESKTOP-BFU6S7L\zhj -U sa -P root -i D:\zhj\Sqlserver工作区\ChangChunPaintDB_bak_202211080904.sql
```

```bat
sqlcmd -S DESKTOP-BFU6S7L -U sa -P root -i D:\zhj\Sqlserver工作区\ChangChunPaintDB_Framework.sql
```

```sql
osql -S DESKTOP-BFU6S7L -U sa -P root -i  D:\zhj\Sqlserver工作区\ChangChunPaintDB_Framework.sql
```



#### SQL秒转 小时 分 秒 

##### 每位转换

```sql
DECLARE @a int=20000
SELECT CONVERT(VARCHAR(10),@a/60)+'分'+CONVERT(VARCHAR(10),@a%60)+'秒'
--333分20秒

SELECT CONVERT(VARCHAR(10),@a/3600)+'时'+CONVERT(VARCHAR(10),@a%3600/60)+'分'+CONVERT(VARCHAR(10),@a%3600%60)+'秒'
--5时33分20秒
```

#####  公式转换

```sql
SELECT CONVERT(VARCHAR(8),CONVERT(TIME,DATEADD(ss,20000,'1900-01-01 00:00:00'))) 

--05:33:20
```



#### sqlserver数据集转字符串

方法1：

```sql
DECLARE @Curve VARCHAR(100)
SELECT @Curve=ISNULL(@Curve+',','')+  t.[errorstr] FROM (select distinct errorstr  from @errortable) t

select @Curve 'Curve'
```

方法2：

```sql
set @Curve = (select distinct [code] + ',' from tm_datatag where 1=0 for xml path(''))
```





### 开发中遇到的问题

#### 如何关闭easyui中datagrid的默认查询加载时 的 遮罩层

![image-20221116101322342](C:\Users\zhj\AppData\Roaming\Typora\typora-user-images\image-20221116101322342.png)

```txt
/*datagrid刷新屏闪:关*/
.datagrid-mask {
opacity: 0;
filter: alpha(opacity&=0);
}

.datagrid-mask-msg {
opacity: 0;
filter: alpha(opacity=0);
}
```

#### SQL秒转 小时 分 秒 

```txt
SELECT CONVERT(VARCHAR(8),CONVERT(TIME,DATEADD(ss,20000,'1900-01-01 00:00:00'))) 

‘1900-01-01 00:00:00’ 为起点时间，DATEADD用于计算 20000 与 00:00:00之间的差值，第一个参数 ss代表转换单位为秒【其他的单位诸如：
				year, yyyy, yy = Year
                quarter, qq, q = Quarter  季度
                month, mm, m = month
                dayofyear, dy, y = Day of the year
                day, dd, d = Day
                week, ww, wk = Week
                weekday, dw, w = Weekday
                hour, hh = hour
                minute, mi, n = Minute
                second, ss, s = Second
                millisecond, ms = Millisecond
		 】
DateAdd方法具体查询路径：https://www.w3school.com.cn/sql/func_dateadd.asp【中文】
					  https://www.w3schools.com/sql/func_sqlserver_dateadd.asp【EN】
```

#### 不能重复

```txt
出车换色限制: (当前颜色+新换颜色)不能重复；当前颜色 与 新换颜色不能重复
出车颜色数量限制：(区域+颜色代码)不能重复

IF EXISTS
		(SELECT *
			FROM m_284384outcolorgaplimit 
			WHERE [colorcode] = @colorcode  AND
				  [modelcode] = @modelcode	AND
				  [areaid]    <> @areaid	)
		RAISERROR ('颜色与角度 不可重复！', 16, 1);
```
