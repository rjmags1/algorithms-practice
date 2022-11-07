# 104. Maximum Depth of Binary Tree - Easy

Given the `root` of a binary tree, return its maximum depth.

A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

##### Example 1:

```
Input: root = [3,9,20,null,null,15,7]
Output: 3
```

##### Example 2:

```
Input: root = [1,null,2]
Output: 2
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 104]`.
- `-100 <= Node.val <= 100`

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    md = 0
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if root is None:
            return 0
        
        def rec(node, d):
            self.md = max(self.md, d)
            if node.left:
                rec(node.left, d + 1)
            if node.right:
                rec(node.right, d + 1)
        
        rec(root, 1)
        return self.md
```

## Notes
- Recursive

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if root is None:
            return 0
        
        curr, stack = (root, 1), [None]
        result = 1
        while curr:
            n, d = curr
            if n.left:
                stack.append(curr)
                curr = (n.left, d + 1)
                continue
            
            while curr:
                n, d = curr
                result = max(result, d)
                if n.right:
                    curr = (n.right, d + 1)
                    break
                curr = stack.pop()
        
        return result
```

## Notes
- Iterative