# 101. Symmetric Tree - Easy

Given the `root` of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).

##### Example 1:

```
Input: root = [1,2,2,3,4,4,3]
Output: true
```

##### Example 2:

```
Input: root = [1,2,2,null,3,null,3]
Output: false
```

##### Constraints:


- The number of nodes in the tree is in the range `[1, 1000]`.
- `-100 <= Node.val <= 100`

Follow-up: Could you solve it both recursively and iteratively?

## Solution 1

```
# Time: O(n)
# Space: O(n) (O(log(n)) if tree is balanced)
class Solution:
    def isSymmetric(self, root: Optional[TreeNode]) -> bool:
        if not root:
            return True
        
        def rec(ln, rn):
            if ln is None or rn is None:
                return ln is None and rn is None
            return ln.val == rn.val and rec(ln.right, rn.left) and rec(ln.left, rn.right)
        
        return rec(root.left, root.right)
```

## Notes
- After looking at a few examples, it becomes clear that for a tree to be symmetric, its left subtree must recursively be symmetrical with its right subtree.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def isSymmetric(self, root: Optional[TreeNode]) -> bool:
        if root is None:
            return True
        
        done = False
        prev, curr = [root], []
        while prev:
            for parent in prev:
                if parent is None:
                    continue
                curr.append(parent.left)
                curr.append(parent.right)
            i, j = 0, len(curr) - 1
            while i < j:
                l, r = curr[i], curr[j]
                if l is None or r is None:
                    if not (l is None and r is None):
                        return False
                elif l.val != r.val:
                    return False
                i += 1
                j -= 1
            prev, curr = curr, []
        
        return True
```

## Notes
- We could do some tricks to get rid of the extra pass in the inner `while` loop, such as using indices in the inner `for` loop to check if the list of parents is palindromic, but this suffices. This is would be a level-order traversal of a binary tree, AKA BFS for a binary tree starting at `root`.