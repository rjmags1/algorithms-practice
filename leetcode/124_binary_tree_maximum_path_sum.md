# 124. Binary Tree Maximum Path Sum - Hard

A path in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge connecting them. A node can only appear in the sequence at most once. Note that the path does not need to pass through the root.

The path sum of a path is the sum of the node's values in the path.

Given the `root` of a binary tree, return the maximum path sum of any non-empty path.

##### Example 1:

```
Input: root = [1,2,3]
Output: 6
Explanation: The optimal path is 2 -> 1 -> 3 with a path sum of 2 + 1 + 3 = 6.
```

##### Example 2:

```
Input: root = [-10,9,20,null,null,15,7]
Output: 42
Explanation: The optimal path is 15 -> 20 -> 7 with a path sum of 15 + 20 + 7 = 42.
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 3 * 10<sup>4</sup>]</code>.
- `-1000 <= Node.val <= 1000`

## Solution

```
# Time: O(n)
# Space: O(n) (O(log(n)) if tree is balanced)
class Solution:
    def maxPathSum(self, root: Optional[TreeNode]) -> int:
        result = -inf
        def rec(node):
            if node is None:
                return 0
            
            nonlocal result
            lbs = rec(node.left)
            rbs = rec(node.right)
            lbsWithCurr = lbs + node.val
            rbsWithCurr = rbs + node.val
            currAsRoot = lbsWithCurr + rbs
            result = max(result, node.val, lbsWithCurr, rbsWithCurr, currAsRoot)
            return max(0, node.val, lbsWithCurr, rbsWithCurr)
        
        rec(root)
        return result
```

## Notes
- The max path sum for a given node as the root is the max of the path running thru the root, the path from the left subtree through the current root but not including the right subtree, the path from the right subtree through the current root but not including the left subtree, and just the node's value itself (consider a case where `node.val` is the only positive node in the tree). To calculate these values for all nodes, we need to pass the max branch running through the current node so that it may be used as part of the path for nodes higher up in the tree.