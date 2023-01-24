# 562. Longest Line of Consecutive One in Matrix - Medium

Given an `m x n` binary matrix `mat`, return the length of the longest line of consecutive one in the matrix.

The line could be horizontal, vertical, diagonal, or anti-diagonal.

##### Example 1:

```
Input: mat = [[0,1,1,0],[0,1,1,0],[0,0,0,1]]
Output: 3
```

##### Example 2:

```
Input: mat = [[1,1,1,1],[0,1,1,0],[0,0,0,1]]
Output: 4
```

##### Constraints:

- <code>m == mat.length</code>
- <code>n == mat[i].length</code>
- <code>1 <= m, n <= 10<sup>4</sup></code>
- <code>1 <= m * n <= 10<sup>4</sup></code>
- `mat[i][j]` is either `0` or `1`.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def longestLine(self, mat: List[List[int]]) -> int:
        m, n = len(mat), len(mat[0])
        def traverse(i, j, di, dj):
            result = curr = 0
            while 0 <= i < m and 0 <= j < n:
                if mat[i][j]:
                    curr += 1
                    result = max(result, curr)
                else:
                    curr = 0
                i += di
                j += dj
            return result

        result = 0
        for i in range(m):
            result = max(result, traverse(i, 0, 0, 1))
        for j in range(n):
            result = max(result, traverse(0, j, 1, 0))
        for i in range(m):
            result = max(result, traverse(i, 0, -1, 1))
            result = max(result, traverse(i, n - 1, -1, -1))
        for j in range(1, n):
            result = max(result, traverse(m - 1, j, -1, 1))
            result = max(result, traverse(m - 1, j, -1, -1))
        return result
```

## Notes
- Just traverse all possible line 'lanes', getting the longest line out of all lanes.