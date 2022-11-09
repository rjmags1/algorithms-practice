# 145. Binary Tree Postorder Traversal - Easy

Given the `root` of a binary tree, return the postorder traversal of its nodes' values.

##### Example 1:

```
Input: root = [1,null,2,3]
Output: [3,2,1]
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

- The number of the nodes in the tree is in the range [0, 100].
- -100 <= Node.val <= 100

Follow-up: Recursive solution is trivial, could you do it iteratively?

## Solution 1

```
# Time: O(n)
# Space: O(n), O(log(n)) if the tree is balanced
class Solution:
    def postorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        result = []
        def rec(node):
            if node is None:
                return
            
            rec(node.left)
            rec(node.right)
            result.append(node.val)
        
        rec(root)
        return result
```

## Notes
- The extra space comes from the recursive call stack.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def postorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        result, stack = [], [(root, False)]
        while stack:
            curr, visited = stack.pop()
            if curr is None:
                continue
                
            if visited:
                result.append(curr.val)
            else:
                stack.append((curr, True))
                stack.append((curr.right, False))
                stack.append((curr.left, False))
        return result
```

## Notes
- Here we keep track of if a node has been visited, and only add it to the result once it (and its children) have been visited, per definition of postorder traversal.