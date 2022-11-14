# 199. Binary Tree Right Side View - Medium

Given the `root` of a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

##### Example 1:

<img src="../assets/199_right_side_view.jpg" />
```
Input: root = [1,2,3,null,5,null,4]
Output: [1,3,4]
```

##### Example 2:

```
Input: root = [1,null,3]
Output: [1,3]
```

##### Example 3:

```
Input: root = []
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 100]`.
- `-100 <= Node.val <= 100`

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def rightSideView(self, root: Optional[TreeNode]) -> List[int]:
        if not root:
            return []
        
        result, prev = [], [root]
        while prev:
            result.append(prev[-1].val)
            curr = []
            for node in prev:
                if node.left:
                    curr.append(node.left)
                if node.right:
                    curr.append(node.right)
            prev = curr
        
        return result
```

## Notes
- Level order traversal. In a perfect binary tree there will be `(n // 2) + 1` nodes in the bottom level.

## Solution 2

```
# Time: O(n)
# Space: O(n) if count result, O(h) if not
class Solution:
    def rightSideView(self, root: Optional[TreeNode]) -> List[int]:
        heights = set()
        result = []
        def rec(node, height):
            if node is None:
                return
            if height not in heights:
                result.append(node.val)
            heights.add(height)
            rec(node.right, height + 1)
            rec(node.left, height + 1)
        rec(root, 1)
        return result
```

## Notes
- Preorder traversal but visit right first instead of left to get right side viewed nodes, recording heights as we go to prioritize rightmost nodes.