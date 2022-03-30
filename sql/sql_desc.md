175. 第n高的薪水
> 1. hive： if(条件, 真值, 假值) 三目运算；
> 2. mysql：ifnull(, 真值)
> 3. mysql: limit 1, 1 从第二位开始取一位

178. 分数排名
> 1. row_number() over(): 排序列'rank': 1 2 3 4
> 2. rank() over(): 排序列'rank': 1 2 2 4
> 3. dense_rank() over(): 排序列'rank': 1 2 2 3
> 4. ntile(n) over(): 排序列'rank': 1 1 1 2 2（先排序再分桶）

180. 连续出现的数字
> having是对 group by对象进行筛选

182. 查找重复的电子邮箱
> 1. count(1) count(*) count(列名)
> 2. 从执行结果看：count(1)和count(*)会计算值为null的行，count(列名)会忽略值为null的行。
> 3. 从执行效率看: 有**多列且没有主键**，count(1)优于count(*)；如果**查询列为主键**，count(列名)优于count(1)；否则不如count(1); 如果**只有一个字段**，count(*)最优

184. 部门收入最高的员工
> 1. where (name, salary) in (name, salary) 需要加上括号

196. 删除重复的电子邮箱 
> 1. Delete from table where id = '2020';删除id=2020的行；

197. 上升的温度
> 1. lag(col, offset, default_value) over();  向下移动
> 1. lead() over();  向上移动
> 2. join 后面用 on 代替 where 进行筛选
> 4. datediff(date1, date2)=1 是 date1-date2=1

534. 游戏时长和
> 1. 开窗函数 sum() over(partition by order by )

550. 同一个用户次日登录
> 1. 输出字段名写错

569. 员工薪水中位数
> 1. round(, ) 四舍五入； ceiling() 向上取整；floor() 向下取整
> 2. 6/2 = 3 取3和4

571. 

574. 当选者
> 1. order by 后面可以接聚合函数，对group by后进行聚合操作
> 2. select 后 只能选择 group by的字段

578. 查询回答率最高的问题
> 1. 写法上的优化，sum()中不需要用 case when
> 2. group by 后面直接接 order by 类似 574

579. 查询员工的累计工资
> 1. 聚合函数是把窗口关闭，给一个汇总的结果，窗口函数是把窗口打开，给分组内每行记录就去对应的结果。
> 2. frame子句: 两个单元：`[rows][range]`
> * row 对于行来说，假设当前行为10，`rows 5 preceding`表示行10-5=5， 从前第5行计算到当前行。
> * range对于值来说，假设10行值11，`range 5 preceding`表示值11-5=6，向前找值为6的行开始计算到当前行。 
> * 有`frame_start` 和 `frame_between`两种形式
> * frame_start, frame_end:
> * current row : 当前行
> * unbounded preceding : (前)永远从第一行开始计算
> * unbounded following : (后)永远计算到最后一行
> * expr preceding  expr following : 从 cur+expr 行开始， 到 cur-expr 行结束

580. 统计各专业学生人数
> 1. join 完后 加 group by 没有问题，再接个 ordr by 都可以

602. 好友申请 II ：谁有最多的好友
> 1. union 根据**字段顺序**进行合并，而不是字段名称

612. 平面上的最近距离
> power(x, n) n次冥
> where (t1.x, t1,y) <> (t2.x, t2.y) 两个变量不等
> abs(x1-x2)

1098. 小众书籍
> 1. 对于join的考察，再难一点是on和where的位置

1097. 游戏玩法分析
> 1. min() over() 显示的是日期

1112. 每位学生的最高成绩
> row_number() over(partition by student_id order by grade desc, course_id asc) 双排序

1126. 查询活跃业务
> 1. sum 和 count 的区别

1098[no]  1045  1097[no]
1126[no]  1127[no]
1158  1159[no]


