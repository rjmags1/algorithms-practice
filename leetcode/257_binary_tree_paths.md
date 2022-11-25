# 257. Binary Tree Paths - Easy

Given the `root` of a binary tree, return all root-to-leaf paths in any order.

A leaf is a node with no children.

##### Example 1:

```
Input: root = [1,2,3,null,5]
Output: ["1->2->5","1->3"]
```

##### Example 2:

```
Input: root = [1]
Output: ["1"]
```

##### Constraints:

- The number of nodes in the tree is in the range `[1, 100]`.
- `-100 <= Node.val <= 100`

## Solution

```
# Time: O(2^h * h)
# Space: O(2^h * h)
class Solution:
    def binaryTreePaths(self, root: Optional[TreeNode]) -> List[str]:
        def fbuilder(builder):
            return builder[0] if len(builder) == 1 else "->".join(builder)
        
        result, builder = [], []
        def rec(node):
            builder.append(str(node.val))
            if node.left is None and node.right is None:
                result.append(fbuilder(builder))
                builder.pop()
                return
            if node.left:
                rec(node.left)
            if node.right:
                rec(node.right)
            builder.pop()
            
        rec(root)
        return result
```

## Notes
- Leetcode solution claims linear time and space which is incorrect. In the worst case we have a perfect binary tree, in which case there will be <code>2<sup>h</sup></code> nodes in the lowest level, and each of the leaf nodes will cause a string of length `O(h)` to be built and added to the result.