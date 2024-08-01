-- Capital Gain/Loss
SELECT stock_name, Sum(case when operation = 'Buy' then (price * -1) else price end) as capital_gain_loss 
FROM STOCKS
GROUP BY stock_name

-- Tree Node
SELECT id, 
(CASE   WHEN p_id is null Then 'Root' 
        WHEN id in (SELECT t3.id 
                    from Tree t3 
                    LEFT JOIN Tree t4 
                    on t3.id = t4.p_id 
                    where t4.p_id is null) 
        Then 'Leaf' 
        ELSE 'Inner' END) as type
FROM Tree

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

--Human Traffic of Stadium
With CTE1 as
(
    SELECT * 
    FROM Stadium where people >= 100
)
Select * 
from Stadium 
WHERE id IN (SELECT id FROM CTE1)
and (
(id+1 in (SELECT id from CTE1) and id+2 in (SELECT id from CTE1))
or (id-1 in (SELECT id from CTE1) and id-2 in (SELECT id from CTE1))
or (id-1 in (SELECT id from CTE1) and id+1 in (SELECT id from CTE1))
)
-- or
SELECT DISTINCT 
S.id, S.visit_date, S.people
FROM Stadium AS S
INNER JOIN 
(
    SELECT S1.id AS id1, S2.id AS id2, S3.id AS id3
    FROM Stadium AS S1
    LEFT JOIN Stadium AS S2
    ON S2.id = DATEADD(day, 1, S1.id)
    LEFT JOIN Stadium AS S3
    ON S3.id = DATEADD(day, 1, S2.id)
    WHERE S1.people >= 100 AND S2.people >= 100 AND S3.people >= 100
) AS TOTAL
ON S.id = TOTAL.id1 OR S.id = TOTAL.id2 OR S.id = TOTAL.id3
ORDER BY S.visit_date

-- Trips and Users
With CTE as(
    Select
    id
    ,client_id
    ,driver_id
    ,city_id
    ,status
    ,request_at
    ,u1.banned as cb
    ,u2.banned as db
    from Trips t1
    
    inner join Users u1
    on t1.client_id = u1.users_id 
    
    inner join Users u2
    on t1.driver_id = u2.users_id
),
CTE2 as
(
    SELECT * from CTE where cb = 'No' AND db = 'No' 
) 
Select request_at as Day, Round(sum(Case when status LIKE 'cancelled%' then 1.0 else 0.0 end)/count(client_id),2) as 'Cancellation Rate'
FROM CTE2 c1
where request_at between '2013-10-01' and '2013-10-03'
GROUP BY request_at