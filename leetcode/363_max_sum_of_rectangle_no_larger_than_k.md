# 363. Max Sum of Rectangle No Larger Than K - Hard

Given an `m x n` matrix `matrix` and an integer `k`, return the max sum of a rectangle in the matrix such that its sum is no larger than `k`.

It is guaranteed that there will be a rectangle with a sum no larger than `k`.

##### Example 1:

```
Input: matrix = [[1,0,1],[0,-2,3]], k = 2
Output: 2
Explanation: Because the sum of the blue rectangle [[0, 1], [-2, 3]] is 2, and 2 is the max number no larger than k (k = 2).
```

##### Example 2:

```
Input: matrix = [[2,2,-1]], k = 3
Output: 3
```

##### Constraints:

- `m == matrix.length`
- `n == matrix[i].length`
- `1 <= m, n <= 100`
- `-100 <= matrix[i][j] <= 100`
- <code>-10<sup>5</sup> <= k <= 10<sup>5</sup></code>

Follow-up: What if the number of rows is much larger than the number of columns?

## Solution

```
from math import inf

# Time: O(m^2 * n^2)
# Space: O(mn)
class Solution:
    def maxSumSubmatrix(self, matrix: List[List[int]], k: int) -> int:
        m, n = len(matrix), len(matrix[0])
        sums = [[0] * n for _ in range(m)]
        for i in range(m):
            for j, num in enumerate(matrix[i]):
                if i == 0:
                    sums[i][j] = num if j == 0 else num + sums[0][j - 1]
                elif j == 0:
                    sums[i][j] = num + sums[i - 1][0]
                else:
                    sums[i][j] = num + sums[i - 1][j] + sums[i][j - 1] - sums[i - 1][j - 1]

        result = -inf
        for i in range(m):
            full = sums[i][0]
            for t in range(i, -1, -1):
                top = 0 if t == 0 else sums[t - 1][0]
                if full - top <= k:
                    result = max(result, full - top)
        for j in range(n):
            full = sums[0][j]
            for l in range(j, -1, -1):
                left = 0 if l == 0 else sums[0][l - 1]
                if full - left <= k:
                    result = max(result, full - left)
        for i in range(1, m):
            for j in range(1, n):
                full = sums[i][j]
                for t in range(i, -1, -1):
                    above = 0 if t == 0 else sums[t - 1][j]
                    for l in range(j, -1, -1):
                        left = 0 if l == 0 else sums[i][l - 1]
                        readd = 0 if t == 0 or l == 0 else sums[t - 1][l - 1]
                        curr = full - above - left + readd
                        if curr <= k:
                            result = max(result, curr)

        return result
```

## Notes
- This used to pass but leetcode has increased runtime strictness to necessitate a non-brute force approach, which is what is shown above. In above we explore all possible subrectangles in `O(mn * mn)` time using the idea of 2d prefix sums. This is <code>O(10<sup>8</sup>)</code> operations which typically is OK for leetcode but maintainers have not allowed such runtime complexity for this question (at least for python solutions).
- One could improve upon the brute force approach by using a sorted container such as `SortedSet` in Java or AVL tree. There are non-standard implementations of these for python, however should be careful about using non-standard data structures in interviews. One could also use a basic BST but in some cases we would degenerate to `O(n)` for search if the tree is unbalanced. The idea is to keep a sorted container of previously seen 1d prefix sums and then use the idea of binary search on the sorted container for the largest seen prefix sum `>= currprefixsum - k`. We convert the 2d problem to 1d by considering all rectangles of height 1, then all rectangles of height 2, and so forth. This would result in `O(x^2 * ylog(y)) where x = min(m, n) and y = max(m, n)` if optimized correctly to take into account large rows vs large cols.