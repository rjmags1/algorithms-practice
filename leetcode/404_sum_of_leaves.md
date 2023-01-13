# 404. Sum of Leaves - Easy

Given the `root` of a binary tree, return the sum of all left leaves.

A leaf is a node with no children. A left leaf is a leaf that is the left child of another node.

##### Example 1:

```
Input: root = [3,9,20,null,null,15,7]
Output: 24
Explanation: There are two left leaves in the binary tree, with values 9 and 15 respectively.
```

##### Example 2:

```
Input: root = [1]
Output: 0
```

##### Constraints:

- The number of nodes in the tree is in the range `[1, 1000]`.
- `-1000 <= Node.val <= 1000`

## Solution

```
# Time: O(n)
# Space: O(h)
class Solution:
    def sumOfLeftLeaves(self, root: Optional[TreeNode]) -> int:
        def rec(node, lc):
            if node is None:
                return 0
                
            result = rec(node.left, True) + rec(node.right, False)
            if node.left is None and node.right is None and lc:
                result += node.val
            return result
        
        return rec(root, False)
```

## Notes
- Basic tree traversal, postorder here to calculate result during traversal, but could also be done inorder or preorder with a global variable. Any of these approaches could be done iteratively with a stack as well. 