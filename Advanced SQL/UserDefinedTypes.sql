CREATE TABLE EMP_MASTER(
	EmployeeID INT,
    EmployeeName NVARCHAR(100),
    DepartmentID INT
)

CREATE TYPE EmployeeTableType AS TABLE (
    EmployeeID INT,
    EmployeeName NVARCHAR(100),
    DepartmentID INT
);

CREATE PROCEDURE InsertEmployees
    @Employees EmployeeTableType READONLY
AS
BEGIN
    INSERT INTO EMP_Master (EmployeeID, EmployeeName, DepartmentID)
    SELECT EmployeeID, EmployeeName, DepartmentID
    FROM @Employees;
END;

DECLARE @Employees EmployeeTableType;

INSERT INTO @Employees (EmployeeID, EmployeeName, DepartmentID)
VALUES (1, 'ABC', 1),
       (2, 'DEF', 2);

Exec InsertEmployees @Employees