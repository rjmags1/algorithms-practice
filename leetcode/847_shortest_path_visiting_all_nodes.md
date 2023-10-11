# 847. Shortest Path Visiting All Nodes - Hard

You have an undirected, connected graph of `n` nodes labeled from `0` to `n - 1`. You are given an array `graph` where `graph[i]` is a list of all the nodes connected with node `i` by an edge.

Return the length of the shortest path that visits every node. You may start and stop at any node, you may revisit nodes multiple times, and you may reuse edges.

##### Example 1:

```
Input: graph = [[1,2,3],[0],[0],[0]]
Output: 4
Explanation: One possible path is [1,0,2,0,3]
```

##### Example 2:

```
Input: graph = [[1],[0,2,4],[1,3,4],[2],[1,2]]
Output: 4
Explanation: One possible path is [0,1,4,2,3]
```

##### Constraints:

- `n == graph.length`
- `1 <= n <= 12`
- `0 <= graph[i].length < n`
- `graph[i]` does not contain `i`.
- If `graph[a]` contains `b`, then `graph[b]` contains `a`.
- The input graph is always connected.

## Solution

```
# Time: O(n * 2^n * n)
# Space: O(n * 2^n)
class Solution:
    def shortestPathLength(self, graph: List[List[int]]) -> int:
        n = len(graph)
        if n == 1:
            return 0
        
        queue = [(i, 1 << i) for i in range(n)]
        seen = set()
        all_visited = (1 << n) - 1
        path_len = 0
        while queue:
            nxt = []
            for node, prev_mask in queue:
                for neighbor in graph[node]:
                    mask = prev_mask | (1 << neighbor)
                    state = (neighbor, mask)
                    if mask == all_visited:
                        return path_len + 1
                    if state in seen:
                        continue
                    seen.add(state)
                    nxt.append(state)

            queue = nxt
            path_len += 1
        
        return path_len
```

## Notes
- Based on the small input exploring all possible paths should be considered; we need a way to avoid solving redundant paths involving unnecessary duplicate traversals and infinite cycles. Well, for a given node the most we will want to traverse it is proportional to the number of subcomponents only reachable by that node. If we keep track of visited nodes when we are at a particular node we can avoid both cycles and redundant traversals. Since `n` is small we use bitmasks to track visited state with minimal space. This could be solved with DFS or BFS, but BFS is preferred because it is both non-recursive and exits upon finding the shortest path.