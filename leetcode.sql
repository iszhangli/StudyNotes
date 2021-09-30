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