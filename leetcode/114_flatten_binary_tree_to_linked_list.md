# 114. Flatten Binary Tree to Linked List - Medium

Given the `root` of a binary tree, flatten the tree into a "linked list":

- The "linked list" should use the same `TreeNode` class where the `right` child pointer points to the next node in the list and the `left` child pointer is always `null`.
- The "linked list" should be in the same order as a pre-order traversal of the binary tree.

##### Example 1:

```
Input: root = [1,2,5,3,4,null,6]
Output: [1,null,2,null,3,null,4,null,5,null,6]
```

##### Example 2:

```
Input: root = []
Output: []
```

##### Example 3:

```
Input: root = [0]
Output: [0]
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 2000]`.
- `-100 <= Node.val <= 100`

Follow-up: Can you flatten the tree in-place (with `O(1)` extra space)?

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def flatten(self, root: Optional[TreeNode]) -> None:
        """
        Do not return anything, modify root in-place instead.
        """
        if root is None:
            return
        
        def rec(node):
            if not node.left and not node.right:
                return node, node
            
            if node.left and node.right:
                flh, flt = rec(node.left)
                frh, frt = rec(node.right)
                node.left = None
                node.right = flh
                flt.right = frh
                return node, frt
            
            if node.left:
                flh, flt = rec(node.left)
                node.left = None
                node.right = flh
                return node, flt
            
            if node.right:
                frh, frt = rec(node.right)
                node.left = None
                node.right = frh
                return node, frt
            
        return rec(root)[0]
```

## Notes
- The first time I attempted this problem I overlooked the simple recurrence relation obvious in the example and tried to do figure out a Morris Traversal-esque approach.
- To flatten a binary tree as described in the prompt, all one needs to do is recursively flatten the left and right subtrees, and then point `node.right` to the head of the flattened left subtree, and then point the `tail.right` of the flattened left subtree to the head of the flattened right subtree. We also need to remember to set the `node.left` to `None` for every node in the tree.