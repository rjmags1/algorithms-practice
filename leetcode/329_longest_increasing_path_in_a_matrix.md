# 329. Longest Increasing Path in a Matrix - Hard

Given an `m x n` integers `matrix`, return the length of the longest increasing path in `matrix`.

From each cell, you can either move in four directions: left, right, up, or down. You may not move diagonally or move outside the boundary (i.e., wrap-around is not allowed).

##### Example 1:

```
Input: matrix = [[9,9,4],[6,6,8],[2,1,1]]
Output: 4
Explanation: The longest increasing path is [1, 2, 6, 9].
```

##### Example 2:

```
Input: matrix = [[3,4,5],[3,2,6],[2,2,1]]
Output: 4
Explanation: The longest increasing path is [3, 4, 5, 6]. Moving diagonally is not allowed.
```

##### Example 3:

```
Input: matrix = [[1]]
Output: 1
```

##### Constraints:

- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 200`
- <code>0 <= matrix[i][j] <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def longestIncreasingPath(self, matrix: List[List[int]]) -> int:
        m, n = len(matrix), len(matrix[0])
        dp = [[0] * n for _ in range(m)]
        diffs = ((0, 1), (0, -1), (1, 0), (-1, 0))
        inbounds = lambda i, j: 0 <= i < m and 0 <= j < n
        bigresult = 1
        def dfs(i, j):
            result = 1
            for di, dj in diffs:
                i2, j2 = i + di, j + dj
                if not inbounds(i2, j2) or matrix[i2][j2] <= matrix[i][j]:
                    continue
                if dp[i2][j2] == 0:
                    dfs(i2, j2)
                result = max(result, 1 + dp[i2][j2])
                
            nonlocal bigresult
            bigresult = max(result, bigresult)
            dp[i][j] = result
        
        for i in range(m):
            for j in range(n):
                if dp[i][j] == 0:
                    dfs(i, j)
        return bigresult
```

## Notes
- We can model the matrix as a graph where horizontally and vertically adjacent cells are neighbors in the graph; however, we do not actually need to translate the matrix into a graph, we can just perform dfs on the matrix as though it were a graph. We cache the results of dfs calls on individual cells with a dp array, and nonzero dp cell values indicate the dfs paths for that cell have already been exhaustively searched. 
- Also note how there is no need to track nodes in the current dfs path with a set or by some other mechanism; this is because the strictly increasing path constraint already handles this case for us automatically.