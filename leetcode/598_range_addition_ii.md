# 598. Range Addition II - Easy

You are given an `m x n` matrix `M` initialized with all `0`'s and an array of operations `ops`, where `ops[i] = [ai, bi]` means `M[x][y]` should be incremented by one for all `0 <= x < ai` and `0 <= y < bi`.

Count and return the number of maximum integers in the matrix after performing all the operations.

##### Example 1:

```
Input: m = 3, n = 3, ops = [[2,2],[3,3]]
Output: 4
Explanation: The maximum integer in M is 2, and there are four of it in M. So return 4.
```

##### Example 2:

```
Input: m = 3, n = 3, ops = [[2,2],[3,3],[3,3],[3,3],[2,2],[3,3],[3,3],[3,3],[2,2],[3,3],[3,3],[3,3]]
Output: 4
```

##### Example 3:

```
Input: m = 3, n = 3, ops = []
Output: 9
```

##### Constraints:

- <code>1 <= m, n <= 4 * 10<sup>4</sup></code>
- <code>0 <= ops.length <= 10<sup>4</sup></code>
- <code>ops[i].length == 2</code>
- <code>1 <= ai <= m</code>
- <code>1 <= bi <= n</code>

## Solution

```
# Time: O(ops)
# Space: O(1)
class Solution:
    def maxCount(self, m: int, n: int, ops: List[List[int]]) -> int:
        if not ops:
            return m * n
        rsize = min(op[0] for op in ops)
        csize = min(op[1] for op in ops)
        return rsize * csize
```

## Notes
- The key piece of information in this prompt is that `ops` specify sub-matrices whose upper left corner is the upper left corner of the original matrix. As a result, all max integers will be in the submatrix defined by the smallest row and column indices in `ops`.