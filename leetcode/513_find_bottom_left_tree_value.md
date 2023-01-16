# 513. Find Bottom Left Tree Value - Medium

Given the `root` of a binary tree, return the leftmost value in the last row of the tree.

##### Example 1:

```
Input: root = [2,1,3]
Output: 1
```

##### Example 2:

```
Input: root = [1,2,3,4,null,5,6,null,null,7]
Output: 7
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- <code>-2<sup>31</sup> <= Node.val <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def findBottomLeftValue(self, root: Optional[TreeNode]) -> int:
        if not root:
            return None

        curr = [root]
        while curr:
            nxt = []
            for node in curr:
                if node.right:
                    nxt.append(node.right)
                if node.left:
                    nxt.append(node.left)
            if not nxt:
                return curr[-1].val
            curr = nxt
```

## Notes
- Level order traversal right to left greatly simplifies implementation