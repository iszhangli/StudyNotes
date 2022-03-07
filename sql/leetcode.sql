-- 1. 薪水第n高
-- 2. 连续出现的数字

-- 176.第二高的薪水 由于要返回null 所以需要虚表-----------------------------------------------
CREATE TABLE IF NOT EXISTS Employee (Id INT, Salary INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee (Id, Salary) VALUES ('1', '100');
INSERT INTO Employee (Id, Salary) VALUES ('2', '200');
INSERT INTO Employee (Id, Salary) VALUES ('3', '200');
-- row_number 

-- limit 1,1 从第二个开始取数，取一位  且 ifnull判断单值 
SELECT  IFNULL((
SELECT  DISTINCT Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 1, 1), NULL) AS SecondHighestSalary;

-- 177. 第N高的薪水 
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      SET N = N - 1
      SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT N, 1
  );
END


-- 178.
DROP TABLE IF EXISTS Scores;
CREATE TABLE IF NOT EXISTS Scores (id INT, score DECIMAL(3,2));
TRUNCATE TABLE Scores;
INSERT INTO Scores (id, score) VALUES ('1', '3.5');
INSERT INTO Scores (id, score) VALUES ('2', '3.65');
INSERT INTO Scores (id, score) VALUES ('3', '4.0');
INSERT INTO Scores (id, score) VALUES ('4', '3.85');
INSERT INTO Scores (id, score) VALUES ('5', '4.0');
INSERT INTO Scores (id, score) VALUES ('6', '3.65');
# 测试 row_number() over rank() dense_rank() 
SELECT id, score, row_number() over(ORDER BY score) AS 'rank' FROM Scores ORDER BY id;
SELECT
  id,
  score,
  ntile (2) over (ORDER BY score) AS 'rank'
FROM
  Scores;

-- 185. 部门工资前三高的所有员工 
DROP TABLE IF EXISTS Employee;
CREATE TABLE IF NOT EXISTS Employee (Id INT, NAME VARCHAR(255), Salary INT, DepartmentId INT);
CREATE TABLE IF NOT EXISTS Department (Id INT, NAME VARCHAR(255));
TRUNCATE TABLE Employee;
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('1', 'Joe', '85000', '1');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('2', 'Henry', '80000', '2');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('3', 'Sam', '60000', '2');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('4', 'Max', '90000', '1');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('5', 'Janet', '69000', '1');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('6', 'Randy', '85000', '1');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('7', 'Will', '70000', '1');
TRUNCATE TABLE Department;
INSERT INTO Department (Id, NAME) VALUES ('1', 'IT');
INSERT INTO Department (Id, NAME) VALUES ('2', 'Sales');
SELECT
  t.Name AS Department,
  t.employee AS Employee,
  t.salary AS Salary
FROM
  (SELECT
    t2.name,
    T1.name AS employee,
    t1.salary,
    ROW_NUMBER () OVER (    -- 将 row_number 替换为 dense_rank() 就ok了
      PARTITION BY T2.NAME
  ORDER BY T1.SALARY DESC
  ) AS RN
  FROM
    Employee T1
    LEFT JOIN DEPARTMENT T2
      ON T1.DEPARTMENTID = T2.ID) t
WHERE t.rn < 4;

-- 180. 连续出现的数字
-- [row_number() order by id / partition by num order by id 相减数值相同]
DROP TABLE IF EXISTS LOGS;
CREATE TABLE IF NOT EXISTS LOGS (Id INT, Num INT);
TRUNCATE TABLE LOGS;
INSERT INTO LOGS (Id, Num) VALUES ('1', '1');
INSERT INTO LOGS (Id, Num) VALUES ('2', '1');
INSERT INTO LOGS (Id, Num) VALUES ('3', '1');
INSERT INTO LOGS (Id, Num) VALUES ('4', '2');
INSERT INTO LOGS (Id, Num) VALUES ('5', '1');
INSERT INTO LOGS (Id, Num) VALUES ('6', '2');
INSERT INTO LOGS (Id, Num) VALUES ('7', '2');
INSERT INTO LOGS (Id, Num) VALUES ('8', '1');
INSERT INTO LOGS (Id, Num) VALUES ('9', '1');
INSERT INTO LOGS (Id, Num) VALUES ('10', '1');

SELECT * FROM LOGS;

SELECT  DISTINCT(T.NUM) AS CONSECUTIVEnUMS
FROM
(
	SELECT  ID
	       ,NUM
	       ,row_number () over (ORDER BY id) - ROW_NUMBER () OVER (PARTITION BY NUM ORDER BY ID) AS CC
	FROM LOGS
) T
GROUP BY  T.NUM
         ,T.CC
