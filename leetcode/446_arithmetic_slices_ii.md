# 446. Arithmetic Slices II - Hard

Given an integer array `nums`, return the number of all the arithmetic subsequences of `nums`.

A sequence of numbers is called arithmetic if it consists of at least three elements and if the difference between any two consecutive elements is the same.

- For example, `[1, 3, 5, 7, 9]`, `[7, 7, 7, 7]`, and `[3, -1, -5, -9]` are arithmetic sequences.
- For example, `[1, 1, 2, 5, 7]` is not an arithmetic sequence.

A subsequence of an array is a sequence that can be formed by removing some elements (possibly none) of the array.

- For example, `[2,5,10]` is a subsequence of `[1,2,1,2,4,1,5,10]`.

The test cases are generated so that the answer fits in 32-bit integer.

##### Example 1:

```
Input: nums = [2,4,6,8,10]
Output: 7
Explanation: All arithmetic subsequence slices are:
[2,4,6]
[4,6,8]
[6,8,10]
[2,4,6,8]
[4,6,8,10]
[2,4,6,8,10]
[2,6,10]
```

##### Example 2:

```
Input: nums = [7,7,7,7,7]
Output: 16
Explanation: Any subsequence of this array is arithmetic.
```

##### Constraints:

- <code>1  <= nums.length <= 1000</code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>

## Solution

```
from collections import defaultdict

# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def numberOfArithmeticSlices(self, nums: List[int]) -> int:
        dp = [defaultdict(int) for num in nums]
        result = 0
        for i in range(1, len(nums)):
            for j in range(i):
                diff = nums[i] - nums[j]
                if diff in dp[j]:
                    result += dp[j][diff]
                    dp[i][diff] += 1 + dp[j][diff]
                else:
                    dp[i][diff] += 1
        return result
```

## Notes
- Deceptively tricky to work out the recurrence relation for this problem. The number of arithmetic subsequences of length at least `3` that end at a particular index `i` with a particular difference depends on the number of arithmetic subsequences of any length `> 1` that end at all indices before `i`, with equivalent difference. The algorithm only adds arithmetic sequences of length `> 2` to the result, and represents the idea that we form new arithmetic sequences of desired length by appending the element at `i` to arithmetic sequences of length `>= 2` before it. We use dp to cache the number of lengths of arithmetic subsequences of length `>= 2` of various diffs for all `j` such that `j < i`.