DECLARE @counter INT = 1;
WHILE(@counter < 5)
BEGIN
	print(@counter)
	set @counter = @counter + 1
END

Declare @Name varchar(50)
Declare @Department varchar(50)
DECLARE Cursor_Employees CURSOR
FOR
SELECT
	Name,
	Department
FROM Employees

OPEN Cursor_Employees;

FETCH NEXT FROM	Cursor_Employees INTO @Name, @Department;

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT(@Name + 'is in '+ @Department + ' Department')
	FETCH Prior FROM Cursor_Employees INTO @Name, @Department
END

CLOSE Cursor_Employees
DEALLOCATE Cursor_Employees