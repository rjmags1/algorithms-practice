# 286. Walls and Gates - Medium

You are given an `m x n` grid `rooms` initialized with these three possible values.

- `-1` A wall or an obstacle.
- `0` A gate.
- `INF` Infinity means an empty room. We use the value <code>2<sup>31</sup> - 1 = 2147483647</code> to represent `INF` as you may assume that the distance to a gate is less than `2147483647`.

Fill each empty room with the distance to its nearest gate. If it is impossible to reach a gate, it should be filled with `INF`.

##### Example 1:

```
Input: rooms = [[2147483647,-1,0,2147483647],[2147483647,2147483647,2147483647,-1],[2147483647,-1,2147483647,-1],[0,-1,2147483647,2147483647]]
Output: [[3,-1,0,1],[2,2,1,-1],[1,-1,2,-1],[0,-1,3,4]]
```

##### Example 2:

```
Input: rooms = [[-1]]
Output: [[-1]]
```

##### Constraints:

- `m == rooms.length`
- `n == rooms[i].length`
- `1 <= m, n <= 250`
- `rooms[i][j]` is `-1`, `0`, or <code>2<sup>31</sup> - 1</code>.

## Solution

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def wallsAndGates(self, rooms: List[List[int]]) -> None:
        """
        Do not return anything, modify rooms in-place instead.
        """
        m, n = len(rooms), len(rooms[0])
        diffs = ((-1, 0), (1, 0), (0, -1), (0, 1))
        inbounds = lambda i, j: 0 <= i < m and 0 <= j < n
        def markclosest(gate):
            seen = set()
            q = deque([(gate, 0)])
            while q:
                cell, dist = q.popleft()
                i, j = cell
                if cell in seen:
                    continue
                seen.add(cell)
                rooms[i][j] = dist
                
                for di, dj in diffs:
                    i2, j2 = i + di, j + dj
                    if not inbounds(i2, j2) or (i2, j2) in seen:
                        continue
                    if rooms[i2][j2] == -1 or rooms[i2][j2] == 0:
                        continue
                    if rooms[i2][j2] <= dist + 1:
                        continue
                    q.append(((i2, j2), dist + 1))
        
        for i in range(m):
            for j in range(n):
                if rooms[i][j] == 0:
                    markclosest((i, j))
```

## Notes
- This solution is similar to the optimal one where we call bfs once with a queue of all gate positions. This is because this solution stops does not nodes to the bfs queue when it is evident there is another gate closer to that node. The performance is similar because the first time we call bfs in this solution, we will visit all empty rooms. The next time bfs is called with a different gate, we will visit less empty rooms, because this second gate can't be closer to all empty rooms than the first. With each call to bfs, less and less nodes are visited, and it appears based on runtime percentile of this solution that there is a constant factor to the number of full grid traversals for most ratios of gates to empty rooms.
- Of course, it is better to just call bfs once with the queue init to contain all gates. With this approach, all empty rooms will be visited exactly once with minimal steps from the gate closest to it.