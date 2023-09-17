# 934. Shortest Bridge - Medium

You are given an `n x n` binary matrix grid where `1` represents land and `0` represents water.

An island is a 4-directionally connected group of `1`'s not connected to any other `1`'s. There are exactly two islands in grid.

You may change `0`'s to `1`'s to connect the two islands to form one island.

Return the smallest number of `0`'s you must flip to connect the two islands.

##### Example 1:

```
Input: grid = [[0,1],[1,0]]
Output: 1
```

##### Example 2:

```
Input: grid = [[0,1,0],[0,0,0],[0,0,1]]
Output: 2
```

##### Example 3:

```
Input: grid = [[1,1,1,1,1],[1,0,0,0,1],[1,0,1,0,1],[1,0,0,0,1],[1,1,1,1,1]]
Output: 1
```

##### Constraints:

- `n == grid.length == grid[i].length`
- `2 <= n <= 100`
- `grid[i][j]` is either `0` or `1`.
- There are exactly two islands in grid.

## Solution

```
from collections import deque

# Time: O(n^2)
# Space: O(n)
class Solution:
    dirs = ((0, 1), (0, -1), (1, 0), (-1, 0))
    inbounds = lambda self, i, j: 0 <= i < self.n and 0 <= j < self.n
    def mark_island(self, i, j, grid):
        q = deque([(i, j)])
        island_cells = []
        while q:
            i, j = q.popleft()
            if grid[i][j] == -1:
                continue
            grid[i][j] = -1
            island_cells.append((i, j))
            for di, dj in self.dirs:
                i2, j2 = i + di, j + dj
                if not self.inbounds(i2, j2) or grid[i2][j2] != 1:
                    continue
                q.append((i2, j2))

        return island_cells

    def shortestBridge(self, grid: List[List[int]]) -> int:
        # bfs to mark first island
        # bfs from all first island cells
        n = len(grid)
        self.n = n
        from_cells = None
        for i in range(n):
            for j, num in enumerate(grid[i]):
                if num == 1:
                    from_cells = self.mark_island(i, j, grid)
                    break
            if from_cells is not None:
                break
        
        q = deque([(i, j, 0) for i, j in from_cells])
        while q:
            i, j, steps = q.popleft()
            if grid[i][j] == -2:
                continue
            grid[i][j] = -2

            for di, dj in self.dirs:
                i2, j2 = i + di, j + dj
                if not self.inbounds(i2, j2) or grid[i2][j2] < 0:
                    continue
                if grid[i2][j2] == 1:
                    return steps
                q.append((i2, j2, steps + 1))
```

## Notes
- We need one BFS traversal to mark all cells of one of the islands and another BFS traversal to find the shortest path of `0`s from any cell of the first island to any cell of the second. Note the linear space complexity. A BFS queue for a BFS traversal of a 2D grid that avoids redundant enqueue operations has length asymptotically upper bounded by the max dimension of the grid, and I mutate the input grid instead of using a hash data structure to keep track of previously traversed cells.