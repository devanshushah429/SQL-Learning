CREATE FUNCTION dbo.GetEmployeesByDepartment (@deptName VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
  SELECT e.Emp_ID, e.FirstName, d.Department
  FROM EMP_Master e
  Inner Join Department d
  on e.DepartmentID = d.Department_ID
  WHERE Department = @deptName
)

Select * from GetEmployeesByDepartment ('Technical')

Create function dbo.CalculateAge(@birthdate datetime)
Returns int
as
BEGIN
	RETURN (Select DateDiff(Year , @birthdate, GetDate()))
END

Select dbo.CalculateAge('2003-04-29')

--Use udf in queries
Select Emp_ID, FirstName, dbo.CalculateAge(birthdate) AS age
FROM EMP_Master
Insert into Sales (ProductID, SaleDate, SaleAmount)
values(2,'2003-04-26',4),
(2,'2003-04-27',4),
(1,'2003-04-28',4),
(1,'2003-04-29',4),
(2,'2003-04-30',4)

Create function dbo.GetProductSales(@startDate datetime, @endDate datetime)
Returns Table
as

return 
	(
		Select
		ProductID, sum(SaleAmount) as sum_amount
		FROM Sales
		where SaleDate between @startDate AND @endDate
		group by PRODUCTID
	)
Select * from GetProductSales('2003-04-24', '2003-04-30')