-- Replace Employee ID With The Unique Identifier
SELECT
    e2.unique_id
    ,e1.name
FROM Employees e1

LEFT JOIN EmployeeUNI e2
ON e1.id = e2.id

-- Product Sales Analysis I
SELECT
    p.product_name
    ,s.year
    ,s.price
FROM Sales s

Inner JOIN Product p
on s.product_id = p.product_id

-- Customer Who Visited but Did Not Make Any Transactions
SELECT 
customer_id
,count(v.visit_id) as count_no_trans
FROM Visits v

LEFT JOIN Transactions t
ON v.visit_id = t.visit_id

WHERE t.transaction_id IS NULL

GROUP BY customer_id

-- Rising Temperature
With CTE AS
(
    Select w1.id, (w1.temperature - w2.temperature) as tempDiff
    FROM Weather w1
    Left Join Weather w2
    on DATEDIFF(DAY, w2.recordDate,w1.recordDate) = 1
)
Select id
FROM CTE
where tempDiff > 0

-- Average Time of Process per Machine
SELECT
machine_id,
ROUND(SUM
(
    CASE    WHEN activity_type = 'start' THEN -1 * timeStamp
            When activity_type = 'end' THEN timeStamp
    END
)/(Count(process_id)/2),3) as
processing_time
FROM ACTIVITY
GROUP BY machine_id
