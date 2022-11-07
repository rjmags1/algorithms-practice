# 59. Spiral Matrix - Medium

Given a positive integer `n`, generate an `n x n` matrix filled with elements from `1` to <code>n<sup>2</sup></code> in spiral order.

##### Example 1:

```
Input: n = 3
Output: [[1,2,3],[8,9,4],[7,6,5]]
```

##### Example 2:

```
Input: n = 1
Output: [[1]]
```

##### Constraints:

- `1 <= n <= 20` 

## Solution

```
# Time: O(n^2) (but linear)
# Space: O(n^2)
class Solution:
    def generateMatrix(self, n: int) -> List[List[int]]:
        matrix = [[None for _ in range(n)] for _ in range(n)]
        curr = 1
        topRow = leftCol = 0
        bottomRow = rightCol = n - 1
        while topRow < bottomRow:
            for i in range(leftCol, rightCol):
                matrix[topRow][i] = curr
                curr += 1
            for i in range(topRow, bottomRow):
                matrix[i][rightCol] = curr
                curr += 1
            for i in range(rightCol, leftCol, -1):
                matrix[bottomRow][i] = curr
                curr += 1
            for i in range(bottomRow, topRow, -1):
                matrix[i][leftCol] = curr
                curr += 1
            
            topRow += 1
            bottomRow -= 1
            leftCol += 1
            rightCol -= 1
        
        if (n * n) & 1:
            matrix[topRow][leftCol] = n * n
        
        return matrix
```

## Notes
- There are much more succinct solutions than this that take advantage of the result matrix having square dimensions, but this is very idiomatic IMO and easy to understand.
- Need to be careful to handle edge case where <code>n<sup>2</sup></code> is odd. In this case <code>n<sup>2</sup></code> will always need to be added to the center of the matrix manually after the main loop exits. This is analogous to the edge case in 56. Spiral Matrix where `m * n` is odd (where `m` and `n` are the dimensions of the input matrix for that problem), except in this case since we are dealing with square dimensions there will only ever be one more element to handle after exiting the main loop.