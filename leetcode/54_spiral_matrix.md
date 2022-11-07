# 54. Spiral Matrix - Medium

Given an `m x n` matrix, return all elements of the matrix in spiral order.

##### Example 1:

```
Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,2,3,6,9,8,7,4,5]
```

##### Example 2:

```
Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
Output: [1,2,3,4,8,12,11,10,9,5,6,7]
```

##### Constraints:

- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 10`
- `-100 <= matrix[i][j] <= 100`

## Solution

```
# Time: O(mn) (but linear)
# Space: O(1)
class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        m, n = len(matrix), len(matrix[0])
        rowstart, rowend = 0, m - 1
        colstart, colend = 0, n - 1
        result = []
        while rowstart < rowend and colstart < colend:
            for i in range(colstart, colend):
                result.append(matrix[rowstart][i])
            for i in range(rowstart, rowend):
                result.append(matrix[i][colend])
            for i in range(colend, colstart, -1):
                result.append(matrix[rowend][i])
            for i in range(rowend, rowstart, -1):
                result.append(matrix[i][colstart])
            
            rowstart += 1
            rowend -= 1
            colstart += 1
            colend -= 1
        
        if rowstart == rowend:
            for i in range(colstart, colend + 1):
                result.append(matrix[rowstart][i])
        elif colstart == colend:
            for i in range(rowstart, rowend + 1):
                result.append(matrix[i][colstart])
        
        return result
```

## Notes
- Pretty straightforward, just need to look out for edge cases where we exit the main loop and there are still elements to collect into our result. This only happens when there is an odd number of rows and/or columns.