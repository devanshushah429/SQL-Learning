-- Delete duplicate records
Delete p1 from person p1, person p2
where p1.email = p2.email and p1.id > p2.id

-- OR 
With cte as
(
    Select
        ID,
        Row_Number() over(partition by email order by id) as duplicate_id
    from Person
)
DELETE FROM Person
WHERE id 
IN (
    SELECT id
    FROM cte
    WHERE duplicate_id > 1
);

-- Second highest Salary
WITH SecondHighest AS (
    SELECT salary
    FROM Employee
    GROUP BY salary
    ORDER BY salary DESC
    OFFSET 1 ROWS
    FETCH NEXT 1 ROWS ONLY
)
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN NULL
        ELSE (SELECT salary FROM SecondHighest)
    END AS SecondHighestSalary
FROM SecondHighest

-- Group Sold Products By The Date
WITH CTE AS
(
    SELECT sell_date, product
    FROM Activities
    GROUP BY sell_date, product
)
SELECT 
    sell_date,
    count(product) AS num_sold,
    STRING_AGG(product, ',') WITHIN GROUP(ORDER BY product) AS products
FROM CTE

GROUP BY sell_date

-- List the Products Ordered in a Period
With CTE AS    
(
    Select 
        product_id,
        sum(unit) as unit
    FROM 
        Orders
    WHERE 
        order_date BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY 
        product_id
    HAVING 
        SUM(unit) >= 100
)

SELECT 
    p.product_name 
    ,cte.unit
FROM Products p 
inner join CTE
on CTE.product_id = p.product_id



--Find valid emails
SELECT user_id, name, mail FROM Users
WHERE mail LIKE '[a-zA-Z]%@leetcode.com' AND LEFT(mail, LEN(mail) - 13) NOT LIKE '%[^0-9a-zA-Z_.-]%'