# 361. Bomb Enemy - Medium

Given an `m x n` matrix `grid` where each cell is either a wall `'W'`, an enemy `'E'` or empty `'0'`, return the maximum enemies you can kill using one bomb. You can only place the bomb in an empty cell.

The bomb kills all the enemies in the same row and column from the planted point until it hits the wall since it is too strong to be destroyed.

##### Example 1:

![](../assets/361-grid1.jpg)

```
Input: grid = [["0","E","0","0"],["E","0","W","E"],["0","E","0","0"]]
Output: 3
```

##### Example 2:

![](../assets/361-grid2.jpg)

```
Input: grid = [["W","W","W"],["0","0","0"],["E","E","E"]]
Output: 1
```

##### Constraints:

- `m == grid.length`
- `n == grid[i].length`
- `1 <= m, n <= 500`
- `grid[i][j]` is either `'W'`, `'E'`, or `'0'`.

## Solution

```
# Time: O(mn * (m + n))
# Space: O(1)
class Solution:
    def mark(self, grid, i, j, m, n):
        for k in range(i - 1, -1, -1):
            if grid[k][j] == 'W':
                break
            if grid[k][j] == '0':
                grid[k][j] = 1
            elif type(grid[k][j]) == int:
                grid[k][j] += 1
        for k in range(i + 1, m):
            if grid[k][j] == 'W':
                break
            if grid[k][j] == '0':
                grid[k][j] = 1
            elif type(grid[k][j]) == int:
                grid[k][j] += 1
        for k in range(j - 1, -1, -1):
            if grid[i][k] == 'W':
                break
            if grid[i][k] == '0':
                grid[i][k] = 1
            elif type(grid[i][k]) == int:
                grid[i][k] += 1
        for k in range(j + 1, n):
            if grid[i][k] == 'W':
                break
            if grid[i][k] == '0':
                grid[i][k] = 1
            elif type(grid[i][k]) == int:
                grid[i][k] += 1

    def maxKilledEnemies(self, grid: List[List[str]]) -> int:
        m, n = len(grid), len(grid[0])
        for i in range(m):
            for j, cell in enumerate(grid[i]):
                if cell == 'E':
                    self.mark(grid, i, j, m, n)
        result = 0
        for i in range(m):
            for j, hits in enumerate(grid[i]):
                if type(hits) == int:
                    grid[i][j] = '0'
                    result = max(result, hits)
        return result
```

## Notes
- Assuming there are more empty cells than enemies in most cases (seems to be the situation for LC test cases), it is more efficient to expand from enemies than from empties. Please forgive ugly code, could have done the `mark` method much more succinctly.