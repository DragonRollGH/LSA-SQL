语法：
SELECT column1, column2, columnN 
FROM table_name
WHERE [condition];

语义:
SELECT: 提取记录中column1, column2, columnN字段的值, 返回给下一个语句或直接输出
FROM: 从table_name中提取所有记录, 返回给下一个语句
WHERE: 对记录按[condition]的条件筛选, 返回给下一个语句
聚合函数: 用在SELECT后面的字段, 对记录做整体处理后, 返回给SELECT
普通函数: 用于任何字段或字段值, 对值做处理并返回

执行顺序: 
括号内内容 > FROM > WHERE > 聚合函数 > SELECT

COMPANY:
ID          NAME        AGE         ADDRESS     SALARY
----------  ----------  ----------  ----------  ----------
1           Paul        32          California  20000.0
2           Allen       25          Texas       15000.0
3           Teddy       23          Norway      20000.0
4           Mark        25          Rich-Mond   65000.0
5           David       27          Texas       85000.0
6           Kim         22          South-Hall  45000.0
7           James       24          Houston     10000.0

语句分析: 
例1:
SELECT *
FROM COMPANY;

1. 第二行FROM, 从COMPANY提取所有7条记录, 返回给第一行SELECT
2. 第一行SELECT, * 指代所有字段, 所以输出7条记录的所有字段


例2:
SELECT NAME
FROM COMPANY
WHERE AGE < 30;

1. 第二行FROM, 从COMPANY提取所有7条记录, 返回给第三行WHERE
2. 第三行WHERE, 逐条比较7条记录的AGE字段的值, ID为2~7的记录满足条件, 返回给第一行SELECT
3. 第一行SELECT, 输出ID为2~7的记录的NAME字段的值


例3:
SELECT ID, AGE
FROM COMPANY
WHERE SALARY <
(
    SELECT SALARY
    FROM COMPANY
    WHERE NAME == 'David'
);

1. 先执行五六七行括号内的内容, 第六行FROM, 从COMPANY提取所有7条记录, 返回给第七行WHERE
2. 第七行WHERE, 逐条比较7条记录的NAME值, 只有ID为5的记录满足条件, 返回给第五行SELECT
3. 第五行SELECT, 因为是在括号内的子句, 所以用返回代替输出, 返回ID为5的记录的SALARY字段
4. 所以整个括号等价于 85000.0 
5. 第二行FROM, 从COMPANY提取所有7条记录, 返回给第三行WHERE
6. 第三行WHERE, 逐条比较7条记录的SALARY字段的值, ID为1,2,3,4,6,7的记录满足条件, 返回给第一行SELECT
7. 第一行SELECT, 输出ID为1,2,3,4,6,7的记录的ID和AGE字段的值

例4:
SELECT ID, MIN(SALARY)
FROM COMPANY
WHERE AGE < 30;

1. 第二行FROM, 从COMPANY提取所有7条记录, 返回给第一行SELECT
2. 第三行WHERE, 逐条比较7条记录的AGE字段的值, ID为2~7的记录满足条件, 返回给第一行SELECT
2. 聚合函数MIN, 对7条数据做整体处理, 筛选出字段值最小的记录, 即ID为7的记录, 并新加上一列叫MIN(SALARY)的字段, 返回给SELECT
3. 第一行SELECT, 输出ID为7的记录的ID, MIN(SALARY)字段的值

例5:
SELECT AVG(SALARY)
FROM COMPANY;

1. 第二行FROM, 从COMPANY提取所有7条记录, 返回给第一行SELECT
2. 聚合函数AVG, 对7条数据做整体处理, 有别于MIN函数, AVG对是对字段值做平均而非筛选记录, 
    但因为语法要求聚合函数必须返回一条记录, 所以sqlite在这里返回了最后一条记录即ID为7的记录, 并新加入一列叫AVG(SALARY)的字段, 返回给SELECT,
    至于为什么返回ID为7的记录而非ID为1或者23456的记录, 要问sqlite开发者, 他总要返回一条记录的嘛, 我也是试过才知道的
3. 第一行SELECT, 输出ID为7的记录的AVG(SALARY)字段的值

题1:
SELECT NAME
FROM COMPANY 
WHERE LENGTH(ADDRESS) == 
(
    SELECT MIN(LENGTH(ADDRESS)) 
    FROM COMPANY
);