HAVING COUNT(1) >= 3;




-- 184. 编写SQL查询以查找每个部门中薪资最高的员工
/*输出：
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
*/
DROP TABLE IF EXISTS Employee;
CREATE TABLE IF NOT EXISTS Employee (Id INT, NAME VARCHAR(255), Salary INT, DepartmentId INT);
DROP TABLE IF EXISTS Department;
CREATE TABLE IF NOT EXISTS Department (Id INT, NAME VARCHAR(255));
TRUNCATE TABLE Employee;
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('1', 'Joe', '70000', '1');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('2', 'Jim', '90000', '1');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('3', 'Henry', '80000', '2');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('4', 'Sam', '60000', '2');
INSERT INTO Employee (Id, NAME, Salary, DepartmentId) VALUES ('5', 'Max', '90000', '1');
TRUNCATE TABLE Department;
INSERT INTO Department (Id, NAME) VALUES ('1', 'IT');
INSERT INTO Department (Id, NAME) VALUES ('2', 'Sales');

SELECT  T2.Name AS Department1
       ,T1.Name AS Employee1
       ,Salary
FROM Employee AS T1
LEFT JOIN Department AS T2
ON T1.DepartmentId = T2.Id
WHERE (T1.DepartmentId, T1.Salary) IN ( SELECT DepartmentId, MAX(Salary) FROM Employee GROUP BY DepartmentId); 

-- 185. 部门工资前三高的所有员工
/*
输出: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
*/
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department; 
CREATE TABLE IF NOT EXISTS Employee (id INT, NAME VARCHAR(255), salary INT, departmentId INT);
CREATE TABLE IF NOT EXISTS Department (id INT, NAME VARCHAR(255));
TRUNCATE TABLE Employee;
INSERT INTO Employee (id, NAME, salary, departmentId) VALUES ('1', 'Joe', '85000', '1');
INSERT INTO Employee (id, NAME, salary, departmentId) VALUES ('2', 'Henry', '80000', '2');
INSERT INTO Employee (id, NAME, salary, departmentId) VALUES ('3', 'Sam', '60000', '2');
INSERT INTO Employee (id, NAME, salary, departmentId) VALUES ('4', 'Max', '90000', '1');
INSERT INTO Employee (id, NAME, salary, departmentId) VALUES ('5', 'Janet', '69000', '1');
INSERT INTO Employee (id, NAME, salary, departmentId) VALUES ('6', 'Randy', '85000', '1');
INSERT INTO Employee (id, NAME, salary, departmentId) VALUES ('7', 'Will', '70000', '1');
TRUNCATE TABLE Department;
INSERT INTO Department (id, NAME) VALUES ('1', 'IT');
INSERT INTO Department (id, NAME) VALUES ('2', 'Sales');
-- code
SELECT t2.name AS Department, t1.name AS Employee, t1.Salary FROM 
(SELECT id, NAME, salary, departmentId, dense_rank() over(PARTITION BY departmentId ORDER BY salary DESC) AS 'rank' FROM Employee) t1 
LEFT JOIN Department t2 ON t1.departmentId  = t2.id WHERE t1.rank <= 3;


-- 196. 删除重复的电子邮箱
/*
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
*/
DROP TABLE IF EXISTS Person;
CREATE TABLE IF NOT EXISTS Person (Id INT, Email VARCHAR(255));
TRUNCATE TABLE Person;
INSERT INTO Person (id, email) VALUES ('1', 'john@example.com');
INSERT INTO Person (id, email) VALUES ('2', 'bob@example.com');
INSERT INTO Person (id, email) VALUES ('3', 'john@example.com');
-- code
SELECT  MIN(id) AS id, email  FROM Person GROUP BY email;  -- 会得到结果，不过需要删除
DELETE FROM person WHERE id NOT IN (SELECT MIN(id) AS id  FROM Person GROUP BY email); -- 会报错，原因需要中间表
DELETE FROM person WHERE id NOT IN (SELECT id FROM (SELECT MIN(id) AS id  FROM Person GROUP BY email) t)

