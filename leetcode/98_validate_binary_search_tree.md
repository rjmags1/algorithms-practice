# 98. Validate Binary Search Tree - Medium

Given the `root` of a binary tree, determine if it is a valid binary search tree (BST).

A valid BST is defined as follows:

- The left subtree of a node contains only nodes with keys less than the node's key.
- The right subtree of a node contains only nodes with keys greater than the node's key.
- Both the left and right subtrees must also be binary search trees.


##### Example 1:

```
Input: root = [2,1,3]
Output: true
```

##### Example 2:

```
Input: root = [5,1,4,null,null,3,6]
Output: false
Explanation: The root node's value is 5 but its right child's value is 4.
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- <code>-2<sup>31</sup> <= Node.val <= 2<sup>31</sup> - 1</code>

## Solution 1

```
# Time: O(n)
# Space: O(n) (if balanced would be O(log(n)))
class Solution:
    def isValidBST(self, root: Optional[TreeNode]) -> bool:
        def rec(node, _min, _max):
            if node is None:
                return True
            if not _min < node.val < _max:
                return False
            
            return rec(node.left, _min, node.val) and rec(node.right, node.val, _max)
        
        return rec(root, -inf, inf)
```

## Notes
- This solution takes advantage of each time we step to a left or right child in a BST, the range of valid node values experiences an increase in its lower bound or a decrease in its upper bound, narrowing the range of acceptable node values.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    prev = -inf
    def isValidBST(self, root: Optional[TreeNode]) -> bool:
        def rec(node):
            if node is None:
                return True
            if not rec(node.left):
                return False
            if node.val <= self.prev:
                return False
            self.prev = node.val
            return rec(node.right)
        
        return rec(root)
```

## Notes
- This approach takes advantage of the sorted nature of visited node values in an inorder traversal of a bst. This could also be implemented iteratively. But recursive version more idiomatic.