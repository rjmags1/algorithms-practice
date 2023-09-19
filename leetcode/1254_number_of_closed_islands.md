# 1254. Number of Closed Islands - Medium

Given a 2D `grid` consists of `0`s (land) and `1`s (water). An island is a maximal 4-directionally connected group of `0`s and a closed island is an island totally (all left, top, right, bottom) surrounded by `1`s.

Return the number of closed islands.

##### Example 1:

```
Input: grid = [[1,1,1,1,1,1,1,0],[1,0,0,0,0,1,1,0],[1,0,1,0,1,1,1,0],[1,0,0,0,0,1,0,1],[1,1,1,1,1,1,1,0]]
Output: 2
Explanation: 
Islands in gray are closed because they are completely surrounded by water (group of 1s).
```

##### Example 2:

```
Input: grid = [[0,0,1,0,0],[0,1,0,1,0],[0,1,1,1,0]]
Output: 1
```

##### Example 3:

```
Input: grid = [[1,1,1,1,1,1,1],
               [1,0,0,0,0,0,1],
               [1,0,1,1,1,0,1],
               [1,0,1,0,1,0,1],
               [1,0,1,1,1,0,1],
               [1,0,0,0,0,0,1],
               [1,1,1,1,1,1,1]]
Output: 2
```

##### Constraints:

- `1 <= grid.length, grid[0].length <= 100`
- `0 <= grid[i][j] <=1`

## Solution

```
from collections import deque

# Time: O(mn)
# Space: O(1)
class Solution:
    def closedIsland(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        inbounds = lambda i, j: 0 <= i < m and 0 <= j < n
        dirs = ((-1, 0), (1, 0), (0, -1), (0, 1))
        def mark_island(i, j):
            q = deque([(i, j)])
            while q:
                i, j = q.popleft()
                cell = grid[i][j]
                if cell == -1:
                    continue
                grid[i][j] = -1
                for di, dj in dirs:
                    i2, j2 = i + di, j + dj
                    if not inbounds(i2, j2) or grid[i2][j2] != 0:
                        continue
                    q.append((i2, j2))

        for j in range(n):
            if grid[0][j] == 0:
                mark_island(0, j)
            if grid[m - 1][j] == 0:
                mark_island(m - 1, j)
        for i in range(1, m - 1):
            if grid[i][0] == 0:
                mark_island(i, 0)
            if grid[i][n - 1] == 0:
                mark_island(i, n - 1)
        
        result = 0
        for i in range(1, m - 1):
            for j in range(1, n - 1):
                if grid[i][j] == 0:
                    result += 1
                    mark_island(i, j)
                    
        return result
```

## Notes
- We mark all non-closed islands with BFS before considering closed islands; any land cell that is connected to a matrix border land cell is part of a non-closed island. Note we could avoid mutating the input matrix at the cost of `O(mn)` space.