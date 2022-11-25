# 285. Inorder Successor in BST - Medium

Given the `root` of a binary search tree and a node `p` in it, return the in-order successor of that node in the BST. If the given node has no in-order successor in the tree, return `null`.

The successor of a node `p` is the node with the smallest key greater than `p.val`.

##### Example 1:

```
Input: root = [2,1,3], p = 1
Output: 2
Explanation: 1's in-order successor node is 2. Note that both p and the return value is of TreeNode type.
```

##### Example 2:

```
Input: root = [5,3,6,2,4,null,null,1], p = 6
Output: null
Explanation: There is no in-order successor of the current node, so the answer is null.
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- <code>-10<sup>5</sup> <= Node.val <= 10<sup>5</sup></code>
- All `Nodes` will have unique values.

## Solution 1

```
# Time: O(h)
# Space: O(h)
class Solution:
    def inorderSuccessor(self, root: TreeNode, p: TreeNode) -> Optional[TreeNode]:
        prev, curr = None, root
        parents = {root.val: None}
        while curr != p:
            prev = curr
            curr = curr.left if p.val < curr.val else curr.right
            parents[curr.val] = prev
        
        if p.right:
            successor = p.right
            while successor.left:
                successor = successor.left
            return successor
        
        if parents[p.val] and parents[p.val].left == p:
            return parents[p.val]
        
        curr = parents[p.val]
        while curr and parents[curr.val]:
            if parents[curr.val].left == curr:
                return parents[curr.val]
            curr = parents[curr.val]
        return None
```

## Notes
- A more intuitive approach than the optimal constant space solution, that follows the logic of inorder traversal. Could also use a stack instead of a `parents` dictionary. If a node has a right child, its successor will always be the leftmost descendant of the right child. If it does not have a right child but is a left child, its successor will always be its parent. If it does not have a right child and is `root`, there is no successor. If it does not have a right child and is a right child itself, the successor will be its lowest ancestor that is a left child.

## Solution 2

```
# Time: O(h)
# Space: O(1)
class Solution:
    def inorderSuccessor(self, root: TreeNode, p: TreeNode) -> Optional[TreeNode]:
        curr = root
        result = None
        while curr:
            if curr.val > p.val:
                result = curr
                
            if p.val < curr.val:
                curr = curr.left
            else:
                curr = curr.right
        return result
```

## Notes
- Consider what happens when we search a BST for a value. The range of possible node values in the search space gets narrower and narrower, and it will contain `p.val` until we actually reach `p` and visit its children. Everytime we go left to get to `p`, that means we are currently at a node whose value is greater than `p.val`, so this might be our successor. Any nodes further down as we search for `p` but before we reach `p` that are greater than `p` will be considered and be closer to `p`. Once we reach `p`, we want to go right in case there are any nodes greater than `p` who are descendants of `p`. Once we go right past `p`, our algorithm will continue to search as if we hadn't seen `p`; and since we are in `p`s right subtree, this means it will the smallest node in `p`s right subtree, which is exactly what we want if `p` has a right child.