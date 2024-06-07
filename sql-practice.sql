--1 /*Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary*/


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
    
--2 /* Write a solution to find the second highest salary from the Employee table. If there is no second highest salary */
    SELECT MAX(salary) AS Second Highest_Salary 
    FROM Employess 
    WHERE Salary <> (select MAX(Salary) FROM Employee); -- The subquery used above  query is a scalar subquery because it returns a single value and is not correlated to the outer query.
    


--3 /* Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules the scores should be ranked from the highest to the lowest.
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