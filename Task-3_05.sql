-- The Number of Employees Which Report to Each Employee
with cte as 
(Select reports_to,
count(reports_to) as reports_count,
Round(Avg(age*1.0),0) as average_age
from Employees
where reports_to is not null
group by reports_to)

Select e.employee_id, e.name, cte.reports_count, cte.average_age
from Employees e
inner join cte
on e.employee_id = cte.reports_to

-- Primary Department for Each Employee
With cte as 
(SELECT 
    employee_id,
    CASE 
        WHEN COUNT(e.department_id) = 1 THEN MAX(e.department_id)  
        ELSE MAX(CASE WHEN primary_flag = 'Y' THEN e.department_id END)  
    END AS department_id
FROM 
    Employee e
GROUP BY 
    e.employee_id)

Select * from cte
where department_id is not null

-- Triangle Judgement
Select 
x,
y,
z,
(CASE
    WHEN X+Y > Z and Y+Z > X and X+Z > Y 
    THEN 'Yes' ELSE 'No' END) as triangle
from Triangle


--Consecutive Numbers
With cte as(
Select 
id, 
num, 
id - row_number() over(partition by num order by id asc) as rr
from LOGS)

Select Distinct num as ConsecutiveNums
from cte
group by num, rr
having count(id) >= 3

-- Product Price at a Given Date
With cte as(
SELECT 
    product_id, 
    MAX(change_date) AS change_date
from 
    Products
where 
    change_date <= '2019-08-16'
group by 
    product_id
)
,cte2 as(Select distinct product_id from Products)

Select 
cte2.product_id, 
Coalesce(p.new_price, 10) as price

from cte2 
left join cte
on cte2.product_id = cte.product_id

left join Products p
on cte.change_date = p.change_date
and cte.product_id = p.product_id

-- Last Person to Fit in the Bus
With cte as(
    SELECT turn,
    person_name,
    SUM(q.weight) OVER (ORDER BY q.turn) AS Total_Weight
    FROM 
        Queue q
)
Select top 1 person_name 
from cte where Total_Weight <= 1000
order by Total_Weight desc

--Count Salary Categories
Select 'Low Salary' as category, Count(*) as accounts_count
from accounts
where income < 20000
Union ALL
Select 'Average Salary' as category, Count(*) as accounts_count
from accounts
where income between 20000 and 50000
Union ALL
Select 'High Salary' as category, Count(*) as accounts_count
from accounts
where income > 50000

-- Employees Whose Manager Left the Company
With cte as(

Select employee_id, manager_id
from Employees 
where 
    manager_id is not null
    and salary < 30000
)

Select cte.employee_id
from cte
left join Employees e
on e.employee_id = cte.manager_id
where e.employee_id is null
order by cte.employee_id