-- 176 
SELECT  secondhighestsalary
FROM
(
	SELECT  row_number() over(PARTITION BY id ORDER BY salary DESC) AS rn
	FROM employee
) t
WHERE rn = 2