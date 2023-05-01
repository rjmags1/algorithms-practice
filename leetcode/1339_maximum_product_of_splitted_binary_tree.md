# 1339. Maximum Product of Splitted Binary Tree - Medium

Given the `root` of a binary tree, split the binary tree into two subtrees by removing one edge such that the product of the sums of the subtrees is maximized.

Return the maximum product of the sums of the two subtrees. Since the answer may be too large, return it modulo <code>10<sup>9</sup> + 7</code>.

Note that you need to maximize the answer before taking the mod and not after taking it.

##### Example 1:

```
Input: root = [1,2,3,4,5,6]
Output: 110
Explanation: Remove the red edge and get 2 binary trees with sum 11 and 10. Their product is 110 (11*10)
```

##### Example 2:

```
Input: root = [1,null,2,3,4,null,null,5,6]
Output: 90
Explanation: Remove the red edge and get 2 binary trees with sum 15 and 6.Their product is 90 (15*6)
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[2, 5 * 10<sup>4</sup>]</code>.
- <code>1 <= Node.val <= 10<sup>4</sup></code>

## Solution

```
from collections import defaultdict

# Time: O(n)
# Space: O(n)
class Solution:
    def maxProduct(self, root: Optional[TreeNode]) -> int:
        sums = defaultdict(int)
        def getsums(node):
            nonlocal sums
            sums[node] = node.val
            if node.left:
                sums[node] += getsums(node.left)
            if node.right:
                sums[node] += getsums(node.right)
            return sums[node]

        total, M = getsums(root), 10 ** 9 + 7
        return max((total - s) * s for n, s in sums.items() if n != root) % M
```

## Notes
- Pretty easy if familiar with tree problems and are using a language like Python that supports arbitrarily large integers. 