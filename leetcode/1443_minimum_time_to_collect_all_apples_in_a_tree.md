# 1443. Minimum Time to Collect All Apples in a Tree - Medium

Given an undirected tree consisting of `n` vertices numbered from `0` to `n-1`, which has some apples in their vertices. You spend `1` second to walk over one edge of the tree. Return the minimum time in seconds you have to spend to collect all apples in the tree, starting at vertex `0` and coming back to this vertex.

The edges of the undirected tree are given in the array edges, where `edges[i] = [ai, bi]` means that exists an edge connecting the vertices `ai` and `bi`. Additionally, there is a boolean array `hasApple`, where `hasApple[i] = true` means that vertex `i` has an apple; otherwise, it does not have any apple.

##### Example 1:

![](../assets/1443_1.png)

```
Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], hasApple = [false,false,true,false,true,true,false]
Output: 8 
Explanation: The figure above represents the given tree where red vertices have an apple. One optimal path to collect all apples is shown by the green arrows. 
```

##### Example 2:

![](../assets/1443_2.png)

```
Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], hasApple = [false,false,true,false,false,true,false]
Output: 6
Explanation: The figure above represents the given tree where red vertices have an apple. One optimal path to collect all apples is shown by the green arrows. 
```

##### Example 3:

```
Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], hasApple = [false,false,false,false,false,false,false]
Output: 0
```

##### Constraints:

- <code>1 <= n <= 10<sup>5</sup></code>
- `edges.length == n - 1`
- `edges[i].length == 2`
- `0 <= ai < bi <= n - 1`
- `hasApple.length == n`

## Solution

```
from collections import defaultdict

# Time: O(n)
# Space: O(n)
class Solution:
    def minTime(self, n: int, edges: List[List[int]], hasApple: List[bool]) -> int:
        edges_ = defaultdict(list)
        for a, b in edges:
            edges_[a].append(b)
            edges_[b].append(a)

        subtreeHasApple = defaultdict(bool)
        def findApples(node, prev):
            appleInSubtree = hasApple[node]
            for neighbor in edges_[node]:
                if neighbor != prev:
                    appleInSubtree = findApples(neighbor, node) or appleInSubtree
            subtreeHasApple[node] = appleInSubtree
            return appleInSubtree
        
        def getTime(node, prev):
            result = 0
            for neighbor in edges_[node]:
                if neighbor != prev and subtreeHasApple[neighbor]:
                    result += 2 + getTime(neighbor, node)
            return result
        
        findApples(0, None)
        return getTime(0, None)
```

## Notes
- We are essentially looking for the smallest subtree that contains all apples. To get this information, we need a way to perform DFS, and since we are given tree edge information in the form of a list of pairs of nodes, we can construct an adjacency map. From there we can recursively DFS to determine which nodes are roots of subtrees that contain apples and those that are not, and then use this information to traverse the minimum apple containing subtree and count seconds.