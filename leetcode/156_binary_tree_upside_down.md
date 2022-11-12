# 156. Binary Tree Upside Down - Medium

Given the `root` of a binary tree, turn the tree upside down and return the new root.

You can turn a binary tree upside down with the following steps:

- The original left child becomes the new root.
- The original root becomes the new right child.
- The original right child becomes the new left child.

The mentioned steps are done level by level. It is guaranteed that every right node has a sibling (a left node with the same parent) and has no children.

##### Example 1:

```
Input: root = [1,2,3,4,5]
Output: [4,5,2,null,null,3,1]
```

##### Example 2:

```
Input: root = []
Output: []
```

##### Example 3:

```
Input: root = [1]
Output: [1]
```

##### Constraints:

- The number of nodes in the tree will be in the range `[0, 10]`.
- `1 <= Node.val <= 10`
- Every right node in the tree has a sibling (a left node that shares the same parent).
- Every right node in the tree has no children.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def upsideDownBinaryTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        result = None
        def rec(node):
            if node is None:
                return
            
            nonlocal result
            left, right = node.left, node.right
            rec(left)
            if result is None and left and not left.left:
                result = left
            if left:
                left.left, left.right = right, node
            node.left = node.right = None
        
        rec(root)
        return result if result else root
```

## Notes
- We basically follow the directions in the prompt, except we need to be careful about a couple implied edge cases. We need to remember to unlink `node`'s pointers otherwise we will create cycles in the flipped tree. Also need to look out for left child leaf nodes!