# 250. Count Univalue Subtrees - Medium

Given the `root` of a binary tree, return the number of uni-value subtrees.

A uni-value subtree means all nodes of the subtree have the same value.

##### Example 1:

```
Input: root = [5,1,5,5,5,null,5]
Output: 4
```

##### Example 2:

```
Input: root = []
Output: 0
```

##### Example 3:

```
Input: root = [5,5,5,5,5,null,5]
Output: 6
```

##### Constraints:

- The number of the node in the tree will be in the range `[0, 1000]`.
- `-1000 <= Node.val <= 1000`

## Solution

```
# Time: O(n)
# Space: O(h)
class Solution:
    def countUnivalSubtrees(self, root: Optional[TreeNode]) -> int:
        result = 0
        def rec(node):
            if node is None:
                return True
            
            leftunival = rec(node.left)
            rightunival = rec(node.right)
            
            isunival = False
            lv = node.left.val if node.left else None
            rv = node.right.val if node.right else None
            nv = node.val
            if lv is None and rv is None:
                isunival = True
            elif lv is None:
                isunival = rv == nv and rightunival
            elif rv is None:
                isunival = lv == nv and leftunival
            else:
                isunival = lv == rv == nv and rightunival and leftunival
            
            if isunival:
                nonlocal result
                result += 1
            return isunival
            
        rec(root)
        return result
```

## Notes
- Fairly straightforward, just be careful about separating out the recursive calls to left and right children in their own calls instead of including them in the same boolean expression, because of short circuit boolean evaluation.