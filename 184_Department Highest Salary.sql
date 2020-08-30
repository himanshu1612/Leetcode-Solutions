-- https://leetcode.com/problems/department-highest-salary/
-- Oracle

Select d.name as department, e.name as employee, e.salary 
from department d,  
	(Select departmentID, name, salary, 
		dense_rank() over (partition by departmentID order by salary desc) as rank 
	from Employee) e 
where d.id = e.departmentid and e.rank = 1