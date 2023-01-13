# 498. Diagonal Traverse - Medium

Given an `m x n` matrix `mat`, return an array of all the elements of the array in a diagonal order.

##### Example 1:

```
Input: mat = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,2,4,7,5,3,6,8,9]
```

##### Example 2:

```
Input: mat = [[1,2],[3,4]]
Output: [1,2,3,4]
```

##### Constraints:

- `m == mat.length`
- `n == mat[i].length`
- <code>1 <= m, n <= 10<sup>4</sup></code>
- <code>1 <= m * n <= 10<sup>4</sup></code>
- <code>-10<sup>5</sup> <= mat[i][j] <= 10<sup>5</sup></code>

## Solution

```
# Time: O(mn)
# Space: O(min(m, n))
class Solution:
    def collectupleft(self, i, j, mat, m, n):
        result = []
        while i >= 0 and j < n:
            result.append(mat[i][j])
            i -= 1
            j += 1
        return result

    def findDiagonalOrder(self, mat: List[List[int]]) -> List[int]:
        m, n, result = len(mat), len(mat[0]), []
        for i in range(m):
            diag = self.collectupleft(i, 0, mat, m, n)
            result.extend(diag[::-1] if i & 1 else diag)
        for j in range(1, n):
            diag = self.collectupleft(m - 1, j, mat, m, n)
            if m & 1:
                result.extend(diag[::-1] if j & 1 else diag)
            else:
                result.extend(diag if j & 1 else diag[::-1])

        return result
```

## Notes
- There are much more annoying to implement conceptual strategies for solving this problem that involve actually performing a diagonal traversal described by the prompt, but this is much simpler. Just collect all increasing slope diagonals and reverse every other one before adding the elements on the resulting diagonal to the result. It is trivial though less succinct to get rid of the auxiliary memory usage but could be done to achieve constant auxiliary space usage. 