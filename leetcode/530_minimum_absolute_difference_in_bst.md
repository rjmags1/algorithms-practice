# 530. Minimum Absolute Difference in BST - Easy

Given the root of a Binary Search Tree (BST), return the minimum absolute difference between the values of any two different nodes in the tree.

##### Example 1:

```
Input: root = [4,2,6,1,3]
Output: 1
```

##### Example 2:

```
Input: root = [1,0,48,null,null,12,49]
Output: 1
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[2, 10<sup>4</sup>]</code>.
- <code>0 <= Node.val <= 10<sup>5</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def getMinimumDifference(self, root: Optional[TreeNode]) -> int:
        maxint = 2 ** 31 - 1
        prev, result = -(maxint + 1), maxint
        stack = [(root, False)]
        while stack:
            node, visited = stack.pop()
            if visited:
                result = min(result, node.val - prev)
                prev = node.val
                if node.right:
                    stack.append((node.right, False))
            else:
                stack.append((node, True))
                if node.left:
                    stack.append((node.left, False))
        return result
```

## Notes
- Inorder traversal of BST yields sorted order of node values. Iterative implementation of inorder traversal.