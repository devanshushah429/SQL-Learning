-- Fetch NEXT
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

-- Fetch PRIOR
Declare @Name varchar(50)
Declare @Department varchar(50)
DECLARE Cursor_Employees CURSOR Dynamic
FOR
SELECT Name, Department
FROM Employees
ORDER BY Name;

OPEN Cursor_Employees;

FETCH LAST FROM Cursor_Employees INTO @Name, @Department;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT(@Name + ' is in ' + @Department + ' Department');

    FETCH PRIOR FROM Cursor_Employees INTO @Name, @Department;
END

CLOSE Cursor_Employees;
DEALLOCATE Cursor_Employees;

--Fetch first and last
Declare @Name varchar(50)
Declare @Department varchar(50)
DECLARE Cursor_Employees CURSOR Dynamic
FOR
SELECT Name, Department
FROM Employees
ORDER BY Name;

OPEN Cursor_Employees;

FETCH FIRST FROM Cursor_Employees INTO @Name, @Department;

PRINT(@Name + ' is in ' + @Department + ' Department');

FETCH LAST FROM Cursor_Employees INTO @Name, @Department;

PRINT(@Name + ' is in ' + @Department + ' Department');

CLOSE Cursor_Employees;
DEALLOCATE Cursor_Employees;

--fetch absolute
DECLARE @Name VARCHAR(100), @Department VARCHAR(100);

DECLARE Cursor_Employees CURSOR Dynamic
FOR
SELECT Name, Department
FROM Employees
ORDER BY Name;

OPEN Cursor_Employees;

FETCH ABSOLUTE 5 FROM Cursor_Employees INTO @Name, @Department;

PRINT(@Name + ' is in ' + @Department + ' Department');

CLOSE Cursor_Employees;
DEALLOCATE Cursor_Employees;

--fetch Relative
DECLARE @Name VARCHAR(100), @Department VARCHAR(100);

DECLARE Cursor_Employees CURSOR Dynamic
FOR
SELECT Name, Department
FROM Employees
ORDER BY Name;

OPEN Cursor_Employees;
FETCH Relative 3 FROM Cursor_Employees INTO @Name, @Department;

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT(@Name + ' is in ' + @Department + ' Department')
	FETCH RELATIVE 3 FROM Cursor_Employees INTO @Name, @Department;

END
CLOSE Cursor_Employees;
DEALLOCATE Cursor_Employees;