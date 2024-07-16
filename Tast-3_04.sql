-- Game Play Analysis IV
WITH cte AS (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
),
cte2 AS (
    SELECT *, DATEADD(DAY, 1, first_login) AS next_date
    FROM cte
)

SELECT 
    ROUND(
        (SELECT COUNT(DISTINCT player_id)
         FROM Activity 
         WHERE EXISTS (
             SELECT 1
             FROM cte2
             WHERE Activity.player_id = cte2.player_id
             AND Activity.event_date = cte2.next_date
         )
        ) * 1.0 / (SELECT COUNT(DISTINCT player_id) FROM Activity)
    , 2) AS fraction;

-- Number of Unique Subjects Taught by Each Teacher
Select
teacher_id
,Count(distinct subject_id) as cnt
from Teacher

group by teacher_id

-- User Activity for the Past 30 Days I
Select activity_date as day, Count(Distinct user_id) as active_users
from Activity
where activity_date>DateAdd(Day, -30,'2019-07-27') and activity_date<='2019-07-27'
group by activity_date

-- Product Sales Analysis III
WITH cte AS
(SELECT product_id, MIN(year) AS minimum_year
FROM Sales
GROUP BY product_id)

SELECT 
product_id, 
year AS first_year,
quantity,
price
FROM Sales
WHERE EXISTS(
    SELECT 1
    FROM cte
    WHERE Sales.year = cte.minimum_year
    AND Sales.product_id = cte.product_id
)


-- Classes More Than 5 Students
Select class
from Courses

group by Class
having count(student) >= 5

-- Find Followers Count
Select user_id, Count(follower_id) as followers_count
from Followers
group by user_id
order by user_id

-- Biggest Single Number
WITH cte AS (SELECT num
FROM MyNumbers
GROUP BY num
HAVING count(num) = 1)

SELECT max(num) AS num
FROM cte

-- Customers Who Bought All Products

Select customer_id 
from Customer 
group by customer_id
having count(Distinct product_key) = (Select Count(*) from Product)