-- количество сотрудников в каждом департаменте
SELECT department, COUNT(*) AS count
FROM employees
GROUP BY department;