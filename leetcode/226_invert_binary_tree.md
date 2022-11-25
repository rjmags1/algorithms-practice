# 226. Invert Binary Tree - Easy

Given the `root` of a binary tree, invert the tree, and return its root.

##### Example 1:
<img src="../assets/226_invert1-tree.jpg" />
```
Input: root = [4,2,7,1,3,6,9]
Output: [4,7,2,9,6,3,1]
```

##### Example 2:

```
Input: root = [2,1,3]
Output: [2,3,1]
```

##### Example 3:

```
Input: root = []
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 100]`.
- `-100 <= Node.val <= 100`

## Solution 1

```
class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if root is None:
            return
        root.left, root.right = root.right, root.left
        self.invertTree(root.left)
        self.invertTree(root.right)
        return root
```

## Notes
- Recursive version, preorder traverse and swap children on visit.

## Solution 2

```
class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        stack = [root]
        while stack:
            curr = stack.pop()
            if curr is None:
                continue
            curr.left, curr.right = curr.right, curr.left
            stack.append(curr.left)
            stack.append(curr.right)
        return root
```

## Notes
- Iterative. 