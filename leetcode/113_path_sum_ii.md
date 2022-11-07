# 113. Path Sum II - Medium

Given the `root` of a binary tree and an integer `targetSum`, return all root-to-leaf paths where the sum of the node values in the path equals `targetSum`. Each path should be returned as a list of the node values, not node references.

A root-to-leaf path is a path starting from the root and ending at any leaf node. A leaf is a node with no children.

##### Example 1:

```
Input: root = [5,4,8,11,null,13,4,7,2,null,null,5,1], targetSum = 22
Output: [[5,4,11,2],[5,8,4,5]]
Explanation: There are two paths whose sum equals targetSum:
5 + 4 + 11 + 2 = 22
5 + 8 + 4 + 5 = 22
```

##### Example 2:

```
Input: root = [1,2,3], targetSum = 5
Output: []
```

##### Example 3:

```
Input: root = [1,2], targetSum = 0
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 5000]`.
- `-1000 <= Node.val <= 1000`
- `-1000 <= targetSum <= 1000`

## Solution

```
# Time: O(n^2)
# Space: O(n) (O(log(n)) if tree is balanced)
class Solution:
    def pathSum(self, root: Optional[TreeNode], targetSum: int) -> List[List[int]]:
        result, builder = [], []
        def rec(node, currSum):
            if node is None:
                return
            
            newSum = currSum + node.val
            builder.append(node.val)
            if node.left is None and node.right is None:
                if newSum == targetSum:
                    result.append(builder[:])
                builder.pop()
                return
            
            rec(node.left, newSum)
            rec(node.right, newSum)
            builder.pop()
        
        rec(root, 0)
        return result
```

## Notes
- The space complexity would also be <code>O(n<sup>2</sup>)</code> if we counted the result in it. 
- The quadratic complexity is a result of building a list of `O(n)` length each for each path whose sum is equal to `targetSum`. There are `O(n)` possible paths because a tree with `n` nodes could have at most `(n // 2) + 1` nodes at the bottom level.