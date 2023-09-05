# 662. Maximum Width of Binary Tree - Medium

Given the `root` of a binary tree, return the maximum width of the given tree.

The maximum width of a tree is the maximum width among all levels.

The width of one level is defined as the length between the end-nodes (the leftmost and rightmost non-null nodes), where the null nodes between the end-nodes that would be present in a complete binary tree extending down to that level are also counted into the length calculation.

It is guaranteed that the answer will in the range of a 32-bit signed integer.

##### Example 1:

```
Input: root = [1,3,2,5,3,null,9]
Output: 4
Explanation: The maximum width exists in the third level with length 4 (5,3,null,9).
```

##### Example 2:

```
Input: root = [1,3,2,5,null,null,9,6,null,7]
Output: 7
Explanation: The maximum width exists in the fourth level with length 7 (6,null,null,null,null,null,7).
```

##### Example 3:

```
Input: root = [1,3,2,5]
Output: 2
Explanation: The maximum width exists in the second level with length 2 (3,2).
```

##### Constraints:

- The number of nodes in the tree is in the range `[1, 3000]`.
- `-100 <= Node.val <= 100`

## Solution

```
from collections import defaultdict
import math

# Time: O(n)
# Space: O(n)
class Solution:
    def widthOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        # get leftmost position for each level
        # get rightmost position for each level
        level_info = defaultdict(lambda: [math.inf, -math.inf])
        LEFT, RIGHT = 0, 1
        def rec(node, level, direction, indents):
            if direction == LEFT:
                level_info[level][LEFT] = min(level_info[level][LEFT], indents)
                indents *= 2
                if node.left:
                    rec(node.left, level + 1, LEFT, indents)
                if node.right:
                    indents += 1
                    rec(node.right, level + 1, LEFT, indents)
            else:
                level_info[level][RIGHT] = max(level_info[level][RIGHT], 2 ** level - 1 - indents)
                indents *= 2
                if node.right:
                    rec(node.right, level + 1, RIGHT, indents)
                if node.left:
                    indents += 1
                    rec(node.left, level + 1, RIGHT, indents)
        
        rec(root, 0, LEFT, 0)
        rec(root, 0, RIGHT, 0)
        result = 0
        for level, [left_idx, right_idx] in level_info.items():
            if left_idx == math.inf or right_idx == -math.inf:
                continue
            result = max(result, right_idx - left_idx + 1)
        return result
```

## Notes
- Since we are dealing with a binary tree, it is possible to determine, for a given level of the tree, the number of null nodes to the left of the leftmost node in the level and the number of null nodes to the right of the rightmost node in the level. With this information and the number of nodes in a level in a complete binary tree we can determine the width of each level.