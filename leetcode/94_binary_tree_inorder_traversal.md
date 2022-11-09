# 94. Binary Tree Inorder Traversal - Easy

Given the `root` of a binary tree, return the inorder traversal of its nodes' values.

##### Example 1:

```
Input: root = [1,null,2,3]
Output: [1,3,2]
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
# Space: O(n)
class Solution:
    def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        result = []
        def rec(node):
            if node is None:
                return
            rec(node.left)
            result.append(node.val)
            rec(node.right)
        
        rec(root)
        return result
```

## Notes

- If the binary tree were balanced the space complexity would be `O(log(n))`, but its not, so in the worst case the binary tree is basically just a linked list and there would be at most `n` calls on the call stack as the algorithm runs.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        result, stack = [], [(root, False)]
        while stack:
            curr, visited = stack.pop()
            if curr is None:
                continue
            
            if visited:
                result.append(curr.val)
            else:
                stack.append((curr.right, False))
                stack.append((curr, True))
                stack.append((curr.left, False))
        
        return result
```

## Notes
- Non-trivial to iteratively imitate call stack behavior for a binary tree traversal, which is the main challenge to doing this problem iteratively.