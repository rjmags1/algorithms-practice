# 427. Construct Quad Tree - Medium

Given a `n * n` matrix `grid` of `0`'s and `1`'s only. We want to represent the `grid` with a Quad-Tree.

Return the root of the Quad-Tree representing the `grid`.

Notice that you can assign the value of a node to `True` or `False` when `isLeaf` is False, and both are accepted in the answer.

##### Example 1:

```
Input: grid = [[0,1],[1,0]]
Output: [[0,1],[1,0],[1,1],[1,1],[1,0]]
Explanation: The explanation of this example is shown below:
Notice that 0 represnts False and 1 represents True in the photo representing the Quad-Tree.
```

##### Example 2:

```
Input: grid = [[1,1,1,1,0,0,0,0],[1,1,1,1,0,0,0,0],[1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1],[1,1,1,1,0,0,0,0],[1,1,1,1,0,0,0,0],[1,1,1,1,0,0,0,0],[1,1,1,1,0,0,0,0]]
Output: [[0,1],[1,1],[0,1],[1,1],[1,0],null,null,null,null,[1,0],[1,0],[1,1],[1,1]]
Explanation: All values in the grid are not the same. We divide the grid into four sub-grids.
The topLeft, bottomLeft and bottomRight each has the same value.
The topRight have different values so we divide it into 4 sub-grids where each has the same value.
```

##### Constraints:

- `n == grid.length == grid[i].length`
- `n == 2x where 0 <= x <= 6`

## Solution

```
"""
# Definition for a QuadTree node.
class Node:
    def __init__(self, val, isLeaf, topLeft, topRight, bottomLeft, bottomRight):
        self.val = val
        self.isLeaf = isLeaf
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
"""

# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def construct(self, grid: List[List[int]]) -> 'Node':
        n = len(grid)
        sums = [[0] * n for _ in range(n)]
        for i in range(n):
            for j in range(n):
                if i == 0:
                    sums[i][j] = grid[i][j] if j == 0 else grid[i][j] + sums[i][j - 1]
                elif j == 0:
                    sums[i][j] = grid[i][j] + sums[i - 1][j]
                else:
                    sums[i][j] = grid[i][j] + sums[i - 1][j] + sums[i][j - 1] - sums[i - 1][j - 1]
        
        def rec(i1, i2, j1, j2):
            left = sums[i2][j1 - 1] if j1 > 0 else 0
            above = sums[i1 - 1][j2] if i1 > 0 else 0
            aboveleft = sums[i1 - 1][j1 - 1] if i1 > 0 and j1 > 0 else 0
            s = sums[i2][j2] - above - left + aboveleft
            if s == 0:
                return Node(False, True, None, None, None, None)
            if s == (i2 - i1 + 1) * (j2 - j1 + 1):
                return Node(True, True, None, None, None, None)

            midi, midj = (i1 + i2) // 2, (j1 + j2) // 2
            topleft = rec(i1, midi, j1, midj)
            topright = rec(i1, midi, midj + 1, j2)
            bottomleft = rec(midi + 1, i2, j1, midj)
            bottomright = rec(midi + 1, i2, midj + 1, j2)
            return Node(None, False, topleft, topright, bottomleft, bottomright)
        
        return rec(0, n - 1, 0, n - 1)
```

## Notes
- Improve quad tree construction runtime by preprocessing 2d prefix sums of the input grid. This allows for constant time determination of whether a particular subgrid has all same values or not. Otherwise the runtime would be `O(log(n^2) * n^2)` where the log is base 4.