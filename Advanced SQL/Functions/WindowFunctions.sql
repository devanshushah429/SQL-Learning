Create Database Learning
use Learning

Select
	Emp_ID
	,Salary
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

SELECT * FROM Employee
Select
	Emp_ID
	,Salary
	,Dept_id
	,RANK() OVER (PARTITION BY DEPT_ID ORDER BY SALARY) as 'RANK'
FROM Employee

Select
	Emp_ID
	,Salary
	,Dept_id
	,ROW_NUMBER() OVER (PARTITION BY DEPT_ID ORDER BY SALARY) as 'ROW_NUMBER'
FROM Employee

Select
	Emp_ID
	,Salary
	,Dept_id
	,DENSE_RANK() OVER (PARTITION BY DEPT_ID ORDER BY SALARY) as 'DENSE_RANK'
FROM Employee

Select
	Emp_ID
	,Salary
	,Dept_id
	,NTILE(3) OVER (PARTITION BY DEPT_ID ORDER BY SALARY) as 'NTILE'
FROM Employee