# 1162. As Far from Land as Possible - Medium

Given an `n x n` grid containing only values `0` and `1`, where `0` represents water and `1` represents land, find a water cell such that its distance to the nearest land cell is maximized, and return the distance. If no land or water exists in the grid, return `-1`.

The distance used in this problem is the Manhattan distance: the distance between two cells `(x0, y0)` and `(x1, y1)` is `|x0 - x1|` + `|y0 - y1|`.

##### Example 1:

```
Input: grid = [[1,0,1],[0,0,0],[1,0,1]]
Output: 2
Explanation: The cell (1, 1) is as far as possible from all the land with distance 2.
```

##### Example 2:

```
Input: grid = [[1,0,0],[0,0,0],[0,0,0]]
Output: 4
Explanation: The cell (2, 2) is as far as possible from all the land with distance 4.
```

##### Constraints:

- `n == grid.length`
- `n == grid[i].length`
- `1 <= n <= 100`
- `grid[i][j]` is `0` or `1`

## Solution

```
from collections import deque

# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def maxDistance(self, grid: List[List[int]]) -> int:
        n = len(grid)
        dp = [[-1 for _ in range(n)] for _ in range(n)]
        q = deque()
        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    q.append((i, j, 0))
        dirs = ((-1, 0), (1, 0), (0, -1), (0, 1))
        inbounds = lambda i, j: 0 <= i < n and 0 <= j < n
        result = -1
        while q:
            i, j, d = q.popleft()
            if grid[i][j] == 0:
                if dp[i][j] > -1:
                    continue
                dp[i][j] = d
                result = max(result, dp[i][j])
            for di, dj in dirs:
                i2, j2 = i + di, j + dj
                if inbounds(i2, j2) and grid[i2][j2] == 0 and dp[i2][j2] == -1:
                    q.append((i2, j2, d + 1))

        return result
```

## Notes
- This is a pretty typical BFS problem where the queue gets initialized with all of the land cells. If we BFS from the land cells, whenever we reach a water cell that was previously unreached, we know the minimum distance from land for the water cell.