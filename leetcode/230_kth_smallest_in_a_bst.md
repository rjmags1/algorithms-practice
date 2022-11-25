# 230. Kth Smallest in a BST - Medium

Given the `root` of a binary search tree, and an integer `k`, return the `kth` smallest value (1-indexed) of all the values of the nodes in the tree.

##### Example 1:

```
Input: root = [3,1,4,null,2], k = 1
Output: 1
```

##### Example 2:

```
Input: root = [5,3,6,2,4,null,null,1], k = 3
Output: 3
```

##### Constraints:

- The number of nodes in the tree is `n`.
- <code>1 <= k <= n <= 10<sup>4</sup></code>
- <code>0 <= Node.val <= 10<sup>4</sup></code>

Follow-up: If the BST is modified often (i.e., we can do insert and delete operations) and you need to find the kth smallest frequently, how would you optimize?

## Solution 1

```
# Time: O(h + k)
# Space: O(h)
class Solution:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        result = None
        foundleftmost = False
        counter = 0
        def rec(node):
            nonlocal foundleftmost, counter, result
            if result is not None:
                return
            
            if node.left:
                rec(node.left)
            elif foundleftmost is False:
                foundleftmost = True
                
            if foundleftmost:
                counter += 1
                if counter == k:
                    result = node.val
                    
            if node.right:
                rec(node.right)
                
        rec(root)
        return result
```

## Notes
- Recursive. The leftmost node in a BST is the smallest node in the tree. Once we reach it, we can start counting up to `k`. Once we reach `k`, we save its value to a global variable and return early on any other recursive calls since there is no point in recursing further.

## Solution 2

```
# Time: O(h + k)
# Space: O(h)
class Solution:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        result, foundleftmost, counter = None, False, 0
        stack = [(root, False)]
        while stack:
            curr, visited = stack.pop()
            if visited:
                if foundleftmost:
                    counter += 1
                    if counter == k:
                        return curr.val
                continue
                
            if curr.right:
                stack.append((curr.right, False))
            stack.append((curr, True))
            if curr.left:
                stack.append((curr.left, False))
            elif foundleftmost is False:
                foundleftmost = True
```

## Notes
- Iterative. 