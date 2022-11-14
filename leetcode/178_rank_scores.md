
# 178. Rank Scores - Medium

```
Table: Scores

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| score       | decimal |
+-------------+---------+
id is the primary key for this table.
Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
```

Write an SQL query to rank the scores. The ranking should be calculated according to the following rules:

- The scores should be ranked from the highest to the lowest.
- If there is a tie between two scores, both should have the same ranking.
- After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.

Return the result table ordered by `score` in descending order.

The query result format is in the following example.

##### Example 1:

```
Input: 
Scores table:
+----+-------+
| id | score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
Output: 
+-------+------+
| score | rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+
```

## Solution 1

```
SELECT score, DENSE_RANK() OVER w AS 'rank'
FROM Scores
WINDOW w AS (ORDER BY score DESC);
```

## Notes
- Direct application of window function `DENSE_RANK()`.

## Solution 2

```
SELECT s1.score, (
    SELECT COUNT(DISTINCT s2.score)
    FROM Scores s2
    WHERE s2.score >= s1.score
) as 'rank'
FROM
Scores s1
ORDER BY s1.score DESC;
```

## Notes
- Count the number of distinct scores greater than the score of the current row as we process the query to determine the rank value for that row. The rank the prompt is asking for will always be the number of distinct scores more than or equal to the current score in the dataset.

## Solution 3

```
SELECT S.score, COUNT(DISTINCT T.score) AS 'rank'
FROM (
    Scores S
    JOIN Scores T ON S.score <= T.score
)
GROUP BY S.id
ORDER BY S.score DESC;
```

## Notes
- Same idea as above, except instead of counting the number of scores greater than the current score as we build each row, we `JOIN` `Scores` on itself such that every left row will have every row in `Scores` with a score greater than or equal to it appended to it as a new row in the joined table. This allows us to count the number of distinct scores greater than or equal to the current score so long as we group by the row id and not by score.
- This approach passes but is much slower than the previous two due to the large `JOIN`.