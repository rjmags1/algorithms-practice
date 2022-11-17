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
# Time: O((2n)! / ((n + 1)! * n!) * n)
# Space: O((2n)! / ((n + 1)! * n!) * n)
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
- This is another Catalan number question. Notice how the answers for different possible `n` values stagger with the catalan number sequence, which is `(1, 1, 2, 5, 14, 42, 132, ...)`. For `n = 1`, there is `1` tree generated, for `n = 2`, there are `2` trees generated, for `n = 3`, there are `5` trees generated, and so on.
- It can be hard to discern what pattern the prompt is trying to get after by 'structurally unique bsts' so looking at the picture is helpful.
- Note that use of memoization via python `@cache` decorator would greatly speed up runtime for larger inputs, but it also creates shared subtree references between larger trees. The leetcode judge doesn't care about that but from an engineering perspective this is not best practice.
- This solution uses a topdown approach to build all structurally unique subtrees. __To build structurally unique subtrees with nodes whose values are in the range `[start, stop]`, we will need to consider each value in that range as the root, and then get all unique subtrees for that node as root.__ The base case for `start == stop` is to return a single leaf node, and if `start > stop` we would need to return `None`. 
- With those base cases in mind and the general pattern of top-down tree construction in mind, it is not really worth overthinking how this works, beyond walking through a few examples and observing other problems in which we build trees in a similar topdown manner.