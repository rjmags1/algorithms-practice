# 576. Out of Boundary Paths - Medium

There is an `m x n` grid with a ball. The ball is initially at the position `[startRow, startColumn]`. You are allowed to move the ball to one of the four adjacent cells in the grid (possibly out of the grid crossing the grid boundary). You can apply at most `maxMove` moves to the ball.

Given the five integers `m`, `n`, `maxMove`, `startRow`, `startColumn`, return the number of paths to move the ball out of the grid boundary. Since the answer can be very large, return it modulo <code>10<sup>9</sup> + 7</code>.

##### Example 1:

![](../assets/576-1.png)

```
Input: m = 2, n = 2, maxMove = 2, startRow = 0, startColumn = 0
Output: 6
```

##### Example 2:

![](../assets/576-2.png)

```
Input: m = 1, n = 3, maxMove = 3, startRow = 0, startColumn = 1
Output: 12
```

##### Constraints:

- `1 <= m, n <= 50`
- `0 <= maxMove <= 50`
- `0 <= startRow < m`
- `0 <= startColumn < n`

## Solution

```
from functools import cache

# Time: O(mnk)
# Space: O(mnk)
class Solution:
    def findPaths(self, m: int, n: int, maxMove: int, startRow: int, startColumn: int) -> int:
        MOD = 10 ** 9 + 7
        diffs = ((0, -1), (0, 1), (-1, 0), (1, 0))
        oob = lambda i, j: i in (-1, m) or j in (-1, n)
        @cache
        def dp(i, j, k):
            if k == 0:
                return 0

            result = 0
            for di, dj in diffs:
                i2, j2 = i + di, j + dj
                result += 1 if oob(i2, j2) else dp(i2, j2, k - 1)
                result %= MOD
            return result
        
        return dp(startRow, startColumn, maxMove)
```

## Notes
- Top-down dynamic programming. For any space in the grid, we could reach the border with a range of `k` moves. If we are at a border cell we can reach out of bounds in at least `1` move, but we could also reach a border cell by spending more moves (if we have more than `1` move left) by initially traversing to one of the in bounds neighbors and eventually getting back to a border cell with `k = 1`. We can memoize on all possible `m * n * k` possibilities to give `O(50 * 50 * 50) ~ O(10^4)` time in the worst case.
- This could trivially be converted to 3D dynamic programming by iterating as follows: `for k in [1, n], for cell in grid...`.