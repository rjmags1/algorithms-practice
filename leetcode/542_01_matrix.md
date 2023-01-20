# 542. 01 Matrix - Medium

Given an `m x n` binary matrix `mat`, return the distance of the nearest `0` for each cell.

The distance between two adjacent cells is `1`.

##### Example 1:

```
Input: mat = [[0,0,0],[0,1,0],[0,0,0]]
Output: [[0,0,0],[0,1,0],[0,0,0]]
```

##### Example 2:

```
Input: mat = [[0,0,0],[0,1,0],[1,1,1]]
Output: [[0,0,0],[0,1,0],[1,2,1]]
```

##### Constraints:

- `m == mat.length`
- `n == mat[i].length`
- <code>1 <= m, n <= 10<sup>4</sup></code>
- <code>1 <= m * n <= 10<sup>4</sup></code>
- `mat[i][j]` is either `0` or `1`.
- There is at least one `0` in `mat`.

## Solution 1

```
from collections import deque

# Time: O(mn)
# Space: O(mn)
class Solution:
    def updateMatrix(self, mat: List[List[int]]) -> List[List[int]]:
        m, n = len(mat), len(mat[0])
        result = [[-1] * n for _ in range(m)]
        diffs = ((0, -1), (0, 1), (-1, 0), (1, 0))
        inbounds = lambda i, j: 0 <= i < m and 0 <= j < n
        q = deque([(i, j, 0) for i in range(m) for j in range(n) if mat[i][j] == 0])
        seen = set()
        while q:
            i, j, dist = q.popleft()
            if (i, j) in seen:
                continue

            seen.add((i, j))
            result[i][j] = dist
            for di, dj in diffs:
                i2, j2 = i + di, j + dj
                if inbounds(i2, j2) and mat[i2][j2] == 1 and mat[i2][j2] not in seen:
                    q.append((i2, j2, dist + 1))
        return result
```

## Notes
- BFS with queue init to all zero positions.

## Solution 2

```
# Time: O(mn)
# Space: O(1)
class Solution:
    def updateMatrix(self, mat: List[List[int]]) -> List[List[int]]:
        m, n = len(mat), len(mat[0])
        result = [[math.inf] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                if mat[i][j] == 0:
                    result[i][j] = 0
                else:
                    if i > 0:
                        result[i][j] = min(result[i][j], 1 + result[i - 1][j])
                    if j > 0:
                        result[i][j] = min(result[i][j], 1 + result[i][j - 1])
        for i in reversed(range(m)):
            for j in reversed(range(n)):
                if i < m - 1:
                    result[i][j] = min(result[i][j], 1 + result[i + 1][j])
                if j < n - 1:
                    result[i][j] = min(result[i][j], 1 + result[i][j + 1])
        return result
```

## Notes
- DP; for any cell with a `1`, the distance from a `0` is equivalent to the distance from a zero cell of any of its neighbors (top, left, bottom, right) plus `1`. We do two traversals because it is impossible to know the subproblem results for all neighbors of a given cell in one pass if we are doing plain matrix traversal.