# 333. Largest BST Subtree - Medium

Given the root of a binary tree, find the largest subtree, which is also a Binary Search Tree (BST), where the largest means subtree has the largest number of nodes.

A Binary Search Tree (BST) is a tree in which all the nodes follow the below-mentioned properties:

- The left subtree values are less than the value of their parent (root) node's value.
- The right subtree values are greater than the value of their parent (root) node's value.

Note: A subtree must include all of its descendants.

##### Example 1:

```
Input: root = [10,5,15,1,8,null,7]
Output: 3
Explanation: The Largest BST Subtree in this case is the highlighted one. The return value is the subtree's size, which is 3.
```

##### Example 2:

```
Input: root = [4,2,7,2,3,5,null,2,null,null,null,null,null,1]
Output: 2
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[0, 10<sup>4</sup>]</code>.
- <code>-10<sup>4</sup> <= Node.val <= 10<sup>4</sup></code>

Follow-up: Can you figure out ways to solve it with `O(n)` time complexity? 

## Solution

```
# Time: O(n)
# Space: O(h)
class Solution:
    def largestBSTSubtree(self, root: Optional[TreeNode]) -> int:
        result = 0
        def rec(node):
            if node is None:
                return inf, -inf, 0
            
            lmin, lmax, lsize = rec(node.left)
            rmin, rmax, rsize = rec(node.right)
            if lsize > -1 and rsize > -1 and lmax < node.val < rmin:
                nonlocal result
                currsize = 1 + lsize + rsize
                result = max(result, currsize)
                currmin, currmax = min(lmin, node.val), max(rmax, node.val)
                return currmin, currmax, currsize
            
            return None, None, -1
        
        rec(root)
        return result
```

## Notes
- Higher subtrees are only valid if all their subtree descendants are valid subtrees. BSTs are essentially sorted lists in a tree format, so the minimum value for a particular subtree will always come from the left subtree (or the root if there is no left subtree), and the maximum value for a particular subtree will always come from the right subtree (or the root if there is no right subtree). To determine if a particular root is the root of a valid BST subtree, the left and right subtrees of the root must be valid BSTs themselves, and the rightmost value (largest) in the left subtree must be less than the root value and the leftmost value (smallest) in the right subtree must be greater than the root value.