# 886. Possible Bipartition - Medium

We want to split a group of `n` people (labeled from `1` to `n`) into two groups of any size. Each person may dislike some other people, and they should not go into the same group.

Given the integer `n` and the array dislikes where `dislikes[i] = [ai, bi]` indicates that the person labeled `ai` does not like the person labeled `bi`, return `true` if it is possible to split everyone into two groups in this way.

##### Example 1:

```
Input: n = 4, dislikes = [[1,2],[1,3],[2,4]]
Output: true
Explanation: The first group has [1,4], and the second group has [2,3].
```

##### Example 2:

```
Input: n = 3, dislikes = [[1,2],[1,3],[2,3]]
Output: false
Explanation: We need at least 3 groups to divide them. We cannot put them in two groups.
```

##### Constraints:

- <code>0 <= dislikes.length <= 10<sup>4</sup></code>
- <code>1 <= n <= 2000</code>
- <code>dislikes[i].length == 2</code>
- <code>1 <= ai < bi <= n</code>
- All the pairs of `dislikes` are unique.

## Solution 1

```
from collections import defaultdict, deque

# Time: O(v + e)
# Space: O(v + e)
class Solution:
    def possibleBipartition(self, n: int, dislikes: List[List[int]]) -> bool:
        adj = defaultdict(list)
        for a, b in dislikes:
            adj[a].append(b)
            adj[b].append(a)

        group = [None] * (n + 1)
        A, B = 1, 2
        def bfs(root):
            q = deque([(root, A)])
            while q:
                curr, g = q.popleft()
                if group[curr]:
                    if group[curr] != g:
                        return False
                    continue
                group[curr] = g
                ng = B if g is A else A
                for neighbor in adj[curr]:
                    if group[neighbor] and group[neighbor] != ng:
                        return False
                    q.append((neighbor, ng))
            return True
        
        return all(group[node] or bfs(node) for node in range(1, n + 1))
```

## Notes
- We can utilize graph traversal to solve this problem (DFS or BFS). A BFS solution is shown above, and it involves picturing dislike relationships as edges in a graph. We need to traverse all components of the graph in order to determine if there is an edge that prevents splitting into groups as desired according to the prompt. We do this by keeping track of the group a person should be assigned to the first time we encounter them during traversal, and if we encounter them again by traversing another edge such that there is a conflict, we know to return `False`.

## Solution 2

```

```

## Notes
- 