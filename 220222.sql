语法: 
SELECT column1, column2, columnN 
FROM table_name
WHERE [condition];

语义:
SELECT: 提取记录中column1, column2, columnN字段的值, 返回给下一个语句或直接输出
FROM: 从table_name中提取所有记录, 返回给下一个语句
WHERE: 对记录按[condition]的条件筛选, 返回给下一个语句
聚合函数: 用在SELECT后面的字段, 对记录做整体处理后, 返回给SELECT
普通函数: 用于任何字段或字段值, 对值做处理并返回, 其执行顺序依托于所在的语句
表达式: 可以理解为一种普通函数, 其执行顺序依托于所在的语句

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


例6:
SELECT (MAX(SALARY) - MIN(SALARY))
FROM COMPANY;

1. 第一行的括号内没有语句, 只有函数, 不构成优先执行的条件
2. 第二行FROM, 返回所有七条记录给第一行SELECT
3. 聚合函数MAX, 返回包含MAX(SALARY)的一条记录
4. 聚合函数MIN, 返回包含MIN(SALARY)的一条记录
5. 第一行SELECT, 先计算表达式, MAX(SALARY)即85000 减去 MIN(SALARY)即10000, 并输出


例7:
SELECT COUNT(*)
FROM COMPANY
WHERE ADDRESS == 'Texas';

1. 第二行FROM, 返回所有七条记录给第三行WHERE
2. 第三行WHERE, 返回ID为2,5的记录给第一行SELECT
3. 聚合函数COUNT, 返回一条有COUNT(*)字段的记录给SELECT
4. 第一行SELECT, 输出COUNT(*)字段, 即2


题1:
输出这个表里住址最短的人(们)的名字: 
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
SELECT NAME
FROM COMPANY 
WHERE LENGTH(ADDRESS) == 
(
    SELECT MIN(LENGTH(ADDRESS)) 
    FROM COMPANY
);


填空:
1. 先执行五六行括号内容, 第六行FROM, 返回所有七条记录给[  ]
2. 第五行SELECT, 嵌套函数从内往外执行, 先计算LENGTH函数, 得到七条记录的ADDRESS字段的长度
    然后聚合函数, 返回一条包含MIN(LENGTH(ADDRESS))字段的且ID为[  ]的记录
    然后SELECT返回新字段的值[  ]
3. 所以五六行整个括号等价于[  ]
4. 第二行FROM, 返回所有七条记录给[  ]
5. 第三行WHERE, 返回满足条件的ID为[  ]的记录
6. 第一行SELECT, 输出ID为[  ]的[  ]字段的值, 即[  ]


题2:
已知这个表里最后几条记录的人名重复了, 但不知道具体重复了几遍, 只有ID最小的那条是有效的, 请输出多余的重复记录
COMPANY:
ID          NAME        AGE         ADDRESS     SALARY
----------  ----------  ----------  ----------  ----------
1           Paul        32          California  20000.0
2           Allen       25          Texas       15000.0
3           Teddy       23          Norway      20000.0
4           Mark        25          Rich-Mond   65000.0
5           David       27          Texas       85000.0
6           Kim         22          South-Hall  45000.0
7           Kim         22          South-Hall  45000.0
8           Kim         22          South-Hall  45000.0
SELECT *
FROM COMPANY
WHERE ID != 
(
    SELECT MIN(ID)
    FROM COMPANY
    WHERE NAME == 
    (
        SELECT NAME
        FROM COMPANY
        WHERE ID == 
        (
            SELECT MAX(ID)
            FROM COMPANY;
        )
    )
)

填空:
1. 嵌套括号从内往外执行, 先执行13,14行括号内容, 第14行FROM, 返回所有八条记录给[  ]
2. 第13行聚合MAX, 返回带有新的[  ]字段的记录给[  ]
3. 第13行SELECT, 返回新的字段的值, 所以13,14行括号等价于[  ]
4. 再执行9-11行括号内容, 第10行FROM, 返回所有八条记录给[  ]
5. 第[  ]行[  ]语句, 返回满足条件的ID为[  ]的数据给[  ]
6. 第[  ]行[  ]语句, 输出[  ]字段的值, 所以9-15行括号等价于[  ]
7. 再执行5-7行括号内容, 第6行FROM返回所有八条记录给[  ]
8. 第[  ]行[  ]语句, 返回ID为[  ]的数据给[  ]
9. 聚合函数MIN, 返回带有新的[  ]字段的记录给[  ]
10. 第[  ]行[  ]语句, 返回新的字段的值, 所以5-16行括号等价于[  ]
11. 第[  ]行[  ]语句, 返回所有八条记录给[  ]
12. 第[  ]行[  ]语句, 返回满足条件的ID为[  ]的记录给[  ]
13. 第一行SELECT, 输出ID为[  ]的所有字段的值


题3:
参考题2, 用法DELETE语句删除多余的重复记录
DELETE FROM table_name
WHERE [condition];

