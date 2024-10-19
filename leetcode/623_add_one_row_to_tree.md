# 623. Add One Row to Tree - Medium

Given the `root` of a binary tree and two integers `val` and `depth`, add a row of nodes with value `val` at the given depth `depth`.

Note that the `root` node is at depth `1`.

The adding rule is:

- Given the integer `depth`, for each not null tree node `cur` at the depth `depth - 1`, create two tree nodes with value `val` as `cur`'s left subtree root and right subtree root.
- `cur`'s original left subtree should be the left subtree of the new left subtree root.
- `cur`'s original right subtree should be the right subtree of the new right subtree root.
- If `depth == 1` that means there is no depth `depth - 1` at all, then create a tree node with value `val` as the new root of the whole original tree, and the original tree is the new root's left subtree.


##### Example 1:

![](../assets/623_addrow-tree.jpg)

```
Input: root = [4,2,6,3,1,5], val = 1, depth = 2
Output: [4,1,1,2,null,null,6,3,1,5]
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- The depth of the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- `-100 <= Node.val <= 100`
- <code>-10<sup>5</sup> <= val <= 10<sup>5</sup></code>
- `1 <= depth <= the depth of tree + 1`

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def addOneRow(self, root: Optional[TreeNode], val: int, depth: int) -> Optional[TreeNode]:
        if depth == 1:
            return TreeNode(val, root, None)
        
        curr_depth = 1
        q = deque([root])
        while q:
            in_level = len(q)
            if curr_depth < depth - 1:
                for _ in range(in_level):
                    node = q.popleft()
                    if node.left:
                        q.append(node.left)
                    if node.right:
                        q.append(node.right)
                curr_depth += 1
                continue
            
            for _ in range(in_level):
                parent = q.popleft()
                parent.left = TreeNode(val, parent.left, None)
                parent.right = TreeNode(val, None, parent.right)
                
        return root
```

## Notes
- BFS