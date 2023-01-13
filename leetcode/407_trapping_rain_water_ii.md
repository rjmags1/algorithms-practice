# 407. Trapping Rain Water II - Hard

Given an `m x n` integer matrix `heightMap` representing the height of each unit cell in a 2D elevation map, return the volume of water it can trap after raining.

##### Example 1:

```
Input: heightMap = [[1,4,3,1,3,2],[3,2,1,3,2,4],[2,3,3,2,3,1]]
Output: 4
Explanation: After the rain, water is trapped between the blocks.
We have two small ponds 1 and 3 units trapped.
The total volume of water trapped is 4.
```

##### Example 2:

```
Input: heightMap = [[3,3,3,3,3],[3,2,2,2,3],[3,2,1,2,3],[3,2,2,2,3],[3,3,3,3,3]]
Output: 10
```

##### Constraints:

- `m == heightMap.length`
- `n == heightMap[i].length`
- `1 <= m, n <= 200`
- <code>0 <= heightMap[i][j] <= 2 * 10<sup>4</sup></code>

## Solution

```
import heapq

# Time: O(clog(c)) where c == m * n
# Space: O(c)
class Solution:
    def trapRainWater(self, heightMap: List[List[int]]) -> int:
        m, n, h = len(heightMap), len(heightMap[0]), []
        for j in range(n):
            h.append((heightMap[0][j], 0, j))
            h.append((heightMap[m - 1][j], m - 1, j))
        for i in range(1, m - 1):
            h.append((heightMap[i][0], i, 0))
            h.append((heightMap[i][n - 1], i, n - 1))
        heapq.heapify(h)

        seen, result = set(), 0
        inbounds = lambda i, j: 0 <= i < m and 0 <= j < n
        diffs = ((-1, 0), (1, 0), (0, -1), (0, 1))
        while h:
            minbound, i, j = heapq.heappop(h)
            if (i, j) in seen:
                continue
            seen.add((i, j))
            result += max(0, minbound - heightMap[i][j])
            for di, dj in diffs:
                i2, j2 = i + di, j + dj
                if not inbounds(i2, j2) or (i2, j2) in seen:
                    continue
                heapq.heappush(h, (max(heightMap[i2][j2], minbound), i2, j2))
                
        return result
```

## Notes
- This is an interesting case of non-trivial extension of a problem from 1D to 2D. The key to understanding this problem is realizing that:
    1. no border cells will hold water
    2. the amount of water held in a cell is `max(0, min(neighborcellheights) - cellheight)`.
- If we always know the minimum neighbor for a given cell, we can calculate how much water the cell holds; this sounds like a heap use-case. If we initialize a minheap with all the border cell positions and each border cell height as a minimum height neighbor, we can consider cells one at a time such that the cell `x` we pop off the top of the heap is the smallest we have not yet considered, which allows us to add unseen neighbors to the heap in a way that we know for a fact that `x` is the smallest neighbor of its unseen neighbors and thus the determinant of the amount of water held by its unseen neighbors.