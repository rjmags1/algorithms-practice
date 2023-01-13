# 494. Target Sum - Medium

You are given an integer array `nums` and an integer `target`.

You want to build an expression out of nums by adding one of the symbols `'+'` and `'-'` before each integer in nums and then concatenate all the integers.

- For example, if `nums = [2, 1]`, you can add a `'+'` before 2 and a `'-'` before `1` and concatenate them to build the expression `"+2-1"`.

Return the number of different expressions that you can build, which evaluates to `target`.

##### Example 1:

```
Input: nums = [1,1,1,1,1], target = 3
Output: 5
Explanation: There are 5 ways to assign symbols to make the sum of nums be target 3.
-1 + 1 + 1 + 1 + 1 = 3
+1 - 1 + 1 + 1 + 1 = 3
+1 + 1 - 1 + 1 + 1 = 3
+1 + 1 + 1 - 1 + 1 = 3
+1 + 1 + 1 + 1 - 1 = 3
```

##### Example 2:

```
Input: nums = [1], target = 1
Output: 1
```

##### Constraints:

- `1 <= nums.length <= 20`
- `0 <= nums[i] <= 1000`
- `0 <= sum(nums[i]) <= 1000`
- `-1000 <= target <= 1000`

## Solution

```
from functools import cache

# Time: O(r * n * n) where 2 * r * n is range of possible subexpression values
# Space: O(r * n * n)
class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        n = len(nums)
        postsums = [0] * n
        for i, num in enumerate(reversed(nums)):
            postsums[n - i - 1] = num if i == 0 else postsums[n - i] + num

        @cache
        def rec(i, curr):
            if i == n:
                return int(curr == target)
            
            add = sub = 0
            if curr + postsums[i] >= target:
                add = rec(i + 1, curr + nums[i])
            if curr - postsums[i] <= target:
                sub = rec(i + 1, curr - nums[i])
            return add + sub
        
        return rec(0, 0)
```

## Notes
- Enumerate all possible expressions with memoization, search prune using postfix sums to avoid extra recursive calls on expressions that already have a value too low or too high to result in a final expression of `n` numbers that evaluates to `target`. 
- Without memoization, the time complexity would be `O(2^n)` which is roughly `O(10^6)` for `n = 20`, and is reasonable, but leetcode wants people to understand memoization and so the non-memoization approach is not allowed to pass. When we add memoization, we avoid redundant calls by only computing all combinations of `(i, curr=subexprval)` once. The range of possible subexpression values is `[-1000 * n, 1000 * n]`, which amounts to `40001` possible subexpression values in the worst case and so `800002` ~ `O(10^6)` possible `(i, curr)` when `n == 20`. So memoization shouldn't really make a difference in the worst case but LC test cases make it.