-- https://leetcode.com/problems/nth-highest-salary/
-- Oracle

CREATE FUNCTION getNthHighestSalary(N IN NUMBER) RETURN NUMBER IS
result NUMBER;
BEGIN
    select distinct salary into result from (
    Select salary, dense_rank() over (order by salary desc) as rank from employee)
    where rank = N;
    
    RETURN result;
END;