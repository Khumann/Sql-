

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
    
    /* Write a solution to find the second highest salary from the Employee table. If there is no second highest salary */
    SELECT MAX(salary) AS Second Highest_Salary 
    FROM Employess 
    WHERE Salary <> (select MAX(Salary) FROM Employee); -- The subquery used above  query is a scalar subquery because it returns a single value and is not correlated to the outer query.
    