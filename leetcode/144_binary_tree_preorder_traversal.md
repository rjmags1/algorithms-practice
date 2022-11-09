# Title - Diff

Given the `root` of a binary tree, return the preorder traversal of its nodes' values.

##### Example 1:

```
Input: root = [1,null,2,3]
Output: [1,2,3]
```

##### Example 2:

```
Input: root = []
Output: []
```

##### Example 3:

```
Input: root = [1]
Output: [1]
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 100]`.
- `-100 <= Node.val <= 100`

Follow-up: Recursive solution is trivial, could you do it iteratively?

## Solution 1

```
# Time: O(n)
# Space: O(n) (O(log(n)) if tree is balanced)
class Solution:
    def preorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        result = []
        def rec(node):
            if node is None:
                return
            result.append(node.val)
            rec(node.left)
            rec(node.right)
        
        rec(root)
        return result
```

## Notes
- Preorder -> visit `node` before recursing on its children.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def preorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        result, stack = [], [root]
        while stack:
            curr = stack.pop()
            if curr is None:
                continue
            
            result.append(curr.val)
            stack.append(curr.right)
            stack.append(curr.left)
                
        return result
```

## Notes
- We imitate the behavior of the recursive call stack with our own stack. This is the cleanest implementation of this I have seen and most closely approximates the recursive call stack behavior. Note the order in which we append `curr.left` and `curr.right` to the stack.