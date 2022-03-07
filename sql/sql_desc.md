175. 第n高的薪水
> hive： if(条件, 真值, 假值) 三目运算；
> mysql：ifnull(, 真值)
> mysql: limit 1, 1 从第二位开始取一位
sql
shift + alt + f
ddl
shift + alt + l

178. 分数排名
> row_number() over(): 排序列'rank': 1 2 3 4
> rank() over(): 排序列'rank': 1 2 2 4
> dense_rank() over(): 排序列'rank': 1 2 2 3
> ntile(n) over(): 排序列'rank': 1 1 1 2 2（先排序再分桶）

180. 连续出现的数字
> having是对 group by对象进行筛选

182. 查找重复的电子邮箱
> count(1) count(*) count(列名)
> 从执行结果看：count(1)和count(*)会计算值为null的行，count(列名)会忽略值为null的行。
> 从执行效率看: 有**多列且没有主键**，count(1)优于count(\*)，如果**查询列为主键**，count(列名)由于count(1)，否则不如count(1); 如果**只有一个字段**，count(\*)最有

184. 部门收入最高的员工
> where (name, salary) in (name, salary) 需要加上括号

196. 删除重复的电子邮箱 
> Delete from table where id = '2020';删除id=2020的行；

197. 上升的温度
> lag(col, offset, default_value) over();  向下移动
> lead() over();  向上移动
> join 后面用 on 代替 where 进行筛选
> datediff(date1, date2)=1 是 date1-date2=1

534. 游戏时长和
> on 后面不能接group by， 但是生成表后 where 后可以接 group by;
> 开窗函数 sum() over(partition by order by )



182 184 196 197
sql 规范
181 182 183（怪异） 184 185 196 197
511 512 534

