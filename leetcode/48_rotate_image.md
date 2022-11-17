# 48. Rotate Image - Medium

You are given an `n x n` 2D `matrix` representing an image, rotate the image by 90 degrees (clockwise).

You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

##### Example 1:

```
Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [[7,4,1],[8,5,2],[9,6,3]]
```

##### Example 2:

```
Input: matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
Output: [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
```

##### Constraints:

- `n == matrix.length == matrix[i].length`
- `1 <= n <= 20`
- `-1000 <= matrix[i][j] <= 1000`

## Solution

```
Time: O(m) where m is num cells in matrix
Space: O(1)
class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        n = len(matrix)
        for layer in range(n // 2):
            topRowIdx = leftColIdx = layer
            bottomRowIdx = rightColIdx = n - layer - 1
            for i in range(n - (layer * 2) - 1):
                a = matrix[topRowIdx][leftColIdx + i]
                b = matrix[topRowIdx + i][rightColIdx]
                c = matrix[bottomRowIdx][rightColIdx - i]
                d = matrix[bottomRowIdx - i][leftColIdx]
                matrix[topRowIdx][leftColIdx + i] = d
                matrix[topRowIdx + i][rightColIdx] = a
                matrix[bottomRowIdx][rightColIdx - i] = b
                matrix[bottomRowIdx - i][leftColIdx] = c
```

## Notes
- 2D matrix traversal problems like these are incredibly annoying. However, they are still fair game for interviews at certain companies. 
- In this approach we traverse layer by layer and swap the correct values. The number of layers in an `n x n` matrix is always `n // 2`, and the size of the box with a particular layer as its border is always equal to `n - (layer * 2) - 1`, if layers are numbered `0 to n // 2 - 1` from outside in.

# Solution 2

```
# Time: O(m) where m is num cells in matrix
# Space: O(1)
class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        n = len(matrix)
        for i in range(n):
            for j in range(i + 1, n):
                matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
                
        for row in matrix:
            row.reverse()
```

## Notes
- This approach flips the matrix along its largest down-sloping diagonal (transposition) and then flips its rows (translation). There are a variety of other analagous solutions involving matrix transposition and translation.