# 176. Second Highest Salary - Medium

```
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
```

Write an SQL query to report the second highest salary from the `Employee` table. If there is no second highest salary, the query should report `null`.

The query result format is in the following example.

##### Example 1:

```
Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
```

##### Example 2:

```
Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
```

## Solution

```
SELECT salary AS SecondHighestSalary
FROM (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 2
) as TopTwo 
UNION (
    SELECT NULL
)
UNION (
    SELECT NULL
)
ORDER BY SecondHighestSalary DESC LIMIT 1 OFFSET 1;
```

## Notes
- More to this question than meets the eye. In the main query we `UNION` a subquery that gets the top two `DISTINCT` salaries from `Employee` in descending order. Then we `UNION` the temp table result of this subquery with `NULL` twice in case there are less than `2` distinct salaries in `Employee`. Finally we `SELECT` from `DESC` sorted `UNION`'d temp table to get the second highest salary using `OFFSET` and `LIMIT`. Note how the `OFFSET` gets applied before `LIMIT` in terms of execution despite the opposite ordering in the syntax.