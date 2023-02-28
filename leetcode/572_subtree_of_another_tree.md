# 572. Subtree of Another Tree - Easy

Given the roots of two binary trees `root` and `subRoot`, return `true` if there is a subtree of `root` with the same structure and node values of `subRoot` and `false` otherwise.

A subtree of a binary tree `tree` is a tree that consists of a node in `tree` and all of this node's descendants. The tree `tree` could also be considered as a subtree of itself.

##### Example 1:

```
Input: root = [3,4,5,1,2], subRoot = [4,1,2]
Output: true
```

##### Example 2:

```
Input: root = [3,4,5,1,2,null,null,null,null,0], subRoot = [4,1,2]
Output: false
```

##### Constraints:

- The number of nodes in the root tree is in the range `[1, 2000]`.
- The number of nodes in the subRoot tree is in the range `[1, 1000]`.
- <code>-10<sup>4</sup> <= root.val <= 10<sup>4</sup></code>
- <code>-10<sup>4</sup> <= subRoot.val <= 10<sup>4</sup></code>

## Solution

```
from collections import deque

# Time: O(m + n)
# Space: O(m + n)
class Solution:
    def serialize(self, root):
        result, stack = [], [root]
        while stack:
            node = stack.pop()
            result.append("#" if node is None else f"|{node.val}|")
            if node is not None:
                stack.append(node.left)
                stack.append(node.right)
        return ",".join(result)

    def isSubtree(self, root: Optional[TreeNode], subRoot: Optional[TreeNode]) -> bool:
        if root is None:
            return subRoot is None
        a, b = self.serialize(root), self.serialize(subRoot)
        return b in a
```

## Notes
- Instead of a naive `O(mn)` solution where all nodes are checked as the root of a matching subtree, we can get linear runtime if leverage the fact that **preorder** and **postorder** binary tree serializations **preserve binary tree structure**. We also leverage KMP algorithm (`in` python operator for strings has a more nuanced implementation but relies on linear KMP logic; technically has `O(mn)` for rare worst cases but main takeaways for this question remain the same) for linear string matching check to determine if the serialization of `subRoot` is contained in the serialization of `root`, which would otherwise result in `O(mn)` time. Note how delimiters are used for node values.