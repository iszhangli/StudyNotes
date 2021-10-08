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

