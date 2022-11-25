# 240. Search a 2D Matrix - Medium

Write an efficient algorithm that searches for a value `target` in an `m x n` integer matrix `matrix`. This matrix has the following properties:

- Integers in each row are sorted in ascending from left to right.
- Integers in each column are sorted in ascending from top to bottom.


##### Example 1:

```
Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 5
Output: true
```

##### Example 2:

```
Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 20
Output: false
```

##### Constraints:

- <code>m == matrix.length</code>
- <code>n == matrix[i].length</code>
- <code>1 <= n, m <= 300</code>
- <code>-10<sup>9</sup> <= matrix[i][j] <= 10<sup>9</sup></code>
- All the integers in each row are sorted in ascending order.
- All the integers in each column are sorted in ascending order.
- <code>-10<sup>9</sup> <= target <= 10<sup>9</sup></code>

## Solution

```
# Time: O(m + n)
# Space: O(1)
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        m, n = len(matrix), len(matrix[0])
        i, j = 0, n - 1
        while i < m and j >= 0:
            curr = matrix[i][j]
            if curr == target:
                return True
            if curr < target:
                i += 1
            else:
                j -= 1
        
        return False
```

## Notes
- Notice how if we start from the top-right or bottom-left, we can eliminate an entire row or column respectively from the search space if the current number is less than the target; this is because rows are sorted in ascending order LTR and columns are sorted in ascending order top-down, and so starting in these positions allows us to examine the rows/ columns with the smallest numbers, then the next smallest numbers, etc. If the current number is greater than the target, we can't eliminate the row or column (respectively again) because the target may be in the current row or column, so we just advance deeper into that row or column until we either find the target, go outside the matrix, or encounter a number less than the current target.