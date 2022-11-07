# 73. Set Matrix Zeroes - Medium

Given an `m x n` integer matrix matrix, if an element is `0`, set its entire row and column to `0`'s.

You must do it in place.

##### Example 1:

```
Input: matrix = [[1,1,1],[1,0,1],[1,1,1]]
Output: [[1,0,1],[0,0,0],[1,0,1]]
```

##### Example 2:

```
Input: matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]
```


- `m == matrix.length`
- `n == matrix[0].length`
- `1 <= m, n <= 200`
- <code>-2<sup>31</sup> <= matrix[i][j] <= 2<sup>31</sup> - 1</code>


## Solution

```
# Time: O(mn)
# Space: O(1)
class Solution:
    def setZeroes(self, matrix: List[List[int]]) -> None:
        """
        Do not return anything, modify matrix in-place instead.
        """
        m, n = len(matrix), len(matrix[0])
        leftCol = False
        for i in range(m):
            for j in range(n):
                if matrix[i][j] == 0:
                    if j == 0:
                        leftCol = True
                        matrix[i][0] = 0
                    else:
                        matrix[0][j] = matrix[i][0] = 0
        
        for i in range(1, m):
            for j in range(1, n):
                if (j == 0 and leftCol) or matrix[i][0] == 0 or matrix[0][j] == 0:
                    matrix[i][j] = 0
        if matrix[0][0] == 0:
            for j in range(1, n):
                matrix[0][j] = 0
        if leftCol:
            for i in range(m):
                matrix[i][0] = 0
```

## Notes
- Not a difficult problem, but definitely an annoying one. Need to be careful about handling zero-marking of the top row and left column. All columns and rows can use their first cell as the marker for if the entire row or column should be set to `0` or not, except for the top row and left column; `matrix[0][0]` could represent both. Simplest workaround for this is to use a boolean flag for one of them, and `matrix[0][0]` for the other. 
- Once the matrix is correctly marked, to use the newly marked first in row and column cells we need to be careful to avoid incorrectly setting all top row or left column cells to `0` prematurely.