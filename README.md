# LSA-SQL

记录LSA学习SQL的心路历程

## 02-19 
- [x] sqlite3
- [x] .help
- [x] .exit
- [x] CREATE TABLE
- [x] DROP TABLE
- [x] INSERT INTO

## 02-20
- [x] .read
- [x] .header
- [x] .mode
- [x] .width
- [x] .print
- [x] SELECT
- [x] SQL运算符
- [x] WHERE
- [x] 子句
- [x] DELETE

## 02-21
- [x] SQL表达式
- [x] count()
- [x] min()
- [x] max()
- [x] avg()
- [x] length()
- [x] UPDATE

## 02-22
- [x] SELECT..FROM..WHERE语法


CREATE TABLE COMPANY_3(
   ID             INT PRIMARY KEY NOT NULL,
   MONEY          INT,
   NAME           TEXT NOT NULL
);

INSERT INTO COMPANY_3(ID, NAME)
SELECT ID, NAME
FROM COMPANY
WHERE ADDRESS != 'Texas';

INSERT INTO COMPANY_3
SELECT ID, SALARY, NAME
FROM COMPANY
WHERE ADDRESS == 'Texas';
