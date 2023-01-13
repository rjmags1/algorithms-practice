# 366. Find Leaves of Binary Tree - Medium

Given the `root` of a binary tree, collect a tree's nodes as if you were doing this:

- Collect all the leaf nodes.
- Remove all the leaf nodes.
- Repeat until the tree is empty.


##### Example 1:

```
Input: root = [1,2,3,4,5]
Output: [[4,5,3],[2],[1]]
Explanation:
[[3,5,4],[2],[1]] and [[3,4,5],[2],[1]] are also considered correct answers since per each level it does not matter the order on which elements are returned.
```

##### Example 2:

```
Input: root = [1]
Output: [[1]]
```

##### Constraints:

- The number of nodes in the tree is in the range `[1, 100]`.
- `-100 <= Node.val <= 100`

## Solution

```
# Time: O(n)
# Space: O(h)
class Solution:
    def findLeaves(self, root: Optional[TreeNode]) -> List[List[int]]:
        levels = []
        def rec(node):
            if node is None:
                return -1

            llevel = rec(node.left)
            rlevel = rec(node.right)
            currlevel = max(llevel, rlevel) + 1
            if currlevel == len(levels):
                levels.append([])
            levels[currlevel].append(node.val)
            return currlevel
        
        rec(root)
        return levels
```

## Notes
- The 'leaf layer' of a node is `1 + max(leftchildleaflayer, rightchildleaflayer)`.