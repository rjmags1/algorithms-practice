# 221. Maximal Square - Medium

Given an `m x n` binary matrix filled with `0`'s and `1`'s, find the largest square containing only `1`'s and return its area.

##### Example 1:

```
Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
Output: 4
```

##### Example 2:

```
Input: matrix = [["0","1"],["1","0"]]
Output: 1
```

##### Example 3:

```
Input: matrix = [["0"]]
Output: 0
```

##### Constraints:

- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 300`
- `matrix[i][j]` is `'0'` or `'1'`.

## Solution

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def maximalSquare(self, matrix: List[List[str]]) -> int:
        dp = [[int(c) for c in row] for row in matrix]
        m, n = len(matrix), len(matrix[0])
        maxdim = 0
        for j in range(n):
            if matrix[0][j] == "1":
                maxdim = 1
                break
        if maxdim == 0:
            for i in range(m):
                if matrix[i][0] == "1":
                    maxdim = 1
                    break
        for i in range(1, m):
            for j in range(1, n):
                if matrix[i][j] == "0":
                    dp[i][j] = 0
                else:
                    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]) + 1
                    maxdim = max(maxdim, dp[i][j])
                    
        return maxdim * maxdim
```

## Notes
- Fairly trivial dp question, just need to see that any `1` cell whose up, left, and upleft neighbors are all also `1` cells forms a square of at least area `4`. From there we can deduce that the square formed here has dimensions equal to the minimum of the dimensions of the squares formed by its up, left, and upleft neighbors, plus `1`.