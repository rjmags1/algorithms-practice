# 107. Binary Tree Level Order Traversal II - Medium

Given the `root` of a binary tree, return the bottom-up level order traversal of its nodes' values. (i.e., from left to right, level by level from leaf to root).

##### Example 1:

```
Input: root = [3,9,20,null,null,15,7]
Output: [[15,7],[9,20],[3]]
```

##### Example 2:

```
Input: root = [1]
Output: [[1]]
```

##### Example 3:

```
Input: root = []
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 2000]`.
- `-1000 <= Node.val <= 1000`

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def levelOrderBottom(self, root: Optional[TreeNode]) -> List[List[int]]:
        if root is None:
            return []
        
        result, curr, prev = [], [], [root]
        while prev:
            result.append([])
            for parent in prev:
                result[-1].append(parent.val)
                if parent.left:
                    curr.append(parent.left)
                if parent.right:
                    curr.append(parent.right)
            prev, curr = curr, []
        
        result.reverse()
        return result
```

## Notes
- The exact same as 102. Binary Tree Level Order Traversal except just reverse `result` before returning.