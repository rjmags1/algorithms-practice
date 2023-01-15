# 505. The Maze II - Medium

There is a ball in a `maze` with empty spaces (represented as `0`) and walls (represented as `1`). The ball can go through the empty spaces by rolling up, down, left or right, but it won't stop rolling until hitting a wall. When the ball stops, it could choose the next direction.

Given the `m x n` `maze`, the ball's `start` position and the `destination`, where `start = [startrow, startcol]` and `destination = [destinationrow, destinationcol]`, return the shortest distance for the ball to stop at the destination. If the ball cannot stop at `destination`, return `-1`.

The distance is the number of empty spaces traveled by the ball from the start position (excluded) to the destination (included).

You may assume that the borders of the maze are all walls (see examples).

##### Example 1:

![](../assets/505-maze.jpg)

```
Input: maze = [[0,0,1,0,0],[0,0,0,0,0],[0,0,0,1,0],[1,1,0,1,1],[0,0,0,0,0]], start = [0,4], destination = [4,4]
Output: 12
Explanation: One possible way is : left -> down -> left -> down -> right -> down -> right.
The length of the path is 1 + 1 + 3 + 1 + 2 + 2 + 2 = 12.
```

##### Example 2:

```
Input: maze = [[0,0,1,0,0],[0,0,0,0,0],[0,0,0,1,0],[1,1,0,1,1],[0,0,0,0,0]], start = [0,4], destination = [3,2]
Output: -1
Explanation: There is no way for the ball to stop at the destination. Notice that you can pass through the destination but you cannot stop there.
```

##### Example 3:

```
Input: maze = [[0,0,0,0,0],[1,1,0,0,1],[0,0,0,0,0],[0,1,0,0,1],[0,1,0,0,0]], start = [4,3], destination = [0,1]
Output: -1
```

##### Constraints:

- `m == maze.length`
- `n == maze[i].length`
- `1 <= m, n <= 100`
- `start.length == 2`
- `destination.length == 2`
- `0 <= startrow, destinationrow < m`
- `0 <= startcol, destinationcol < n`
- `maze[i][j]` is `0` or `1`.
- Both the ball and the destination exist in an empty space, and they will not be in the same position initially.
- The maze contains at least 2 empty spaces.

## Solution

```
import heapq

# Time: O(mn * max(m, n, log(mn)))
# Space: O(mn)
class Solution:
    def shortestDistance(self, maze: List[List[int]], start: List[int], destination: List[int]) -> int:
        m, n = len(maze), len(maze[0])
        diffs = ((0, -1), (0, 1), (-1, 0), (1, 0))
        def roll(i, j, dir):
            di, dj = dir
            while 0 <= i < m and 0 <= j < n:
                if maze[i][j] == 1:
                    break
                i, j = i + di, j + dj
            return i - di, j - dj
            
        q, seen = [(0, start[0], start[1])], set()
        while q:
            dist, i, j = heapq.heappop(q)
            if (i, j) in seen:
                continue
            seen.add((i, j))
            if i == destination[0] and j == destination[1]:
                return dist

            for dir in diffs:
                newi, newj = roll(i, j, dir)
                newdist = abs(newi - i) + abs(newj - j)
                if (newi, newj) not in seen:
                    heapq.heappush(q, (dist + newdist, newi, newj))
                    
        return -1
```

## Notes
- Dijsktra's algorithm; we use a heap of unexplored positions whose comparator is the minimum distance to arrive at that location via rolling.