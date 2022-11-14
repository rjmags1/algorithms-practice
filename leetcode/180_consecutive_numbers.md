# 180. Consecutive Numbers - Medium

```
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.
id is an autoincrement column.
```

Write an SQL query to find all numbers that appear at least three times consecutively.

Return the result table in any order.

The query result format is in the following example.

##### Example 1:

```
Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
```

## Solution 1

```
SELECT DISTINCT num AS ConsecutiveNums FROM (
    SELECT l1.id, l1.num, (
        (SELECT COUNT(*) FROM (
            SELECT l2.id, l2.num FROM Logs AS l2 
            WHERE l2.id = l1.id + 1 AND l1.num = l2.num)
            AS a) != 0
        AND
        (SELECT COUNT(*) FROM (
            SELECT l2.id, l2.num FROM Logs as l2 
            WHERE l2.id = l1.id + 2 AND l1.num = l2.num) 
            AS b) != 0
        ) 
        AS cons
    FROM Logs AS l1) AS withcons 
WHERE withcons.cons = TRUE;
```

## Notes
- This solution is much slower than below because we perform a bunch of nested queries, but the idea is the same - just checking if the next two rows have the same number.

## Solution 2

```
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1, Logs l2, Logs l3
WHERE (
    l1.id = l2.id - 1 AND
    l2.id = l3.id - 1 AND
    l1.num = l2.num AND
    l2.num = l3.num
);
```

## Notes
- Much faster because the effect of this kind of aliasing and duplication of the same table in the `FROM` clause essentially copies `Logs` and attaches it to itself so it is easy to reference the next row and the next next row.