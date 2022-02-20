.print "\n1. ================================="
-- 找出工资大于_30000_并且年龄小于_26_岁的所有人的人名（只要人名）
SELECT NAME FROM COMPANY WHERE SALARY > 30000 AND AGE < 26;

.print "\n2. ================================="
-- 找出年龄比（工资等于_85000_的人)的年龄还大的所有人的地址（显示表头）
.header on
SELECT ADDRESS FROM COMPANY 
WHERE AGE > (SELECT AGE FROM COMPANY WHERE SALARY =85000);

.print "\n3. ================================="
-- 再插入两条_DATE_
-- INSERT INTO DATE(DATE,STARTING_TIME,ENDING_TIME,ADDRESS,REMARKS) 
-- VALUES("2018-10-04", "19:00", "22:00", "欢海","方圆一品");
-- INSERT INTO DATE(DATE,STARTING_TIME,ENDING_TIME,ADDRESS,REMARKS) 
-- VALUES("2019-02-22", "16:00", "21:00", "海岸城","阿丽塔&陶陶居");

.print "\n4. ================================="
-- 找出我们去_"联广"_吃_"麦当劳"_的日期（不显示表头）
.header off
SELECT DATE FROM DATE WHERE ADDRESS = "联广" and REMARKS = "麦当劳";

.print "\n5. ================================="
-- 删掉所有重复的数据，并再插入一遍有效数据，并输出整个表（显示表头、对齐列）
-- DELETE FROM DATE WHERE ADDRESS == "欢海" OR ADDRESS == "海岸城";
-- INSERT INTO DATE(DATE,STARTING_TIME,ENDING_TIME,ADDRESS,REMARKS)
-- VALUES("2018-10-04", "19:00", "22:00", "欢海","方圆一品");
-- INSERT INTO DATE(DATE,STARTING_TIME,ENDING_TIME,ADDRESS,REMARKS)
-- VALUES("2019-02-22", "16:00", "21:00", "海岸城","阿丽塔&陶陶居");
.header on
.mode column

.print "\n逗号空格: 10, 10, 10, 10, 10 （有效）"
.width 10, 10, 10, 10, 10
SELECT * FROM DATE;

.print "\n逗号: 10,5,5,20,20 （无效，维持上面的设置）"
.width 10,5,5,20,20
SELECT * FROM DATE;

.print "\n空格: 5 5 5 20 20 （有效）"
.width 5 5 5 20 20
SELECT * FROM DATE;

.print "\n设为0则自动选择列宽，但由于对汉语宽度计算有误导致显示不全:"
.width 0 0 0 0 0
SELECT * FROM DATE;
