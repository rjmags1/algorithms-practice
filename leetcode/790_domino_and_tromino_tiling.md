# 790. Domino and Tromino Tiling - Medium

You have two types of tiles: a `2 x 1` domino shape and a tromino shape. You may rotate these shapes.

![](../assets/790-domino.jpg)

Given an integer `n`, return the number of ways to tile an `2 x n` board. Since the answer may be very large, return it modulo <code>10<sup>9</sup> + 7</code>.

In a tiling, every square must be covered by a tile. Two tilings are different if and only if there are two 4-directionally adjacent cells on the board such that exactly one of the tilings has both squares occupied by a tile.

##### Example 1:

![](../assets/790-lc-domino1.jpg)

```
Input: n = 3
Output: 5
Explanation: The five different ways are show above.
```

##### Example 2:

```
Input: n = 1
Output: 1
```

##### Constraints:

- `1 <= n <= 1000`

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def numTilings(self, n: int) -> int:
        if n < 3:
            return n
        f = [0] * (n + 1)
        p = [0] * (n + 1)
        f[1], f[2], p[2] = 1, 2, 1
        M = 10 ** 9 + 7
        for k in range(3, n + 1):
            f[k] = f[k - 1] + f[k - 2] + 2 * p[k - 1]
            p[k] = f[k - 2] + p[k - 1]
            f[k] %= M
            p[k] %= M
        return f[-1]
```

## Notes
- Pretty tricky for a medium, takes a little bit to correctly enumerate base cases and figure out how solutions build on each other. We are interested in determining how many ways we can fully cover the board, which is complicated by the tromino shape, which requires pairs of pieces for full coverage. We don't want to try to enumerate all possible configurations because we would need to consider up to `1000` rows with `2` possible shapes, each of which can have `2` possible orientations, yielding on the order of 4^1000 possible configurations. The need for mod to keep the answer small indicates enumeration is not the way to go, and so dp is the correct approach. 
- The recurrence relation comes from the idea of building larger partial (`p`) (i.e., a half covered last row) or fully (`f`) covered boards from smaller ones. For fully covered boards, we can add a domino vertically to expand from a full board one row smaller, add two dominos horizontally to expand from a full board two rows smaller, or add a tromino to a partially covered board with either the top or bottom cell uncovered. To expand partially covered boards, we can add a horizontal domino to a previously partially covered board or a tromino to a previously fully covered board. This recurrence relation is challenging because it is easy to accidentally leave out or double-count certain configurations with incorrect equations.