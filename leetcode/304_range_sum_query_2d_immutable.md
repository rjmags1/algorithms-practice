# 304. Range Sum Query 2D - Immutable - Medium

Given a 2D matrix `matrix`, handle multiple queries of the following type:

- Calculate the sum of the elements of `matrix` inside the rectangle defined by its upper left corner `(row1, col1)` and lower right corner `(row2, col2)`.

Implement the `NumMatrix` class:

- `NumMatrix(int[][] matrix)` Initializes the object with the integer matrix `matrix`.
- `int sumRegion(int row1, int col1, int row2, int col2)` Returns the sum of the elements of matrix inside the rectangle defined by its upper left corner `(row1, col1)` and lower right corner `(row2, col2)`.

You must design an algorithm where `sumRegion` works on `O(1)` time complexity.

##### Example 1:

![](../assets/304-grid.jpg)

```
Input
["NumMatrix", "sumRegion", "sumRegion", "sumRegion"]
[[[[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]]], [2, 1, 4, 3], [1, 1, 2, 2], [1, 2, 2, 4]]
Output
[null, 8, 11, 12]

Explanation
NumMatrix numMatrix = new NumMatrix([[3, 0, 1, 4, 2], [5, 6, 3, 2, 1], [1, 2, 0, 1, 5], [4, 1, 0, 1, 7], [1, 0, 3, 0, 5]]);
numMatrix.sumRegion(2, 1, 4, 3); // return 8 (i.e sum of the red rectangle)
numMatrix.sumRegion(1, 1, 2, 2); // return 11 (i.e sum of the green rectangle)
numMatrix.sumRegion(1, 2, 2, 4); // return 12 (i.e sum of the blue rectangle)
```

##### Constraints:

- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 200`
- `0 <= row1 <= row2 < m`
- `0 <= col1 <= col2 < n`
- <code>-10<sup>4</sup> <= matrix[i][j] <= 10<sup>4</sup></code>
- At most <code>10<sup>4</sup></code> calls will be made to `sumRegion`.

## Solution

```
# Time: O(mn) init, O(1) query
# Space: O(1) overall
class NumMatrix:
    def __init__(self, matrix: List[List[int]]):
        m, n = len(matrix), len(matrix[0])
        self.sums = [[0] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                top = 0 if i == 0 else self.sums[i - 1][j]
                left = 0 if j == 0 else self.sums[i][j - 1]
                topleft = 0 if i == 0 or j == 0 else self.sums[i - 1][j - 1]
                self.sums[i][j] = matrix[i][j] + top + left - topleft

    def sumRegion(self, row1: int, col1: int, row2: int, col2: int) -> int:
        top = 0 if row1 == 0 else self.sums[row1 - 1][col2]
        left = 0 if col1 == 0 else self.sums[row2][col1 - 1]
        topleft = 0 if row1 == 0 or col1 == 0 else self.sums[row1 - 1][col1 - 1]
        return self.sums[row2][col2] - top - left + topleft
```

## Notes
- Prefix/partial sums expanding to 2d case.