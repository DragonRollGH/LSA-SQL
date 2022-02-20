import sqlite3
conn = sqlite3.connect('test.db')
cur = conn.cursor()
sql_text_1 = '''CREATE TABLE scores
           (姓名 TEXT,
            班级 TEXT,
            性别 TEXT,
            语文 NUMBER,
            数学 NUMBER,
            英语 NUMBER);'''
# 执行sql语句sql
cur.execute(sql_text_1)
conn.commit()
#使用完数据库之后，需要关闭游标和连接：

# 关闭游标
cur.close()
# 关闭连接
conn.close()

print("hello")

import time
time.clock()
