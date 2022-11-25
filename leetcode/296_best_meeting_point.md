# 296. Best Meeting Point - Hard

Given an `m x n` binary grid `grid` where each `1` marks the home of one friend, return the minimal total travel distance.

The total travel distance is the sum of the distances between the houses of the friends and the meeting point.

The distance is calculated using Manhattan Distance, where `distance(p1, p2) = |p2.x - p1.x| + |p2.y - p1.y|`.

##### Example 1:

```
Input: grid = [[1,0,0,0,1],[0,0,0,0,0],[0,0,1,0,0]]
Output: 6
Explanation: Given three friends living at (0,0), (0,4), and (2,2).
The point (0,2) is an ideal meeting point, as the total travel distance of 2 + 2 + 2 = 6 is minimal.
So return 6.
```

##### Example 2:

```
Input: grid = [[1,1]]
Output: 1
```

##### Constraints:

- `m == grid.length`
- `n == grid[i].length`
- `1 <= m, n <= 200`
- `grid[i][j]` is either `0` or `1`.
- There will be at least two friends in the grid.

## Solution

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def minTotalDistance(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        rows = []
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    rows.append(i)
        cols = []
        for j in range(n):
            for i in range(m):
                if grid[i][j] == 1:
                    cols.append(j)
        mpi, mpj = rows[len(rows) // 2], cols[len(cols) // 2]
        result = 0
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    result += abs(i - mpi) + abs(j - mpj)
        return result
```

## Notes
- This is a fairly counterintuitive problem, because we are asked to expand a paradigm that makes good sense in 1d to 2d, without having any exposure to 1d paradigm previously. Consider the 1d case `[1, 1, 0, 0, 1]`. Intuitively one may think the best meeting point would be the average of the `1` positions, but this is incorrect; `5/3` as a meeting point would have us travelling more distance than if we used `1` as the meeting point. We need the median!
- This is an interesting property of median - given some points in a single dimension, the location which minimizes the total distance to travel to each point from that location is the median. Another way of thinking about this is to try and obtain an equal amount of points on either side of the location such that the distances of the points to the left offset those of the points to the right. Consider the case `[1, 0, 0, 0, 1]`, with min total distance `4`. 
- With this information in mind, we can expand to the 2d case, since in the 2d case we consider distances of points above and below a location in addition to distances of points to the left and to the right. We need to be careful about how we collect points in the x-dimension and the y-dimension because we need these points to be in sorted order.