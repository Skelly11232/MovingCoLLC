SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.role,
    SUM(je.hours_worked) AS total_hours_worked
FROM Employee e
JOIN Job_Employee je ON e.employee_id = je.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.role
ORDER BY total_hours_worked DESC
LIMIT 5;