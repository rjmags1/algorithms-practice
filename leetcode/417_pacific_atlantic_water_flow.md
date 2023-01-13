# 417. Pacific Atlantic Water Flow - Medium

There is an `m x n` rectangular island that borders both the Pacific Ocean and Atlantic Ocean. The Pacific Ocean touches the island's left and top edges, and the Atlantic Ocean touches the island's right and bottom edges.

The island is partitioned into a grid of square cells. You are given an `m x n` integer matrix `heights` where `heights[r][c]` represents the height above sea level of the cell at coordinate `(r, c)`.

The island receives a lot of rain, and the rain water can flow to neighboring cells directly north, south, east, and west if the neighboring cell's height is less than or equal to the current cell's height. Water can flow from any cell adjacent to an ocean into the ocean.

Return a 2D list of grid coordinates result where `result[i] = [ri, ci]` denotes that rain water can flow from cell `(ri, ci)` to both the Pacific and Atlantic oceans.

##### Example 1:

![](../assets/417-waterflow-grid.jpg)

```
Input: heights = [[1,2,2,3,5],[3,2,3,4,4],[2,4,5,3,1],[6,7,1,4,5],[5,1,1,2,4]]
Output: [[0,4],[1,3],[1,4],[2,2],[3,0],[3,1],[4,0]]
Explanation: The following cells can flow to the Pacific and Atlantic oceans, as shown below:
[0,4]: [0,4] -> Pacific Ocean 
       [0,4] -> Atlantic Ocean
[1,3]: [1,3] -> [0,3] -> Pacific Ocean 
       [1,3] -> [1,4] -> Atlantic Ocean
[1,4]: [1,4] -> [1,3] -> [0,3] -> Pacific Ocean 
       [1,4] -> Atlantic Ocean
[2,2]: [2,2] -> [1,2] -> [0,2] -> Pacific Ocean 
       [2,2] -> [2,3] -> [2,4] -> Atlantic Ocean
[3,0]: [3,0] -> Pacific Ocean 
       [3,0] -> [4,0] -> Atlantic Ocean
[3,1]: [3,1] -> [3,0] -> Pacific Ocean 
       [3,1] -> [4,1] -> Atlantic Ocean
[4,0]: [4,0] -> Pacific Ocean 
       [4,0] -> Atlantic Ocean
Note that there are other possible paths for these cells to flow to the Pacific and Atlantic oceans.
```

##### Example 2:

```
Input: heights = [[1]]
Output: [[0,0]]
Explanation: The water can flow from the only cell to the Pacific and Atlantic oceans.
```

##### Constraints:

- `m == heights.length`
- `n == heights[r].length`
- `1 <= m, n <= 200`
- <code>0 <= heights[r][c] <= 10<sup>5</sup></code>

## Solution

```
from collections import deque

# Time: O(mn)
# Space: O(mn)
class Solution:
    def pacificAtlantic(self, heights: List[List[int]]) -> List[List[int]]:
        m, n = len(heights), len(heights[0])
        dp = [[0] * n for _ in range(m)]
        diffs = ((0, -1), (0, 1), (1, 0), (-1, 0))
        inbounds = lambda i, j: 0 <= i < m and 0 <= j < n
        def bfs(q):
            seen = set()
            while q:
                i, j = q.popleft()
                if (i, j) in seen:
                    continue
                seen.add((i, j))
                dp[i][j] += 1
                for di, dj in diffs:
                    i2, j2 = i + di, j + dj
                    if not inbounds(i2, j2) or (i2, j2) in seen:
                        continue
                    if heights[i2][j2] >= heights[i][j]:
                        q.append((i2, j2))

        q1, q2 = deque(), deque()
        for i in range(m):
            q1.append((i, n - 1))
            q2.append((i, 0))
        for j in range(n):
            q1.append((m - 1, j))
            q2.append((0, j))
        bfs(q1)
        bfs(q2)
        return [[i, j] for i in range(m) for j in range(n) if dp[i][j] == 2]
```

## Notes
- It is most efficient to explore from the oceans inland via bfs such that neighbors are only added to the bfs queue if water could flow downward from the neighbor to the current cell. If we keep track of which cells could be touched by both oceans if we bfs according to this criteria starting from border cells of both oceans, we only do `2` grid traversals at most.