# 499. The Maze III - Hard

There is a ball in a `maze` with empty spaces (represented as `0`) and walls (represented as `1`). The ball can go through the empty spaces by rolling up, down, left or right, but it won't stop rolling until hitting a wall. When the ball stops, it could choose the next direction. There is also a hole in this maze. The ball will drop into the hole if it rolls onto the hole.

Given the `m x n` `maze`, the ball's position `ball` and the hole's position `hole`, where `ball = [ballrow, ballcol]` and `hole = [holerow, holecol]`, return a string `instructions` of all the instructions that the ball should follow to drop in the hole with the shortest distance possible. If there are multiple valid instructions, return the lexicographically minimum one. If the ball can't drop in the hole, return `"impossible"`.

If there is a way for the ball to drop in the hole, the answer `instructions` should contain the characters `'u'` (i.e., up), `'d'` (i.e., down), `'l'` (i.e., left), and `'r'` (i.e., right).

The distance is the number of empty spaces traveled by the ball from the start position (excluded) to the destination (included).

You may assume that the borders of the maze are all walls (see examples).

##### Example 1:

```
Input: maze = [[0,0,0,0,0],[1,1,0,0,1],[0,0,0,0,0],[0,1,0,0,1],[0,1,0,0,0]], ball = [4,3], hole = [0,1]
Output: "lul"
Explanation: There are two shortest ways for the ball to drop into the hole.
The first way is left -> up -> left, represented by "lul".
The second way is up -> left, represented by 'ul'.
Both ways have shortest distance 6, but the first way is lexicographically smaller because 'l' < 'u'. So the output is "lul".
```

##### Example 2:

```
Input: maze = [[0,0,0,0,0],[1,1,0,0,1],[0,0,0,0,0],[0,1,0,0,1],[0,1,0,0,0]], ball = [4,3], hole = [3,0]
Output: "impossible"
Explanation: The ball cannot reach the hole.
```

##### Example 3:

```
Input: maze = [[0,0,0,0,0,0,0],[0,0,1,0,0,1,0],[0,0,0,0,1,0,0],[0,0,0,0,0,0,1]], ball = [0,4], hole = [3,5]
Output: "dldr"
```

##### Constraints:

- `m == maze.length`
- `n == maze[i].length`
- `1 <= m, n <= 100`
- `maze[i][j] is 0 or 1.`
- `ball.length == 2`
- `hole.length == 2`
- `0 <= ballrow, holerow <= m`
- `0 <= ballcol, holecol <= n`
- Both the ball and the hole exist in an empty space, and they will not be in the same position initially.
- The maze contains at least 2 empty spaces.

## Solution

```
import heapq

# Time: O(mn * max(m, n) * log(mn))
# Space: O(mn)
class Solution:
    def findShortestWay(self, maze: List[List[int]], ball: List[int], hole: List[int]) -> str:
        m, n = len(maze), len(maze[0])
        def roll(i, j, diff):
            di, dj = diff
            while 0 <= i < m and 0 <= j < n and maze[i][j] == 0:
                if i == hole[0] and j == hole[1]:
                    return (i, j)
                i += di
                j += dj
            return (i - di, j - dj)

        h, seen = [(0, "", ball[0], ball[1])], set()
        dirs = tuple(zip("dlru", ((1, 0), (0, -1), (0, 1), (-1, 0))))
        while h:
            dist, inst, i, j = heapq.heappop(h)
            if (i, j) in seen:
                continue
            seen.add((i, j))
            if i == hole[0] and j == hole[1]:
                return inst

            for d, diff in dirs:
                y, x = roll(i, j, diff)
                if (y, x) not in seen:
                    heapq.heappush(h, (dist + abs(y - i) + abs(x - j), inst + d, y, x))

        return "impossible"
```

## Notes
- Dijkstra algorithm/BFS with heap to always know the previous step with the minimum associated distance. Note how we satisfy the lexicographical order constraint by tie breaking heap comparisons that have equal distance using step sequences.