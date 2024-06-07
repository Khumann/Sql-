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