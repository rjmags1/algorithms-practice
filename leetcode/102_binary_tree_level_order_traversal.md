# 102. Binary Tree Level Order Traversal - Medium

Given the `root` of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

##### Example 1:

```
Input: root = [3,9,20,null,null,15,7]
Output: [[3],[9,20],[15,7]]
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
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if root is None:
            return []
        
        result, prev, curr = [], [root], []
        while prev:
            result.append([])
            for parent in prev:
                result[-1].append(parent.val)
                if parent.left:
                    curr.append(parent.left)
                if parent.right:
                    curr.append(parent.right)
            prev, curr = curr, []
            
        return result
```

## Notes
- We iterate over the tree level by level, adding nodes into their own list for appending to `result`, while also collecting the children of the nodes in the current level for the next iteration. This is level order traversal, AKA bfs on a binary tree starting at `root`. 
- This could also be solved with dfs and a hash table with depth values for keys and lists as values. Specifically the form of dfs here would need to be inorder traversal.