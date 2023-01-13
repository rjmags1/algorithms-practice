# 323. Number of Connected Components in an Undirected Graph - Medium

You have a graph of `n` nodes. You are given an integer `n` and an array `edges` where `edges[i] = [ai, bi]` indicates that there is an edge between `ai` and `bi` in the graph.

Return the number of connected components in the graph.

##### Example 1:

```
Input: n = 5, edges = [[0,1],[1,2],[3,4]]
Output: 2
```

##### Example 2:

```
Input: n = 5, edges = [[0,1],[1,2],[2,3],[3,4]]
Output: 1
```

##### Constraints:

- `1 <= n <= 2000`
- `1 <= edges.length <= 5000`
- `edges[i].length == 2`
- `0 <= ai <= bi < n`
- `ai != bi`
- There are no repeated edges.

## Solution

```
class Union:
    def __init__(self, n):
        self.r = [i for i in range(n)]
        self.sizes = [1] * n
    
    def union(self, a, b):
        ra = self.find(a)
        rb = self.find(b)
        if ra == rb:
            return False
        
        if self.sizes[a] > self.sizes[b]:
            self.sizes[a] += self.sizes[b]
            self.r[rb] = ra
        else:
            self.sizes[b] += self.sizes[a]
            self.r[ra] = rb
        return True
    
    def find(self, a):
        if a == self.r[a]:
            return a
        self.r[a] = self.find(self.r[a])
        return self.r[a]

# Time: O(v + e)
# Space: O(v)
class Solution:
    def countComponents(self, n: int, edges: List[List[int]]) -> int:
        u = Union(n)
        result = n
        for a, b in edges:
            if u.union(a, b):
                result -= 1
        return result
```

## Notes
- When implementing `Union` with rank and path compression, we care about finding, updating size of, and uniting __roots__, which is an arbitrary node in a united component that serves as the label of that component, distinguishing it from other components. As long as this is done correctly we can treat `find` and `union` operations as (amortized) constant time.
- Note how the number of distinct components decreases by `1` each time two components are successfully merged. This is similar to 305. Number of Islands II problem but simpler.
- Note how the `Union` instance roots list can not be treated as a reliable source of information about distinct sets in the data structure.