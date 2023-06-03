# 1129. Shortest Path with Alternating Colors - Medium

You are given an integer `n`, the number of nodes in a directed graph where the nodes are labeled from `0` to `n - 1`. Each edge is red or blue in this graph, and there could be self-edges and parallel edges.

You are given two arrays redEdges and blueEdges where:

- `redEdges[i] = [ai, bi]` indicates that there is a directed red edge from node `ai` to node `bi` in the graph, and
- `blueEdges[j] = [uj, vj]` indicates that there is a directed blue edge from node `uj` to node `vj` in the graph.

Return an array answer of length `n`, where each `answer[x]` is the length of the shortest path from node `0` to node `x` such that the edge colors alternate along the path, or `-1` if such a path does not exist.

##### Example 1:

```
Input: n = 3, redEdges = [[0,1],[1,2]], blueEdges = []
Output: [0,1,-1]
```

##### Example 2:

```
Input: n = 3, redEdges = [[0,1]], blueEdges = [[2,1]]
Output: [0,1,-1]
```

##### Constraints:

- `1 <= n <= 100`
- `0 <= redEdges.length, blueEdges.length <= 400`
- `redEdges[i].length == blueEdges[j].length == 2`
- `0 <= ai, bi, uj, vj < n`

## Solution

```
from collections import defaultdict, deque

# Time: O(2 * n + e) -> O(n)
# Space: O(2 * n + e) -> O(n)
class Solution:
    RED, BLUE = 0, 1
    def shortestAlternatingPaths(self, n: int, redEdges: List[List[int]], blueEdges: List[List[int]]) -> List[int]:
        edges = defaultdict(list)
        for src, dest in redEdges:
            edges[src].append((dest, self.RED))
        for src, dest in blueEdges:
            edges[src].append((dest, self.BLUE))

        result = [-1] * n
        q = deque()
        # for each node we need to stop adding to queue when it has been 
        # visited from a red and blue edge
        visited = [[False for _ in range(2)] for _ in range(n)]
        q.append((0, 0, None))
        while q:
            node, steps, prevEdgeColor = q.popleft()
            if prevEdgeColor: 
                if visited[node][prevEdgeColor]:
                    continue
                visited[node][prevEdgeColor] = True
            if result[node] == -1:
                result[node] = steps
            for neighbor, edgeColor in edges[node]:
                if prevEdgeColor != edgeColor and not visited[neighbor][edgeColor]:
                    q.append((neighbor, steps + 1, edgeColor))
                    
        return result
```

## Notes
- This problem is a slight variation on a common BFS problem where the goal is to find the shortest path to each node from a particular node. Since we care about alternating edge color order, we need to keep track of whether a node has been previously visited from an edge of either color during BFS. Note how the typical BFS guarantee of shortest path length is applied here.