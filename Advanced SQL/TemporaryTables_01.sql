SELECT * FROM Employees 
where Name='John'

Select * from Employees

Select dbo.CalculateAge('2003-04-29') as age

Insert into Employees values(8,'Devanshu', 'Technical','200000')

--Local temporary table
CREATE TABLE #temp_table (
    id INT,
    name VARCHAR(50)
);

INSERT INTO #temp_table (id, name) VALUES (1, 'John'), (2, 'Jane');

SELECT * FROM #temp_table;

--Global temporary table

CREATE TABLE ##temp_table (
    id INT,
    name VARCHAR(50)
);

INSERT INTO ##temp_table (id, name) VALUES (1, 'John'), (2, 'Jane');

SELECT * FROM ##temp_table;

SELECT * FROM ##temp_table; 


-- variable table
DECLARE @temp_table TABLE (
    id INT,
    name VARCHAR(50)
);

INSERT INTO @temp_table (id, name) VALUES (1, 'John'), (2, 'Jane');

SELECT * FROM @temp_table;



SELECT * FROM @temp_table;
