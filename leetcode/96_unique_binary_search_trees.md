# 96. Unique Binary Search Trees - Medium

Given an integer `n`, return the number of structurally unique BST's (binary search trees) which has exactly `n` nodes of unique values from `1` to `n`.

<img src="../assets/uniquebstn3.jpg"/>

##### Example 1:

```
Input: n = 3
Output: 5
```

##### Example 2:

```
Input: n = 1
Output: 1
```

##### Constraints:

- `1 <= n <= 19`

## Solution 1

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def numTrees(self, n: int) -> int:
        memo = {}
        def count(start, stop):
            if stop - start in memo:
                return memo[stop - start]
            
            if start > stop:
                return 0
            if start == stop:
                return 1
            
            result = 0
            for root in range(start, stop + 1):
                lsts = count(start, root - 1)
                rsts = count(root + 1, stop)
                if not lsts:
                    result += rsts
                elif not rsts:
                    result += lsts
                else:
                    result += lsts * rsts
            
            memo[stop - start] = result
            return result
        
        return count(1, n)
```

## Notes
- The key to understanding this problem and 95. is seeing that for a particular value `r` that is the root of a subtree, if there are `x` nodes available for use in the left subtree, and `y` nodes available for use in the right subtree, there are `x * y` possible structurally unique subtrees that can be made with `x` as a root. This holds because we have `n` nodes with values in the range of `[1, n]` and we are building a binary search tree. For any given root, the nodes in its left subtree and in its right subtree will be subranges of consecutive numbers less than or greater than the root.
- Since we don't have to actually build the subtrees, we can memoize on the difference between node value ranges because that is what is important in this question. I.e., if we are building with nodes that have values `[1, 2, 3]` vs. `[7, 8, 9]`, it doesn't matter what their values are, what matters is the number of nodes we have to play with. With `3` nodes, you can only make `5` structurally unique BSTs. This caching improves the time complexity to `O(n^2)` because we will only ever consider `n` range lengths once, and for each range length we have an `O(n)` for loop.

## Solution 2

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def numTrees(self, n: int) -> int:
        dp = [0] * (n + 1)
        dp[0] = dp[1] = 1
        for nodes in range(2, n + 1):
            for lstnodes in range(nodes):
                rstnodes = nodes - 1 - lstnodes
                dp[nodes] += dp[lstnodes] * dp[rstnodes]
        return dp[n]
```

## Notes
- This is the same idea described in above notes but implemented bottom-up iteratively. The above solution is top-down recursive. Both are dp, though, because subproblems overlap such that smaller ones can always be used to solve bigger ones.