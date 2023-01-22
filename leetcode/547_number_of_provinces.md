# 547. Number of Provinces - Medium

There are `n` cities. Some of them are connected, while some are not. If city `a` is connected directly with city `b`, and city `b` is connected directly with city `c`, then city `a` is connected indirectly with city `c`.

A province is a group of directly or indirectly connected cities and no other cities outside of the group.

You are given an `n x n` matrix `isConnected` where `isConnected[i][j] = 1` if the `ith` city and the `jth` city are directly connected, and `isConnected[i][j] = 0` otherwise.

Return the total number of provinces.

##### Example 1:

```
Input: isConnected = [[1,1,0],[1,1,0],[0,0,1]]
Output: 2
```

##### Example 2:

```
Input: isConnected = [[1,0,0],[0,1,0],[0,0,1]]
Output: 3
```

##### Constraints:

- `1 <= n <= 200`
- `n == isConnected.length`
- `n == isConnected[i].length`
- `isConnected[i][j]` is `1` or `0`.
- `isConnected[i][i] == 1`
- `isConnected[i][j] == isConnected[j][i]`

## Solution

```
class UnionFind:
    def __init__(self):
        self.roots = {}
        self.sizes = {}

    def find(self, x):
        if self.roots[x] == x:
            return x
        self.roots[x] = self.find(self.roots[x])
        return self.roots[x]
    
    def union(self, x, y):
        if x not in self.sizes:
            self.sizes[x] = 1
            self.roots[x] = x
        if y not in self.sizes:
            self.sizes[y] = 1
            self.roots[y] = y
        xroot, yroot = self.find(x), self.find(y)
        if xroot == yroot:
            return False
        if self.sizes[xroot] > self.sizes[yroot]:
            self.sizes[xroot] += self.sizes[yroot]
            self.roots[yroot] = self.roots[xroot]
        else:
            self.sizes[yroot] += self.sizes[xroot]
            self.roots[xroot] = self.roots[yroot]
        return True

# Time: O(ack(n) * n) -> O(n)
# Space: O(n)
class Solution:
    def findCircleNum(self, isConnected: List[List[int]]) -> int:
        n, u = len(isConnected), UnionFind()
        result = n
        for i in range(n):
            for j in range(i + 1, n):
                if isConnected[i][j]:
                    if u.union(i, j):
                        result -= 1
        return result
```

## Notes
- With path compression and union by rank implemented correctly, performed `union` on a `UnionFind` data structure is upper bounded by the ackermann function of `n`, which grows so slowly that the time of `union` can be treated as a small constant. This is a textbook union find question. Note how we iterate to avoid considering the same edge twice.