-- ## 02-21
-- SQL表达式
-- count()
-- min()
-- max()
-- avg()
-- length()
-- UPDATE

.print "\n1. ================================="
-- Allen搬去和Paul一起住了，更新Allen的地址，输出更改后的表
-- 语句中不能出现具体地址
UPDATE COMPANY SET ADDRESS = ( SELECT ADDRESS FROM COMPANY WHERE NAME == "Paul" )
WHERE NAME == "Allen" ;
.header on
.mode column
select * from COMPANY;

.print "\n2. ================================="
-- 输出最高工资与最低工资的差值
-- 语句中不能出现具体工资
.header off
-- SELECT (max(SALARY) - min(SALARY))FROM COMPANY AS SUBTRACTION;   
-- 不需要对计算出来的数据（最高工资与最低工资的差值）备注就不需要加AS
SELECT (max(SALARY) - min(SALARY))FROM COMPANY;


.print "\n3. ================================="
-- 输出30岁以下的人的平均工资
--SELECT AVG(SALARY) AS "AVERAGE SALARY" FROM COMPANY;  
-- 用WHERE筛选年龄小于30岁的人，再用AVG计算平均值
SELECT AVG(SALARY) FROM COMPANY WHERE AGE < 30;



.print "\n4. ================================="
-- 输出住址字数最短的人的姓名
-- SELECT NAME WHERE MIN(LEN(ADDRESS)) FROM COMPANY;    
-- 题目应该改为“输出住址字数最短的人的姓名及其住址字数”，否则太难
-- WHERE必须在FROM后面，SELECT、FROM、WHERE顺序不可变
-- 聚合函数只能用在SELECT和FROM之间，不能用在WHERE后面
SELECT NAME, MIN(LENGTH(ADDRESS)) FROM COMPANY;
-- 如果不改题目:
SELECT NAME FROM COMPANY 
WHERE LENGTH(ADDRESS) == (SELECT MIN(LENGTH(ADDRESS)) FROM COMPANY);


.print "\n5. ================================="
-- 输出姓名为Kim的记录总共有几行
-- SELECT COUNT(NAME == 'Kim') FROM COMPANY;            
-- 应该用WHERE筛选名字等于Kim的记录
SELECT COUNT(*) FROM COMPANY WHERE NAME == 'Kim';


.print "\n6. ================================="
-- 输出姓名为Kim的记录中最小的ID号
-- SELECT MIN(ID) WHERE NAME == 'Kim' FROM COMPANY;     
-- WHERE必须在FROM后面，SELECT、FROM、WHERE顺序不可变
SELECT MIN(ID) FROM COMPANY WHERE NAME == 'Kim' ;
