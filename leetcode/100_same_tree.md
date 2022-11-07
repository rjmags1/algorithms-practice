# 100. Same Tree - Easy

Given the roots of two binary trees `p` and `q`, write a function to check if they are the same or not.

Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

##### Example 1:

```
Input: p = [1,2,3], q = [1,2,3]
Output: true
```

##### Example 2:

```
Input: p = [1,2], q = [1,null,2]
Output: false
```

##### Example 3:

```
Input: p = [1,2,1], q = [1,1,2]
Output: false
```

##### Constraints:

- The number of nodes in both trees is in the range `[0, 100]`.
- <code>-10<sup>4</sup> <= Node.val <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        if p is None or q is None:
            return p is None and q is None
        if p.val != q.val:
            return False
        return self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)
```

## Notes
- Recursive

## Solution

```
# Time: O(n)
# Space: O(n) (O(log(n)) if tree is balanced)
class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        stack1, stack2 = [None], [None]
        curr1, curr2 = p, q
        while curr1 and curr2:
            if curr1.left or curr2.left: # go to leftmost child
                stack1.append(curr1)
                stack2.append(curr2)
                curr1, curr2 = curr1.left, curr2.left
                continue
            
            while curr1 and curr2: 
                if curr1.val != curr2.val: # visit
                    return False
                if curr1.right or curr2.right: # go to right child if any
                    curr1, curr2 = curr1.right, curr2.right
                    break
                curr1, curr2 = stack1.pop(), stack2.pop() # otherwise go back up tree
                
        
        return curr1 is curr2 is None
```

## Notes
- Iterative