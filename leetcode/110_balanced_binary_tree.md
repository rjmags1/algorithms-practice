# 110. Balanced Binary Tree - Easy

Given a binary tree, determine if it is height-balanced.

##### Example 1:

```
Input: root = [3,9,20,null,null,15,7]
Output: true
```

##### Example 2:

```
Input: root = [1,2,2,3,3,null,null,4,4]
Output: false
```

##### Example 3:

```
Input: root = []
Output: true
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 5000]`.
- <code>-10<sup>4</sup> <= Node.val <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n) (O(log(n)) if tree is balanced)
class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        def rec(node):
            if node is None:
                return 0
            
            ld = rec(node.left)
            rd = rec(node.right)
            if rd == -1 or ld == -1 or abs(ld - rd) > 1:
                return -1
            return max(ld, rd) + 1
        
        return rec(root) != -1
```

## Notes
-
-