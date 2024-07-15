-- temperature

Select w2.id
from Weather w1
full outer join Weather w2
on DATEDIFF(day, w1.recordDate, w2.recordDate) = 1

where w1.temperature < w2.temperature

-- Average Time of Process per Machine
Select a1.machine_id, round(sum(a2.timestamp - a1.timestamp)/count(a1.machine_id),3) as processing_time
from Activity a1
inner join Activity a2
on a1.machine_id = a2.machine_id 
and a1.process_id = a2.process_id 
and a1.activity_type = 'start' 
and a2.activity_type = 'end'

group by a1.machine_id

order by a1.machine_id

-- Employee Bonus
Select e.name, b.bonus

from Employee e
left join Bonus b
on e.empID = b.empID

where Coalesce(b.bonus,0) < 1000

-- Students and Examinations

SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.student_id) AS attended_exams
FROM Students s

CROSS JOIN Subjects sub

LEFT JOIN Examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;

--Average selling price
Select
p.product_id,
Coalesce(Round(Sum(u.units * p.price)/(sum(u.units)*1.0),2),0) as average_price

from UnitsSold u

right join Prices p
on (u.purchase_date >= p.start_date
and u.purchase_date <= p.end_date 
and p.product_id = u.product_id)
group by p.product_id


--Not Boring Movies
Select * from Cinema
where id % 2 = 1
and description != 'boring'
order by rating desc

--Project employees 1
Select 
p.project_id,
Coalesce(Round(Sum(e.experience_years)/(count(e.employee_id)*1.0),2),0) as average_years
from Project p
left join Employee e
on p.employee_id = e.employee_id

group by p.project_id

order by p.project_id

--Percentage of Users Attended a Contest
Select 
r.contest_id,
Coalesce(Round(count(u.user_id)* 100.00 / (Select count(*) from users),2),0) as percentage

from Register r

inner join Users u
on u.user_id = r.user_id

group by contest_id

order by percentage desc, contest_id asc

--Queries Quality and Percentage
Select query_name,
Round(Avg(q.rating * 1.0 / q.position),2) as quality,
Round(Avg(Case when q.rating < 3 then 1.0 else 0 end)*100, 2) as poor_query_percentage

from Queries q

group by query_name
having q.query_name is not null

--Monthly Transactions I
SELECT 
    FORMAT(trans_date, 'yyyy-MM') AS month,
    country,
    COUNT(id) AS trans_count,
    COUNT(case when t.state = 'approved' then id end) as approved_count,
    Coalesce(SUM(t.amount), 0) as trans_total_amount,
    Coalesce(SUM(case when t.state = 'approved' then t.amount end), 0) as approved_total_amount
FROM 
    Transactions t
GROUP BY 
    FORMAT(trans_date, 'yyyy-MM'), 
    country

--
SELECT 
    round((avg(CASE 
        WHEN first_start_date = last_end_date THEN 1.0
        else 0.0 
    END)*100),2) AS immediate_percentage 
FROM 
    (SELECT 
        customer_id,
        MIN(delivery_id) AS first_order_id,
        MIN(order_date) AS first_start_date,
        MIN(customer_pref_delivery_date) AS last_end_date
    FROM 
        Delivery
    GROUP BY 
        customer_id) as abc