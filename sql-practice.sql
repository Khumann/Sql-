--1 
/*Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary*/


WITH RankedSalaries AS (
    SELECT 
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rank
    FROM 
        Employee
)
SELECT 
    Salary AS nth_highest_salary
FROM 
    RankedSalaries
WHERE 
    Rank = N;
    
--2
 /* Write a solution to find the second highest salary from the Employee table. If there is no second highest salary */
    SELECT MAX(salary) AS Second Highest_Salary 
    FROM Employess 
    WHERE Salary <> (select MAX(Salary) FROM Employee); -- The subquery used above  query is a scalar subquery because it returns a single value and is not correlated to the outer query.
    


--3 
/* Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules the scores should be ranked from the highest to the lowest.
        --If there is a tie between two scores, both should have the same ranking.
        --After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
        --Return the result table ordered by score in descending order. */

    SELECT
     Score,
         (SELECT count(distinct Score)
             FROM Scores
             WHERE Score >= s.Score) AS `Rank`
    FROM Scores s
    ORDER BY Score desc;    


 --4
 /*  Find all numbers that appear at least three times consecutively. Return the result table in any order.*/
   
  --  1ST PART  I have used CTE TO SOLVE THIS
 WITH NumberSequences AS (
    SELECT
        id,
        num,
        LAG(num, 1) OVER (ORDER BY id) AS prev_num,
        LEAD(num, 1) OVER (ORDER BY id) AS next_num
    FROM Logs
),

ConsecutiveNums AS (
    SELECT
        num
    FROM NumberSequences
    WHERE num = prev_num AND num = next_num
)
SELECT DISTINCT num as consecutiveNums
FROM ConsecutiveNums;


--2ND PART bY USING SELF JOIN
 select Distinct L1.num
    from Logs L1
    join Logs l2 on L1.id=L2.id -1 --use -1 to start the sequence by checking its previous row
    join Logs L3 on L2.id=L3.id -2 --use -2 to check the sequence two position before  by checking the previous 2 rows, so that it will maintain the sequence with out making it complex and confirms the continuation of it
    where L1.num=L2.num AND L2.num = L3.num




 /* Employees Earning More Than Their Managers Write a solution to find the employees who earn more than their managers.

Return the result table in any order. */
select e1.name as Employee
from employee e1
inner join employee e2 on  e1.managerId = e2.id
where e1.salary > e2.salary

/* DUPLICATE EMAIL*/

--1st solution
   select email
      from Person 
   having count(email) >1;

--2nd solution   
select distinct(p2.email)
from Person p1
inner join person p2 on p2.email=p1.email AND p1.id <> p2.id



/* Customers Who Never Order Write a solution to find all customers who never order anything. */

select name  as Customers
from Customers as c
Left join orders as o on c.id=o.customerId
where o.customerId IS NULL



/* Department Highest Salary*/
    SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary
FROM Employee e
JOIN Department d ON e.departmentId = d.id
WHERE (e.departmentId, e.salary) IN (
    SELECT departmentId, MAX(salary)
    FROM Employee
    GROUP BY departmentId
);


--2nd using CTE
WITH Dum AS (
    SELECT departmentId, MAX(salary) AS max_salary
    FROM Employee
    GROUP BY departmentId
)
SELECT D.name AS Department, E.name AS Employee, E.salary
FROM Employee E
JOIN Department D ON E.departmentId = D.id
JOIN Dum D ON E.departmentId = D.departmentId AND E.salary = D.max_salary;


/* A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order.*/ 
SELECT Department, Employee, salary 
from ( select d.name as department, E.name as employee, salary, 
        dense_rank() over(partition by  d.name order by salary desc)  Rak
         from Employee E 
         inner join Department D on E.departmentid = D.id) as t1

where Rak <=3


/*You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.



Grades contains the following data:



Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

Write a query to help Eve.*/

SELECT 
    CASE 
        WHEN G.grade < 8 THEN 'NULL' 
        ELSE S.name 
    END AS Name, 
    G.grade AS Grade, 
    S.marks AS Marks
FROM 
    Students S 
INNER JOIN 
    Grades G 
ON 
    S.marks BETWEEN G.min_mark AND G.max_mark
ORDER BY 
    G.grade DESC,
    CASE 
        WHEN G.grade < 8 THEN S.marks
        ELSE S.name
    END,
    S.marks;



with salary_range
AS
(select
    employee_id,
        name,
        year,
        salary,
        LAG(salary) OVER(Partition BY employee_id order by year) as prev_salary
        from employee_salary)
select employee_id, name
from salary_rangewhere salary > prev_year_salary
group by employee_id, name
having count (*) >= 3