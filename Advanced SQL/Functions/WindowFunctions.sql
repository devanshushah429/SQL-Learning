Create Database Learning
use Learning

Select
	Emp_ID
	, Salary
	,Dept_id
	,Sum(Salary) over (Partition by Dept_id order by emp_id) as sum_sal
	,Avg(Salary) over (Partition by Dept_id order by emp_id) as avg_sal
FROM Employee

Select
	Emp_ID
	, Salary
	,Dept_id
	,Sum(Salary) over (Partition by Dept_id) as sum_sal
	,Avg(Salary) over (Partition by Dept_id) as avg_sal
FROM Employee