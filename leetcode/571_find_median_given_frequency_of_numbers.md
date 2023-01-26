# 571. Find Median Given Frequency of Numbers - Hard

Table: `Numbers`

```
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
| frequency   | int  |
+-------------+------+
num is the primary key for this table.
Each row of this table shows the frequency of a number in the database.
```

The median is the value separating the higher half from the lower half of a data sample.

Write an SQL query to report the median of all the numbers in the database after decompressing the `Numbers` table. Round the median to one decimal point.

The query result format is in the following example.

##### Example 1:

```
Input: 
Numbers table:
+-----+-----------+
| num | frequency |
+-----+-----------+
| 0   | 7         |
| 1   | 1         |
| 2   | 3         |
| 3   | 1         |
+-----+-----------+
Output: 
+--------+
| median |
+--------+
| 0.0    |
+--------+
Explanation: 
If we decompress the Numbers table, we will get [0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3], so the median is (0 + 0) / 2 = 0.
```

## Solution

```
WITH cte AS (
    SELECT num,
           SUM(frequency) OVER (ORDER BY num) - frequency AS low,
           SUM(frequency) OVER (ORDER BY num) AS hi,
           SUM(frequency) OVER () / 2 AS median_freq_prefix_sum
    from numbers 
)

SELECT AVG(num) as median
FROM cte
WHERE median_freq_prefix_sum BETWEEN low AND hi;
```

## Notes
- Pretty tricky one, uses the idea of prefix sums of frequencies. The middle numbers, if in sorted order, will have 1-index in the central frequency prefix sum range (AKA will be a middle number) if frequencies are sorted in ascending order by their corresponding number. `low` is the start of the frequency prefix sum range for a particular number, and `hi` is the end.