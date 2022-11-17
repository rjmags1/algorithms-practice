# 111. Minimum Depth of Binary Tree - Easy

Given a binary tree, find its minimum depth.

The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.

Note: A leaf is a node with no children.

##### Example 1:

```
Input: root = [3,9,20,null,null,15,7]
Output: 2
```

##### Example 2:

```
Input: root = [2,null,3,null,4,null,5,null,6]
Output: 5
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 105]`.
- `-1000 <= Node.val <= 1000`

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def minDepth(self, root: Optional[TreeNode]) -> int:
        if root is None:
            return 0
        
        d = 1
        prev, curr = [root], []
        while prev:
            for parent in prev:
                if not parent.left and not parent.right:
                    return d
                if parent.left:
                    curr.append(parent.left)
                if parent.right:
                    curr.append(parent.right)
            prev, curr = curr, []
            d += 1
```

## Notes
- Could also do dfs and keep track of min depth seen so far to solve this. In above we do level-order traversal and return the current depth the first time we encounter a leaf node, which is going to be more efficient than dfs in most cases.