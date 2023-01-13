# 437. Path Sum III - Medium

Given the `root` of a binary tree and an integer `targetSum`, return the number of paths where the sum of the values along the path equals `targetSum`.

The path does not need to start or end at the root or a leaf, but it must go downwards (i.e., traveling only from parent nodes to child nodes).

##### Example 1:

```
Input: root = [10,5,-3,3,2,null,11,3,-2,null,1], targetSum = 8
Output: 3
Explanation: The paths that sum to 8 are shown.
```

##### Example 2:

```
Input: root = [5,4,8,11,null,13,4,7,2,null,null,5,1], targetSum = 22
Output: 3
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 1000]`.
- <code>-10<sup>9</sup> <= Node.val <= 10<sup>9</sup></code>
- <code>-1000 <= targetSum <= 1000</code>

## Solution

```
from collections import defaultdict

# Time: O(n^2)
# Space: O(n)
class Solution:
    def pathSum(self, root: Optional[TreeNode], targetSum: int) -> int:
        result = 0
        def rec(node):
            if node is None:
                return {}

            nonlocal result
            lpsums = rec(node.left)
            rpsums = rec(node.right)
            if node.val == targetSum:
                result += 1
            diff = targetSum - node.val
            if diff in lpsums:
                result += lpsums[diff]
            if diff in rpsums:
                result += rpsums[diff]
            psums = defaultdict(int)
            psums[node.val] += 1
            for lps, freq in lpsums.items():
                psums[node.val + lps] += freq
            for rps, freq in rpsums.items():
                psums[node.val + rps] += freq
            return psums
        
        rec(root)
        return result
```

## Notes
- Determine the path sums ending at each node, for each node in the tree, to determine the number of path sums equivalent to `targetSum`.
- This solution could be optimized to linear time by realizing we do not need to recompute a new path sums frequency hash table for each node visit; we can use the idea of path prefix sums where prefixes start from `root`. To get the number of valid path sums `== targetSum` ending at a particular node, we need to consider the case where the full path sum `== targetSum` and the number of prefix path sums equal to full path sum minus `targetSum`.