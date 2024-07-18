-- Row_Number

-- only order by
Select 
	EmployeeID,
	[Name],
	Department,
	Salary,
	ROW_NUMBER() over (ORDER by Salary asc) as row_number
from Employees

--using partition by also
Select 
	EmployeeID,
	[Name],
	Department,
	Salary,
	ROW_NUMBER() over (Partition By Department ORDER by Salary asc) as row_number
from Employees
order by EmployeeID

-- offset
-- Is compulsary to use order by in offset
Select *
from Employees
ORDER BY Salary Desc
offset 1 rows
fetch next 2 rows only