# 261. Graph Valid Tree - Medium

You have a graph of `n` nodes labeled from `0` to `n - 1`. You are given an integer `n` and a list of edges where `edges[i] = [ai, bi]` indicates that there is an undirected edge between nodes `ai` and `bi` in the graph.

Return `true` if the edges of the given graph make up a valid tree, and `false` otherwise.

##### Example 1:

```
Input: n = 5, edges = [[0,1],[0,2],[0,3],[1,4]]
Output: true
```

##### Example 2:

```
Input: n = 5, edges = [[0,1],[1,2],[2,3],[1,3],[1,4]]
Output: false
```

##### Constraints:

- `1 <= n <= 2000`
- `0 <= edges.length <= 5000`
- `edges[i].length == 2`
- `0 <= ai, bi < n`
- `ai != bi`
- There are no self-loops or repeated edges.

## Solution 1

```
# Time: O(v + e)
# Space: O(v + e)
class Solution:
    def validTree(self, n: int, edges: List[List[int]]) -> bool:
        g = defaultdict(list)
        for a, b in edges:
            g[a].append(b)
            g[b].append(a)
        
        visited = [False] * n
        inpath = visited[:]
        def hascycle(node, prev):
            if inpath[node]:
                return True
            
            inpath[node] = True
            for neighbor in g[node]:
                if neighbor == prev:
                    continue
                if hascycle(neighbor, node):
                    return True
            inpath[node] = False
            
            visited[node] = True
            return False
        
        return not hascycle(0, None) and all(visited)
```

## Notes
- Key thing to note here is we have a tree as long as all nodes in the graph are connected by `edges`, such that there are no cycles. We can detect cycles with dfs or bfs. 

## Solution 2

```
# Time: O(v + e)
# Space: O(v + e)
class Solution:
    def validTree(self, n: int, edges: List[List[int]]) -> bool:
        g = defaultdict(list)
        for a, b in edges:
            g[a].append(b)
            g[b].append(a)
        
        q = deque([(0, None)])
        visited = [False] * n
        while q:
            curr, parent = q.popleft()
            if visited[curr]:
                return False
            visited[curr] = True
            for child in g[curr]:
                if child == parent:
                    continue
                q.append((child, curr))
                
        return all(visited)
```

## Notes
- With bfs/level-order traversal of a graph, to detect cycles we need to look out for inter-level edges as well as edges in the current level that touch a node in a previously traversed level. This implementation does both. To run full bfs on a graph takes `O(v + e)` time where `v` is the number of nodes in the graph and `e` is the number of edges.

## Solution 3

```
# Time: O(v)
# Space: O(v)
class Solution:
    def validTree(self, n: int, edges: List[List[int]]) -> bool:
        if len(edges) != n - 1:
            return False
        
        g = defaultdict(list)
        for a, b in edges:
            g[a].append(b)
            g[b].append(a)
        
        q = deque([0])
        visited = [False] * n
        while q:
            curr = q.popleft()
            visited[curr] = True
            for child in g[curr]:
                if not visited[child]:
                    q.append(child)
                
        return all(visited)
```

## Notes
- It turns out that for a graph to be a tree, it must have exactly `n - 1` distinct edges where `n` is the number of nodes. This makes sense if you try and build a tree with more or less edges than that. If more, you will inevitably repeat an edge or create a cycle. If less, the whole graph won't be connected. However, it is possible to make a graph with `n - 1` edges that has multiple distinct components, some of which would contain an edge.
- As a result of this thinking, if we can narrow our algorithm to only consider graphs where there are `n - 1` edges (returning `False` for all other cases), all we need to do is check that the graph is fully connected; no need to check for cycles. This version of the algorithm has a lowered time complexity because `v = e + 1` for any cases that make it pass the initial check condition.

## Solution 4

```
# Time: O(n * ack(n))
# Space: O(n)
class Union:
    def __init__(self, n):
        self.sets, self.sizes = [], {}
        for i in range(n):
            self.sets.append(i)
            self.sizes[i] = 1
        
    def find(self, s):
        root, path = s, []
        while self.sets[root] != root:
            path.append(root)
            root = self.sets[root]
        for nonroot in path:
            self.sets[nonroot] = root
        return root
    
    def union(self, s1, s2):
        root1, root2 = self.find(s1), self.find(s2)
        if self.sizes[root1] < self.sizes[root2]:
            self.sets[root1] = root2
            self.sizes[root2] += self.sizes[root1]
        else:
            self.sets[root2] = root1
            self.sizes[root2] += self.sizes[root2]
        return root1 != root2

class Solution:
    def validTree(self, n: int, edges: List[List[int]]) -> bool:
        if len(edges) != n - 1:
            return False
        
        U = Union(n)
        return all([U.union(a, b) for a, b in edges])
```

## Notes
- Calling union on each edge (number of edges upper bounded by `n`, the number of nodes again as in solution 3), for a correctly implemented `Union` data structure, is on the order of the ackermann function passed `n`. The ackermann function grows so slow that it is safe to treat it as a constant value.
- The fact that we can use union find for this problem is based on the idea that a graph must have `n - 1` edges to be a tree, and this graph must be fully connected. As a corollary, for the graph to be fully connected, each of the `n - 1` edges must unite previously disconnected components, otherwise it is a cycle-forming edge. With this in mind, we can start out considering each node as its own disconnected subcomponent and traverse the edges. If any edge does not result in a new subcomponent connection (i.e., the nodes were already in the same component), we have found a cycle edge, and thus we can say the graph cannot be connected.