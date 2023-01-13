# 463. Island Perimeter - Easy

You are given `row x col` `grid` representing a map where `grid[i][j] = 1` represents land and `grid[i][j] = 0` represents water.

Grid cells are connected horizontally/vertically (not diagonally). The `grid` is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells).

The island doesn't have "lakes", meaning the water inside isn't connected to the water around the island. One cell is a square with side length 1. The grid is rectangular, width and height don't exceed 100. Determine the perimeter of the island.

##### Example 1:

![](../assets/463_island.png)

```
Input: grid = [[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]
Output: 16
Explanation: The perimeter is the 16 yellow stripes in the image above.
```

##### Example 2:

```
Input: grid = [[1]]
Output: 4
```

##### Example 3:

```
Input: grid = [[1,0]]
Output: 4
```

##### Constraints:


- `row == grid.length`
- `col == grid[i].length`
- `1 <= row, col <= 100`
- `grid[i][j] is 0 or 1.`
- There is exactly one island in `grid`.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def islandPerimeter(self, grid: List[List[int]]) -> int:
        m, n = len(grid), len(grid[0])
        t = lambda i, j: int(i > 0 and grid[i - 1][j])
        b = lambda i, j: int(i < m - 1 and grid[i + 1][j])
        l = lambda i, j: int(j > 0 and grid[i][j - 1])
        r = lambda i, j: int(j < n - 1 and grid[i][j + 1])
        p = lambda i, j: 0 if not grid[i][j] else 4 - (t(i, j) + b(i, j) + l(i, j) + r(i, j))
        return sum(p(i, j) for i in range(m) for j in range(n))
```

## Notes
- For each land cell, count the number of sides that are not touching other land. Would be a little more complicated if lakes were allowed in the input, would need to tabulate length perimeter and subtract from the total calculated using aforementioned approach.