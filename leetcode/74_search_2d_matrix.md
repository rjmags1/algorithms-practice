# 74. Search a 2D Matrix - Medium

Write an efficient algorithm that searches for a value `target` in an `m x n` integer matrix `matrix`. This matrix has the following properties:

- Integers in each row are sorted from left to right.
- The first integer of each row is greater than the last integer of the previous row.


##### Example 1:

```
Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
Output: true
```

##### Example 2:

```
Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
Output: false
```

##### Constraints:


- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 100`
- <code>-10<sup>4</sup> <= matrix[i][j], target <= 10<sup>4</sup></code>


## Solution 1

```
# Time: O(m + n)
# Space: O(1)
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        m, n = len(matrix), len(matrix[0])
        i = 0
        while i < m - 1:
            if matrix[i + 1][0] > target:
                break
            i += 1
        
        j = 0
        while j < n:
            if matrix[i][j] == target:
                return True
            j += 1
        return False
```

## Notes
- Very straightforward. The row before the first one that has first elem greater than target iterating `i..m - 1` must contain `target`, if it is present in the matrix at all.

# Solution 2

```
# Time: O(log(mn))
# Space: O(1)
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        m, n = len(matrix), len(matrix[0])
        l, r = 0, m * n - 1
        while l <= r:
            mid = (l + r) // 2
            i, j = mid // n, mid % n
            if matrix[i][j] == target:
                return True
            if target < matrix[i][j]:
                r = mid - 1
            else:
                l = mid + 1
        return False
```

## Notes
- This is much more efficient than the linear algorithm `O(m + n)` algorithm for large inputs.
- Note how the row index is calculated by flooring by `n`, not `m`.