# 312. Burst Balloons - Hard

You are given `n` balloons, indexed from `0` to `n - 1`. Each balloon is painted with a number on it represented by an array `nums`. You are asked to burst all the balloons.

If you burst the `ith` balloon, you will get `nums[i - 1] * nums[i] * nums[i + 1]` coins. If `i - 1` or `i + 1` goes out of bounds of the array, then treat it as if there is a balloon with a `1` painted on it.

Return the maximum coins you can collect by bursting the balloons wisely.

##### Example 1:

```
Input: nums = [3,1,5,8]
Output: 167
Explanation:
nums = [3,1,5,8] --> [3,5,8] --> [3,8] --> [8] --> []
coins =  3*1*5    +   3*5*8   +  1*3*8  + 1*8*1 = 167
```

##### Example 2:

```
Input: nums = [1,5]
Output: 10
```

##### Constraints:

- `n == nums.length`
- `1 <= n <= 300`
- `0 <= nums[i] <= 100`

## Solution

```
# Time: O(n^3)
# Space: O(n^2)
class Solution:
    def maxCoins(self, nums: List[int]) -> int:
        n = len(nums)
        
        @cache
        def rec(i, j):
            if i > j:
                return 0
            
            result = 0
            for poplast in range(i, j + 1):
                poppedtoleft = rec(i, poplast - 1)
                poppedtoright = rec(poplast + 1, j)
                beforegain = poppedtoleft + poppedtoright
                leftbafter = 1 if i == 0 else nums[i - 1]
                rightbafter = 1 if j == n - 1 else nums[j + 1]
                nowgain = leftbafter * nums[poplast] * rightbafter
                result = max(result, beforegain + nowgain)
                
            return result
        
        return rec(0, n - 1)
```

## Notes
- Very tricky hard requiring knowledge of multiple CP paradigms: backwards thinking, divide and conquer, and dp. Dp is necessary to avoid considering all possible states during popping, which is factorial in nature. Backwards thinking is necessary because dp subproblems, which are typically subarray ranges for these sorts of problems, in the forward direction are not independent of each other; in other words, if we pop a balloon and then recurse forward to solve the left subproblem and the right subproblem, the outcomes of those subproblems will depend on each other. However, going backwards will work just fine, because if we reserve a particular balloon in a subproblem to be popped last, we can consider the left and right subarrays of the current subproblem independently, and we will always know what the left balloon and the right balloon relative to the current balloon will be once the left and right subproblems have been solved (and their associated balloons popped): whatever came before the left subproblem's range, and whatver came after the right subproblem's range.
- This problem is annoying because on top of it being conceptually non-beginner friendly, you don't get consistent passes with the conceptually optimal cubic time topdown solution because of weird LC testcases that require you to do trimming preprocessing on special input cases such as `[x, x, x, x, x, x, x, y, x, x, x]`, where long chains of balloons of the same value will give the same result regardless of the order in which they are popped.