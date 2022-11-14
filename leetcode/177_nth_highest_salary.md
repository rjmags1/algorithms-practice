# 177. Nth Highest Salary - Medium

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

Write an SQL query to report the <code>n<sup>th</sup></code> highest salary from the `Employee` table. If there is no <code>n<sup>th</sup></code> highest salary, the query should report `null`.

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
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
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
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
```

## Solution

```
# Time: O(n)
# Space: O(n)
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  DECLARE ndec INT;
  SET ndec = N - 1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT IFNULL(
          (
              SELECT DISTINCT salary
              FROM Employee
              ORDER BY salary DESC
              LIMIT 1 OFFSET ndec
          ), NULL
      )
  );
END
```

## Notes
- Main thing here is using variables so we don't offset the nth highest salary. `LIMIT` and `OFFSET` do not permit subtraction in their arguments hence the need to use a variable. Also note the use of `IFNULL()`.