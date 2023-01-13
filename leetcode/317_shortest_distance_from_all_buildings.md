# 317. Shortest Distance From All Buildings - Hard

You are given an `m x n` grid `grid` of values `0`, `1`, or `2`, where:

- each `0` marks an empty land that you can pass by freely,
- each `1` marks a building that you cannot pass through, and
- each `2` marks an obstacle that you cannot pass through.

You want to build a house on an empty land that reaches all buildings in the shortest total travel distance. You can only move up, down, left, and right.

Return the shortest travel distance for such a house. If it is not possible to build such a house according to the above rules, return `-1`.

The total travel distance is the sum of the distances between the houses of the friends and the meeting point.

The distance is calculated using Manhattan Distance, where `distance(p1, p2) = |p2.x - p1.x| + |p2.y - p1.y|`.

##### Example 1:

```
Input: grid = [[1,0,2,0,1],[0,0,0,0,0],[0,0,1,0,0]]
Output: 7
Explanation: Given three buildings at (0,0), (0,4), (2,2), and an obstacle at (0,2).
The point (1,2) is an ideal empty land to build a house, as the total travel distance of 3+3+1=7 is minimal.
So return 7.
```

##### Example 2:

```
Input: grid = [[1,0]]
Output: 1
```

##### Example 3:

```
Input: grid = [[1]]
Output: -1
```

##### Constraints:

- `m == grid.length`
- `n == grid[i].length`
- `1 <= m, n <= 50`
- `grid[i][j]` is either `0`, `1`, or `2`.
- There will be at least one building in the grid.

## Solution 1

```
class LandInfo:
    def __init__(self):
        self.d = self.b = 0

# Time: O(mn * mn)
# Space: O(mn)
class Solution:
    def shortestDistance(self, grid: List[List[int]]) -> int:
        LAND, BUILDING, OBSTACLE = 0, 1, 2
        dp, totalbuildings = [], 0
        buildingpos = []
        for i, row in enumerate(grid):
            dp.append([])
            for j, cell in enumerate(row):
                if cell == BUILDING:
                    totalbuildings += 1
                    buildingpos.append((i, j))
                    dp[-1].append("B")
                elif cell == OBSTACLE:
                    dp[-1].append("X")
                else:
                    dp[-1].append(LandInfo())
                    
        m, n = len(grid), len(grid[0])
        diffs = ((0, 1), (0, -1), (1, 0), (-1, 0))
        inbounds = lambda i, j: 0 <= i < m and 0 <= j < n
        def bfs(frombuildingpos):
            q = deque([(frombuildingpos, 0)])
            seen = set()
            while q:
                curr, d = q.popleft()
                if curr in seen:
                    continue
                seen.add(curr)
                i, j = curr
                if d != 0:
                    dp[i][j].b += 1
                    dp[i][j].d += d
                
                for di, dj in diffs:
                    i2, j2 = i + di, j + dj
                    if not inbounds(i2, j2) or grid[i2][j2] != LAND or (i2, j2) in seen:
                        continue
                    q.append(((i2, j2), d + 1))
        
        for bp in buildingpos:
            bfs(bp)
        result = inf
        for i in range(m):
            for j in range(n):
                if grid[i][j] == LAND and dp[i][j].b == totalbuildings:
                    result = min(result, dp[i][j].d)
                    
        return result if result != inf else -1
```

## Notes
- Note that this solution may time out, just like the first two official approaches on the platform, may timeout because it is missing a key optimization: it is useless to search land cells that we know cannot reach all buildings. Still, it has the same complexity as the optimal solution, and only creates a single auxiliary matrix, `dp`. Note that another optimization could be made such that we perform bfs from houses or lands depending on which there are more of.
- The trickiest part of this algorithm is realizing that there may be land cells that can reach all buildings, there could be land cells that can only reach some buildings, and there could be some that can reach zero buildings. We can only consider those that can reach all buildings for our final answer, and as a result we need some way of tabulating the total distances for all lands as well as the number of buildings they can reach.

## Solution 2

```
class LandInfo:
    def __init__(self):
        self.d = self.b = 0

class Solution:
    def shortestDistance(self, grid: List[List[int]]) -> int:
        LAND, BUILDING, OBSTACLE = 0, 1, 2
        dp, totalbuildings = [], 0
        buildingpos = []
        for i, row in enumerate(grid):
            dp.append([])
            for j, cell in enumerate(row):
                if cell == BUILDING:
                    totalbuildings += 1
                    buildingpos.append((i, j))
                    dp[-1].append("B")
                elif cell == OBSTACLE:
                    dp[-1].append("X")
                else:
                    dp[-1].append(LandInfo())
                    
        m, n = len(grid), len(grid[0])
        diffs = ((0, 1), (0, -1), (1, 0), (-1, 0))
        inbounds = lambda i, j: 0 <= i < m and 0 <= j < n
        def bfs(frombuildingpos, buildingno):
            q = deque([(frombuildingpos, 0)])
            seen = set()
            while q:
                curr, d = q.popleft()
                if curr in seen:
                    continue
                seen.add(curr)
                i, j = curr
                if d != 0:
                    if dp[i][j].b != buildingno:
                        continue
                    dp[i][j].b += 1
                    dp[i][j].d += d
                
                for di, dj in diffs:
                    i2, j2 = i + di, j + dj
                    if not inbounds(i2, j2) or grid[i2][j2] != LAND or (i2, j2) in seen:
                        continue
                    q.append(((i2, j2), d + 1))
        
        for buildingno, bp in enumerate(buildingpos):
            bfs(bp, buildingno)
        result = inf
        for i in range(m):
            for j in range(n):
                if grid[i][j] == LAND and dp[i][j].b == totalbuildings:
                    result = min(result, dp[i][j].d)
                    
        return result if result != inf else -1
```

## Notes
- This approach, even with the optimization discussed above, may still time out at some points because of some combination of the following: I am using python, I use `LandInfo` objects instead of array doublets, I use a `set` in bfs instead of another method that does not require hash lookups, (and probably most importantly) leetcode runtime inconsistency. However, it is conceptually optimal and most of the passing submits of this solution run at ~60th percentile even with the above implementation-related inefficiencies.