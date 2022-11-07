# 95. Unique Binary Search Trees II - Medium

Given an integer `n`, return all the structurally unique BST's (binary search trees), which has exactly `n` nodes of unique values from `1` to `n`. Return the answer in any order.

<img src="../assets/uniquebstn3.jpg"/>

##### Example 1:

```
Input: n = 3
Output: [[1,null,2,null,3],[1,null,3,2],[2,1,3],[3,1,null,null,2],[3,2,null,1]]
```

##### Example 2:

```
Input: n = 1
Output: [[1]]
```

##### Constraints:

- `1 <= n <= 8`

## Solution

```
# Time: O((4^n)/sqrt(n))
# Space: O((4^n)/sqrt(n))
class Solution:
    def generateTrees(self, n: int) -> List[Optional[TreeNode]]:
        @cache
        def build(start, stop):
            if start > stop:
                return []
            if start == stop:
                return [TreeNode(start)]
            if start == stop - 1:
                return [TreeNode(start, None, TreeNode(stop)), TreeNode(stop, TreeNode(start), None)]
            
            result = []
            for root in range(start, stop + 1):
                lsts = build(start, root - 1)
                rsts = build(root + 1, stop)
                if not lsts:
                    for rst in rsts:
                        result.append(TreeNode(root, None, rst))
                elif not rsts:
                    for lst in lsts:
                        result.append(TreeNode(root, lst, None))
                else:
                    for lst in lsts:
                        for rst in rsts:
                            result.append(TreeNode(root, lst, rst))
            
            return result
        
        return build(1, n)
```

## Notes
- This is another Catalan number question. Notice how the answers for different possible `n` values stagger with the catalan number sequence, which is `(1, 1, 2, 5, 14, 42, 132, ...)`. For `n = 1`, there is `1` tree generated, for `n = 2`, there are `2` trees generated, for `n = 3`, there are `5` trees generated, and so on. Numbers in the catalan sequence grow according to <code>4<sup>k</sup>/(k<sup>3/2</sup>)</code>, and we generate `k = n` trees of size `n`, and so the final time and space complexity is <code>4<sup>k</sup>/(n<sup>1/2</sup>)</code>.
- It can be hard to discern what pattern the prompt is trying to get after by 'structurally unique bsts' so looking at the picture is helpful.
- Note that use of memoization via python `@cache` decorator would greatly speed up runtime for larger inputs, but it also creates cross-references between subtrees of larger trees. The leetcode judge doesn't care about that but from an engineering perspective this is not best practice.