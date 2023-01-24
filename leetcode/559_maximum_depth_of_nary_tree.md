# 559. Maximum Depth of N-ary Tree - Easy

Given a n-ary tree, find its maximum depth.

The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

Nary-Tree input serialization is represented in their level order traversal, each group of children is separated by the null value (See examples).

##### Example 1:

```
Input: root = [1,null,3,2,4,null,5,6]
Output: 3
```

##### Example 2:

```
Input: root = [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
Output: 5
```

##### Constraints:

- The total number of nodes is in the range <code>[0, 10<sup>4</sup>]</code>.
- The depth of the n-ary tree is less than or equal to `1000`.

## Solution

```
from collections import deque

# Time: O(n)
# Space: O(m) where m is max nodes in a level of the tree
class Solution:
    def maxDepth(self, root: 'Node') -> int:
        if not root:
            return 0
        q, result = deque([(root, 1)]), 0
        while q:
            node, d = q.popleft()
            result = max(result, d)
            for c in node.children:
                q.append((c, d + 1))
        return result
```

## Notes
- BFS or DFS will work, BFS is nice because most languages have max recursion depth set to a value that is relatively low compared to the number of entries we could fit in a queue. The input constraints tell us the depth of the input is handleable by recursion, but BFS still a better solution in general.