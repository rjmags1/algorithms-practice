# 63. Unique Paths II - Medium

You are given an `m x n` integer array grid. There is a robot initially located at the top-left corner (i.e., `grid[0][0]`). The robot tries to move to the bottom-right corner (i.e., `grid[m - 1][n - 1]`). The robot can only move either down or right at any point in time.

An obstacle and space are marked as `1` or `0` respectively in grid. A path that the robot takes cannot include any square that is an obstacle.

Return the number of possible unique paths that the robot can take to reach the bottom-right corner.

The testcases are generated so that the answer will be less than or equal to <code>2 * 10<sup>9</sup></code>.

##### Example 1:

```
Input: obstacleGrid = [[0,0,0],[0,1,0],[0,0,0]]
Output: 2
Explanation: There is one obstacle in the middle of the 3x3 grid above.
There are two ways to reach the bottom-right corner:
1. Right -> Right -> Down -> Down
2. Down -> Down -> Right -> Right
```

##### Example 2:

```
Input: obstacleGrid = [[0,1],[0,0]]
Output: 1
```

##### Constraints:

- `m == obstacleGrid.length`
- `n == obstacleGrid[i].length`
- `1 <= m, n <= 100`
- `obstacleGrid[i][j] is 0 or 1`.

## Solution

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def uniquePathsWithObstacles(self, obstacleGrid: List[List[int]]) -> int:
        m, n = len(obstacleGrid), len(obstacleGrid[0])
        dp = [[0] * n for _ in range(m)]
        dp[0][0] = 1 if obstacleGrid[0][0] == 0 else 0
        for j in range(1, n):
            dp[0][j] = 0 if dp[0][j - 1] == 0 or obstacleGrid[0][j] == 1 else 1
        for i in range(1, m):
            dp[i][0] = 0 if dp[i - 1][0] == 0 or obstacleGrid[i][0] == 1 else 1
        for i in range(1, m):
            for j in range(1, n):
                dp[i][j] = 0 if obstacleGrid[i][j] == 1 else dp[i - 1][j] + dp[i][j - 1]
        
        return dp[-1][-1]
```

## Notes
- Same logic as for 62. Unique Paths, except a few extra edge cases to handle due to the presences of obstacles. For the top row and leftmost column, it is important to note that as soon as we encounter an obstacle all cells after those become unreachable.