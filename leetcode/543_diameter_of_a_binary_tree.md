# 543. Diameter of a Binary Tree - Easy

Given the `root` of a binary tree, return the length of the diameter of the tree.

The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

The length of a path between two nodes is represented by the number of edges between them.

##### Example 1:

```
Input: root = [1,2,3,4,5]
Output: 3
Explanation: 3 is the length of the path [4,2,1,3] or [5,2,1,3].
```

##### Example 2:

```
Input: root = [1,2]
Output: 1
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- `-100 <= Node.val <= 100`

## Solution

```
# Time: O(n)
# Space: O(h)
class Solution:
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        result = 0
        def rec(node):
            if node.left is None and node.right is None:
                return 0

            nonlocal result
            llb = 1 + rec(node.left) if node.left else 0
            rlb = 1 + rec(node.right) if node.right else 0
            result = max(result, llb + rlb)
            return max(llb, rlb)

        rec(root)
        return result
```

## Notes
- To get the diameter we need to determine the sum of the lengths of left and right branches for all nodes, where a branch is the longest path from a node to a leaf descendant of it.