# 538. Convert BST to Greater Tree - Medium

Given the `root` of a Binary Search Tree (BST), convert it to a Greater Tree such that every key of the original BST is changed to the original key plus the sum of all keys greater than the original key in BST.

As a reminder, a binary search tree is a tree that satisfies these constraints:

- The left subtree of a node contains only nodes with keys less than the node's key.
- The right subtree of a node contains only nodes with keys greater than the node's key.
- Both the left and right subtrees must also be binary search trees.


##### Example 1:

![](../assets/538-tree.png)

```
Input: root = [4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]
Output: [30,36,21,36,35,26,15,null,null,null,33,null,null,null,8]
```

##### Example 2:

```
Input: root = [0,null,1]
Output: [1,null,1]
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[0, 10<sup>4</sup>]</code>.
- <code>-10<sup>4</sup> <= Node.val <= 10<sup>4</sup></code>
- All the values in the tree are unique.
- `root` is guaranteed to be a valid binary search tree.

## Solution

```
# Time: O(n)
# Space: O(h)
class Solution:
    def convertBST(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if root is None:
            return root
            
        stack, s = [(root, False)], 0
        while stack:
            node, visited = stack.pop()
            if not visited:
                stack.append((node, True))
                if node.right:
                    stack.append((node.right, False))
            else:
                s += node.val
                node.val = s
                if node.left:
                    stack.append((node.left, False))
        return root
```

## Notes
- Iterative reverse inorder traversal to track postfix sums of sorted order node values.