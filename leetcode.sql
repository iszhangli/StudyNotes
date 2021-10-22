-- 1. 薪水第n高
-- 2. 连续出现的数字

-- 176.第二高的薪水 由于要返回null 所以需要虚表-----------------------------------------------
CREATE TABLE IF NOT EXISTS Employee (Id INT, Salary INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee (Id, Salary) VALUES ('1', '100');
INSERT INTO Employee (Id, Salary) VALUES ('2', '200');
INSERT INTO Employee (Id, Salary) VALUES ('3', '300');
-- row_number 
SELECT
  CASE
    WHEN t.Salary IS NULL
    THEN 'null'
    ELSE t.salary
  END AS SecondHighestSalary
FROM
  (SELECT
    Salary,
    row_number () over (
  ORDER BY Salary DESC) AS Rn
  FROM
    Employee) t
WHERE t.rn = 2;

-- limit 1,1 从第二个开始取数，取一位  且 ifnull判断单值 
SELECT IFNULL((SELECT Salary FROM Employee ORDER BY Salary DESC LIMIT 1,1), NULL) AS SecondHighestSalary;
SELECT (SELECT Salary FROM Employee ORDER BY Salary DESC LIMIT 1,1) AS SecondHighestSalary;

-- 177. 第N高的薪水 
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      SET N = N - 1
      SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT N, 1
  );
END

-- 185. 部门工资前三高的所有员工 
-- [不适用函数的写法。。。]
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
SELECT
  DISTINCT(T.NUM) AS CONSECUTIVEnUMS
FROM
  (SELECT
    ID,
    NUM,
    row_number () over (ORDER BY id) - ROW_NUMBER () OVER (PARTITION BY NUM ORDER BY ID) AS CC
  FROM
    LOGS) T
GROUP BY T.NUM,
  T.CC
HAVING COUNT(1) >= 3;

-- 184. 部门工资最高的员工
-- [最大用group by max]
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

SELECT
  T2.Name AS Department1,
  T1.Name AS Employee1,
  Salary
FROM
  Employee AS T1
  LEFT JOIN Department AS T2
    ON T1.DepartmentId = T2.Id
WHERE (T1.DepartmentId, T1.Salary) IN
  (SELECT
    DepartmentId,
    MAX(Salary)
  FROM
    Employee
  GROUP BY DepartmentId);
  
-- 262. 行程和用户

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




