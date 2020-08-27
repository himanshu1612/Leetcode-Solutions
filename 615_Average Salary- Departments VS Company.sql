-- https://leetcode.com/problems/average-salary-departments-vs-company/
-- Oracle

Select 
	Distinct to_char(s.pay_date, 'yyyy-mm') as pay_month, e.department_id ,
	(case when 
		avg(s.amount) over (partition by e.department_id, to_char(s.pay_date, 'yyyy-mm')) > 
		avg(s.amount) over (partition by to_char(s.pay_date, 'yyyy-mm')) then 'higher'
	when 
		avg(s.amount) over (partition by e.department_id, to_char(s.pay_date, 'yyyy-mm')) = 
		avg(s.amount) over (partition by to_char(s.pay_date, 'yyyy-mm')) then 'same'
	else 
		'lower'  end) as comparison 
From 
	salary s, employee e  
Where 
	s.employee_id = e.employee_id