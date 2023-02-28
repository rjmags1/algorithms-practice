# 554. Brick Wall - Medium

There is a rectangular brick wall in front of you with `n` rows of bricks. The `ith` row has some number of bricks each of the same height (i.e., one unit) but they can be of different widths. The total width of each row is the same.

Draw a vertical line from the top to the bottom and cross the least bricks. If your line goes through the edge of a brick, then the brick is not considered as crossed. You cannot draw a line just along one of the two vertical edges of the wall, in which case the line will obviously cross no bricks.

Given the 2D array `wall` that contains the information about the wall, return the minimum number of crossed bricks after drawing such a vertical line.

##### Example 1:

![](../assets/554-1.jpg)

```
Input: wall = [[1,2,2,1],[3,1,2],[1,3,2],[2,4],[3,1,2],[1,3,1,1]]
Output: 2
```

##### Example 2:

```
Input: wall = [[1],[1],[1]]
Output: 3
```

##### Constraints:

- `n == wall.length`
- `sum(wall[i])` is the same for each row `i`.
- <code>1 <= n <= 10<sup>4</sup></code>
- <code>1 <= wall[i].length <= 10<sup>4</sup></code>
- <code>1 <= sum(wall[i].length) <= 2 * 10<sup>4</sup></code>
- <code>1 <= wall[i][j] <= 2<sup>31</sup> - 1</code>

## Solution 1

```
import heapq

# Time: O(nklog(n)) where k is max len of wall[i]
# Space: O(n)
class Solution:
    def leastBricks(self, wall: List[List[int]]) -> int:
        q = [(w[0], i, 0) for i, w in enumerate(wall)]
        heapq.heapify(q)
        n = result = len(wall)
        while q and q[0][0] < sum(wall[0]):
            popped = heapq.heappop(q)
            sameedges = [popped]
            while q and q[0][0] == popped[0]:
                sameedges.append(heapq.heappop(q))
            result = min(result, n - len(sameedges))
            for l, i, j in sameedges:
                if j + 1 < len(wall[i]):
                    heapq.heappush(q, (l + wall[i][j + 1], i, j + 1))
        return result
```

## Notes
- Line sweep for common brick vertical edges, do not count start and stop of wall. Min heap of current brick edges for each row allows us to sweep LTR across the brick wall as if with a vertical line.

## Solution 2

```
from collections import defaultdict

# Time: O(nk)
# Space: O(nk)
class Solution:
    def leastBricks(self, wall: List[List[int]]) -> int:
        n = len(wall)
        sums, result = defaultdict(int), n
        for i in range(len(wall)):
            s, m = 0, len(wall[i])
            for j, l in enumerate(wall[i]):
                if j == m - 1:
                    break
                s += l
                sums[s] += 1
                result = min(result, n - sums[s])
        return result
```

## Notes
- We can do slightly better on time at the cost of more space if we use a hash table to store x-coordinates of stop edges for each brick. 