# 270. Closest Binary Search Tree Value - Easy

Given the `root` of a binary search tree and a `target` value, return the value in the BST that is closest to the `target`.

##### Example 1:

```
Input: root = [4,2,5,1,3], target = 3.714286
Output: 4
```

##### Example 2:

```
Input: root = [1], target = 4.428571
Output: 1
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- <code>0 <= Node.val <= 10<sup>9</sup></code>
- <code>-10<sup>9</sup> <= target <= 10<sup>9</sup></code>

## Solution

```
# Time: O(h)
# Space: O(h)
class Solution:
    def closestValue(self, root: Optional[TreeNode], target: float) -> int:
        result = inf
        def rec(node):
            if node is None:
                return
            
            nonlocal result
            diff = abs(node.val - target)
            if abs(result - target) > diff:
                result = node.val
                if diff < 0.5:
                    return
                
            if target < node.val:
                rec(node.left)
            else:
                rec(node.right)
            
        rec(root)
        return result
```

## Notes
- Pretty straightforward, could also be done iteratively. We check for `diff` being less than a half because node values are integers, would need to check for `diff == 0` if this wasn't the case.