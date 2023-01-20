# 534. Game Play Analysis III - Medium

`Table: Activity`

```
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
```

Write an SQL query to report for each player and date, how many games played so far by the player. That is, the total number of games played by the player until that date. Check the example for clarity.

Return the result table in any order.

The query result format is in the following example.

##### Example 1:

```
Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 1         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+------------+---------------------+
| player_id | event_date | games_played_so_far |
+-----------+------------+---------------------+
| 1         | 2016-03-01 | 5                   |
| 1         | 2016-05-02 | 11                  |
| 1         | 2017-06-25 | 12                  |
| 3         | 2016-03-02 | 0                   |
| 3         | 2018-07-03 | 5                   |
+-----------+------------+---------------------+
Explanation: 
For the player with id 1, 5 + 6 = 11 games played by 2016-05-02, and 5 + 6 + 1 = 12 games played by 2017-06-25.
For the player with id 3, 0 + 5 = 5 games played by 2018-07-03.
Note that for each player we only care about the days when the player logged in.
```

## Solution 1

```
SELECT 
    player_id, 
    event_date,
    SUM(A1.games_played) OVER (
        PARTITION BY
        A1.player_id
        ORDER BY
        A1.event_date
  ) AS games_played_so_far
FROM Activity AS A1;
```

## Notes
- Using a window function in situations like these is much more efficient than running a 'correlated subquery' (shown below) due to how they are implemented under the hood. Ostensibly correlated subqueries results in nested for loops where as window functions don't.

## Solution 2

```
SELECT 
    player_id, 
    event_date, (
        SELECT SUM(games_played) 
        FROM Activity AS A2 
        WHERE 
            A2.player_id = A1.player_id AND 
            A2.event_date <= A1.event_date
    ) AS games_played_so_far
FROM Activity AS A1;
```