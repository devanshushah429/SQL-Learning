SELECT LEN('Hello, World!') AS StringLength;

SELECT SUBSTRING('Hello, World!', 8, 5) AS SubstringExample;

SELECT CHARINDEX('World', 'Hello, World!') AS Position;

SELECT REPLACE('Hello, World!', 'World', 'SQL Server') AS ReplacedString;

SELECT 
    LTRIM('    Hello, World!    ') AS LTrimExample,
    RTRIM('    Hello, World!    ') AS RTrimExample;

SELECT TRIM('    Hello, World!    ') AS TrimExample;

SELECT 
    UPPER('Hello, World!') AS UpperCase,
    LOWER('Hello, World!') AS LowerCase;

SELECT CONCAT('Hello', ', ', 'World', '!') AS ConcatenatedString;

SELECT 
    LEFT('Hello, World!', 5) AS LeftExample,--pelle thi 5 letter aapse
    RIGHT('Hello, World!', 6) AS RightExample; --chelle thi 6 letter aapse

SELECT STUFF('Hello, World!', 8, 5, 'SQL Server') AS StuffExample;

SELECT FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss') AS FormattedDate;

SELECT REVERSE('Hello, World!') AS ReversedString;

SELECT STR(123.456,10,2) AS ConvertedString;
Good Evening Sir,Today my work review is there or not?