-- Exchange Seats
Select 
    (Case
        WHEN ID = (Select Max(id) from Seat) and id % 2 = 1
            THEN ID
        WHEN ID % 2 = 1
            THEN ID + 1
        WHEN ID % 2 = 0
            THEN ID - 1
    END) as id,
    student
from Seat
order by id

-- Movie Rating
WITH cte1 AS (
    SELECT 
        COUNT(rating) AS rank_rating,
        user_id
    FROM MovieRating
    GROUP BY user_id
),
cte2 AS (
    SELECT 
        AVG(rating*1.0) AS rank_rating,
        movie_id
    FROM MovieRating
    where Created_at between '2020-02-01' and '2020-02-29'
    GROUP BY movie_id
)

SELECT results
FROM (
    SELECT TOP 1
        u.name AS results,
        cte1.rank_rating
    FROM cte1
    LEFT JOIN Users u ON cte1.user_id = u.user_id
    ORDER BY cte1.rank_rating desc, u.name ASC
) AS q1

UNION ALL

SELECT results
FROM (
    SELECT TOP 1
        m.title AS results,
        cte2.rank_rating
    FROM cte2
    LEFT JOIN Movies m ON cte2.movie_id = m.movie_id
    ORDER BY cte2.rank_rating desc, m.title ASC
) AS q2

--	Restaurant Growth
With cte as(
    Select visited_on, Sum(Amount) as total_amount
    from Customer
    group by visited_on
)
,cte2 as
(  
    Select 
        visited_on, 
        SUM(total_amount) over(order by visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as sum_amount,
        Round(AVG(total_amount * 1.0) over(order by visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) as avg_amount
    from cte
)

Select 
    distinct cte2.visited_on,
    cte2.sum_amount as amount,
    cte2.avg_amount as average_amount
from cte2 
inner join customer
on DateAdd(Day, 6, customer.visited_on) = cte2.visited_on 
order by cte2.visited_on

-- Friend Requests II: Who Has the Most Friends
With cte1 as
(
    Select 
        requester_id,
        count(requester_id) as request_accepted1
    from RequestAccepted 
    group by requester_id
),
cte2 as
(
    Select 
        accepter_id,
        count(accepter_id) as request_accepted2
    from RequestAccepted 
    group by accepter_id
)

Select Top 1
Coalesce(cte1.requester_id, cte2.accepter_id) as id,
(Coalesce(cte1.request_accepted1, 0) + Coalesce(cte2.request_accepted2, 0)) as num
from cte1
full outer join cte2
on cte1.requester_id = cte2.accepter_id
order by num desc

--  Patients With a Condition
SELECT
    patient_id
    ,patient_name
    ,conditions
FROM Patients
WHERE
    conditions LIKE 'DIAB1%'
    or conditions LIKE '% DIAB1%'

-- Investments in 2016
WITH CTE1 AS (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
),
CTE2 AS (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
)
SELECT ROUND(SUM(i.tiv_2016), 2) AS tiv_2016
FROM Insurance i
INNER JOIN CTE1 s ON i.tiv_2015 = s.tiv_2015
INNER JOIN CTE2 u ON i.lat = u.lat AND i.lon = u.lon;

-- Department Top Three Salaries
With CTE1 AS(
    SELECT
        departmentId, Salary
    FROM Employee
    GROUP BY departmentId, salary
)
,CTE2 AS 
(
    Select 
        departmentId, 
        Salary, 
        Row_Number() OVER(Partition By departmentId order by Salary desc) as rn
    from CTE1
)

Select
    d.name as Department,
    e.name as Employee,
    e.Salary

from Employee e

INNER JOIN CTE2
on  e.departmentId = CTE2.departmentId
and e.salary = CTE2.salary

INNER JOIN department d
on d.id = CTE2.departmentId

where CTE2.rn <= 3

-- Fix Names in a Table
Select 
    user_id
    ,(UPPER(SUBSTRING(name, 1, 1)) + LOWER(SUBSTRING(name,2, LEN(name)-1))) as 'name'
from Users
ORDER BY user_id

-- Patients With a Condition
SELECT
    patient_id
    ,patient_name
    ,conditions
FROM Patients
WHERE
    conditions LIKE 'DIAB1%'
    or conditions LIKE '% DIAB1%'