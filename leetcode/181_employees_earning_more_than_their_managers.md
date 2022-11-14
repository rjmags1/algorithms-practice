# 181. Employees Earning More Than Their Managers - Easy

```
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
```

Write an SQL query to find the employees who earn more than their managers.

Return the result table in any order.

The query result format is in the following example.

##### Example 1:

```
Input: 
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+
Output: 
+----------+
| Employee |
+----------+
| Joe      |
+----------+
Explanation: Joe is the only employee who earns more than his manager.
```

## Solution

```
SELECT t1.name AS Employee
FROM 
    Employee AS t1 
    JOIN Employee AS t2
    ON t1.managerId = t2.id
WHERE 
    t1.salary > t2.salary;
```

## Notes
- Basic inner join of a table on itself. Because we are doing an inner join, we don't need to worry about `NULL` values from manager rows where `managerId` is `NULL`.