-- 197. 上升的温度
/*
输出：
+----+
| id |
+----+
| 2  |
| 4  |
+----+
*/
DROP TABLE IF EXISTS Weather;
CREATE TABLE IF NOT EXISTS Weather (id INT, recordDate DATE, temperature INT);
TRUNCATE TABLE Weather;
INSERT INTO Weather (id, recordDate, temperature) VALUES ('1', '2015-01-02', '10');
INSERT INTO Weather (id, recordDate, temperature) VALUES ('2', '2015-01-01', '25');
INSERT INTO Weather (id, recordDate, temperature) VALUES ('3', '2015-01-04', '20');
INSERT INTO Weather (id, recordDate, temperature) VALUES ('4', '2015-01-05', '30');
INSERT INTO Weather (id, recordDate, temperature) VALUES ('4', '2015-01-06', '30');
-- code
SELECT id, temperature, lead(temperature) over(ORDER BY recordDate) AS rn  FROM weather
SELECT id FROM (SELECT id, temperature-lead(temperature) over(ORDER BY recordDate) AS rn  FROM weather) t WHERE t.rn > 0; -- 不能满足相差为一天
SELECT t1.id FROM weather t1 JOIN weather t2 ON DATEDIFF(t1.recordDate, t2.recordDate) = 1 AND t1.temperature > t2.temperature;

-- 262. 行程和用户
/*
+------------+-------------------+
| Day        | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 | 0.33              |
| 2013-10-02 | 0.00              |
| 2013-10-03 | 0.50              |
+------------+-------------------+
*/
DROP TABLE IF EXISTS Trips;
DROP TABLE IF EXISTS Users;
CREATE TABLE IF NOT EXISTS Trips (Id INT, Client_Id INT, Driver_Id INT, City_Id INT, STATUS ENUM('completed', 'cancelled_by_driver', 'cancelled_by_client'), Request_at VARCHAR(50));
CREATE TABLE IF NOT EXISTS Users (Users_Id INT, Banned VARCHAR(50), Role ENUM('client', 'driver', 'partner'));
TRUNCATE TABLE Trips;
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('1', '1', '10', '1', 'completed', '2013-10-01');
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('3', '3', '12', '6', 'completed', '2013-10-01');
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('5', '1', '10', '1', 'completed', '2013-10-02');
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('6', '2', '11', '6', 'completed', '2013-10-02');
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('7', '3', '12', '6', 'completed', '2013-10-02');
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('8', '2', '12', '12', 'completed', '2013-10-03');
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('9', '3', '10', '12', 'completed', '2013-10-03');
INSERT INTO Trips (Id, Client_Id, Driver_Id, City_Id, STATUS, Request_at) VALUES ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');
TRUNCATE TABLE Users;
INSERT INTO Users (Users_Id, Banned, Role) VALUES ('1', 'No', 'client');
INSERT INTO Users (Users_Id, Banned, Role) VALUES ('2', 'Yes', 'client');
INSERT INTO Users (Users_Id, Banned, Role) VALUES ('3', 'No', 'client');
INSERT INTO Users (Users_Id, Banned, Role) VALUES ('4', 'No', 'client');
INSERT INTO Users (Users_Id, Banned, Role) VALUES ('10', 'No', 'driver');
INSERT INTO Users (Users_Id, Banned, Role) VALUES ('11', 'No', 'driver');
INSERT INTO Users (Users_Id, Banned, Role) VALUES ('12', 'No', 'driver');
INSERT INTO Users (Users_Id, Banned, Role) VALUES ('13', 'No', 'driver');


-- 534. 游戏时长和
/*
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 1         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result table:
+-----------+------------+---------------------+
| player_id | event_date | games_played_so_far |
+-----------+------------+---------------------+
| 1         | 2016-03-01 | 5                   |
| 1         | 2016-05-02 | 11                  |
| 1         | 2017-06-25 | 12                  |
| 3         | 2016-03-02 | 0                   |
| 3         | 2018-07-03 | 5                   |
+-----------+------------+---------------------+
*/
DROP TABLE IF EXISTS Activity; 
CREATE TABLE IF NOT EXISTS Activity (player_id INT, device_id INT, event_date DATE, games_played INT);
TRUNCATE TABLE Activity;
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('1', '2', '2016-03-01', '5');
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('1', '2', '2016-05-02', '6');
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('1', '3', '2017-06-25', '1');
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('3', '1', '2016-03-02', '0');
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('3', '4', '2018-07-03', '5');
-- code
SELECT  t2.player_id, t2.event_date, SUM(t1.games_played) FROM Activity t1,  Activity t2 WHERE t1.player_id=t2.player_id AND t1.event_date <= t2.event_date 
GROUP BY t2.player_id, t2.event_date  -- 使用join + group by
SELECT player_id, event_date, SUM(games_played) over(PARTITION BY player_id ORDER BY event_date) AS rt FROM Activity
SELECT * FROM  Activity t1 JOIN Activity t2 WHERE t1.player_id=t2.player_id AND t1.event_date <= t2.event_date



