# 501. Find Mode in Binary Search Tree - Easy

Given the `root` of a binary search tree (BST) with duplicates, return all the mode(s) (i.e., the most frequently occurred element) in it.

If the tree has more than one mode, return them in any order.

Assume a BST is defined as follows:

- The left subtree of a node contains only nodes with keys less than or equal to the node's key.
- The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
- Both the left and right subtrees must also be binary search trees.


##### Example 1:

![](assets/501-tree.jpg)

```
Input: root = [1,null,2,2]
Output: [2]
```

##### Example 2:

```
Input: root = [0]
Output: [0]
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- <code>-10<sup>5</sup> <= Node.val <= 10<sup>5</sup></code>

Follow-up: Could you do that without using any extra space? (Assume that the implicit stack space incurred due to recursion does not count).

## Solution

```
# Time: O(n)
# Space: O(h)
class Solution:
    def findMode(self, root: Optional[TreeNode]) -> List[int]:
        prev, currfreq, maxfreq, result = None, 0, 0, []
        def finder(node, targetfreq=None):
            nonlocal prev, currfreq, maxfreq
            if node is None:
                return

            finder(node.left, targetfreq)
            currfreq = 1 if prev != node.val else currfreq + 1
            if targetfreq is None:
                maxfreq = max(maxfreq, currfreq)
            elif currfreq == targetfreq:
                result.append(node.val)
            prev = node.val
            finder(node.right, targetfreq)
        
        finder(root)
        prev, currfreq = None, 0
        finder(root, maxfreq)
        return result
```

## Notes
- Inorder traversal of BST yields sorted order of node values. This solution addresses the followup; we need `2` passes to find the mode value in the BST if the only auxiliary space we want to use is stack space for tree traversal.