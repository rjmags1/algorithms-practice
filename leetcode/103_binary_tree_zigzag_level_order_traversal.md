# 103. Binary Tree Level Order Traversal - Medium

Given the `root` of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between).

##### Example 1:

```
Input: root = [3,9,20,null,null,15,7]
Output: [[3],[20,9],[15,7]]
```

##### Example 2:

```
Input: root = [3,9,20,null,null,15,7]
Output: [[3],[20,9],[15,7]]
```

##### Example 3:

```
Input: root = []
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 2000]`.
- `-100 <= Node.val <= 100`

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def zigzagLevelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if root is None:
            return []
        
        pi, curr, prev, result = 0, [], [root], []
        while prev:
            result.append([])
            n = len(prev)
            for i, parent in enumerate(prev):
                if pi & 1:
                    result[-1].append(prev[n - 1 - i].val)
                else:
                    result[-1].append(parent.val)
                    
                if parent.left:
                    curr.append(parent.left)
                if parent.right:
                    curr.append(parent.right)
            prev, curr = curr, []
            pi += 1
        
        return result
```

## Notes
- This is very similar to 102. Binary Tree Level Order Traversal. The only difference is every other row needs to have its node's values reversed in `result`. To achieve this, whenever the index of the row of parents we are adding to `result` is odd, we add that row's nodes to `result[-1]` in reverse order. We always add the children of the current `prev` to `curr` in LTR order, however.
- This is more efficient than doing plain level-order traversal and then reversing every other list prior to returning - adding in reverse order straightaway helps us avoid extra level passes for reversing.