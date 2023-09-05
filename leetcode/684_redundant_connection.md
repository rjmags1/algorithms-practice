# 684. Redundant Connection - Medium

In this problem, a tree is an undirected graph that is connected and has no cycles.

You are given a graph that started as a tree with `n` nodes labeled from `1` to `n`, with one additional edge added. The added edge has two different vertices chosen from `1` to `n`, and was not an edge that already existed. The graph is represented as an array `edges` of length `n` where `edges[i] = [ai, bi]` indicates that there is an edge between nodes `ai` and `bi` in the graph.

Return an edge that can be removed so that the resulting graph is a tree of `n` nodes. If there are multiple answers, return the answer that occurs last in the input.

##### Example 1:

```
Input: edges = [[1,2],[1,3],[2,3]]
Output: [2,3]
```

##### Example 2:

```
Input: edges = [[1,2],[2,3],[3,4],[1,4],[1,5]]
Output: [1,4]
```

##### Constraints:

- `n == edges.length`
- `3 <= n <= 1000`
- `edges[i].length == 2`
- `1 <= ai < bi <= edges.length`
- `ai != bi`
- There are no repeated edges.
- The given graph is connected.

## Solution

```
from collections import defaultdict

# Time: O(v + e)
# Space: O(v + e)
class Solution:
    def findRedundantConnection(self, edges: List[List[int]]) -> List[int]:
        # dfs from any start to find node in cycle
        # dfs from node in cycle to find cycle path
        # return last cycle edge in edges
        edge_idxs = {}
        g = defaultdict(list)
        for i, (a, b) in enumerate(edges):
            g[a].append(b)
            g[b].append(a)
            edge_idxs[(a, b)] = i
        
        cycle_node = None
        cycle_path = None
        def dfs(node, prev, path, path_arr, visited):
            if node in visited:
                return
            if node in path:
                nonlocal cycle_node, cycle_path
                if cycle_node is None:
                    cycle_node = node
                else:
                    path_arr.append(node)
                    cycle_path = path_arr[:]
                return True

            path.add(node)
            path_arr.append(node)
            for neighbor in g[node]:
                if neighbor == prev or neighbor in visited:
                    continue
                if dfs(neighbor, node, path, path_arr, visited):
                    return True
            path.remove(node)
            path_arr.pop()
            return False
        dfs(1, None, set(), [], set())
        dfs(cycle_node, None, set(), [], set())

        k = -1
        for i in range(len(cycle_path) - 1):
            a, b = cycle_path[i], cycle_path[i + 1]
            if a > b:
                a, b = b, a
            k = max(k, edge_idxs[(a, b)])
        return edges[k]
```

## Notes
- 2 rounds of DFS. The first locates a node in the cycle resulting from the redundant connection, the second determines all of the edges involved in the cycle by starting from the node returned from the first DFS round. Then just return the cycle edge that is last in the cycle edges.