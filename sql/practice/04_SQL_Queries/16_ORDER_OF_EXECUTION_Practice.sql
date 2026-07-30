/*
=========================================
ORDER OF EXECUTION Practice
=========================================
*/

-- 1. Explain why this query fails:

SELECT
    salary * 12 AS annual_salary
FROM hr.employees
WHERE annual_salary > 700000;

--------------------------------------------------

-- 2. Fix the above query.

--------------------------------------------------

-- 3. Explain why this query fails:

SELECT
    department_id,
    AVG(salary)
FROM hr.employees
WHERE AVG(salary) > 60000
GROUP BY department_id;

--------------------------------------------------

-- 4. Rewrite the query using HAVING.

--------------------------------------------------

-- 5. For the following query,
-- write the logical execution order.

SELECT
    department_id,
    COUNT(*) AS total_employees
FROM hr.employees
WHERE salary > 50000
GROUP BY department_id
HAVING COUNT(*) > 5
ORDER BY total_employees DESC
LIMIT 3;
