# 1802. Maximum Value at a Given Index in a Bounded Array - Medium

You are given three positive integers: `n`, `index`, and `maxSum`. You want to construct an array `nums` (0-indexed) that satisfies the following conditions:

- `nums.length == n`
- `nums[i]` is a positive integer where `0 <= i < n`.
- `abs(nums[i] - nums[i+1]) <= 1` where `0 <= i < n-1`.
- The sum of all the elements of `nums` does not exceed `maxSum`.
- `nums[index]` is maximized.

Return `nums[index]` of the constructed array.

Note that `abs(x)` equals `x` if `x >= 0`, and `-x` otherwise.

##### Example 1:

```
Input: n = 4, index = 2,  maxSum = 6
Output: 2
Explanation: nums = [1,2,2,1] is one array that satisfies all the conditions.
There are no arrays that satisfy all the conditions and have nums[2] == 3, so 2 is the maximum nums[2].
```

##### Example 2:

```
Input: n = 6, index = 1,  maxSum = 10
Output: 3
```

##### Constraints:

- <code>1 <= n <= maxSum <= 10<sup>9</sup></code>
- <code>0 <= index < n</code>

## Solution

```
# Time: O(log(maxSum))
# Space: O(1)
class Solution:
    def gauss_sum_formula(self, seq_len):
        # calc sum(1...seqlen)
        s = (1 + seq_len) * (seq_len // 2)
        return s + seq_len // 2 + 1 if seq_len & 1 else s

    def maxValue(self, n: int, index: int, maxSum: int) -> int:
        # 1, 2, 3, 4, 5, 6
        # index = 4
        # [1, 1, 1, 2, 3, 2]
        # [2, 3, 2, 1, 1, 1]
        # left_peak_dist = min(peak, index + 1)
        # right_peak_dist = min(peak, n - index)
        # left_peak_sum = gauss_sum_formula(peak) - gauss_sum_formula(peak - left_peak_dist)
        # right_peak_sum = gauss_sum_formula(peak) - gauss_sum_formula(peak - right_peak_dist)
        # peak_sum = left_peak_sum + right_peak_sum - peak
        # arr_sum = peak_sum + n - (left_peak_dist + right_peak_dist - 1)
        # binary search [1, maxSum] for peak
        l, r = 1, maxSum
        while l <= r:
            peak = (l + r) // 2
            left_peak_dist = min(peak, index + 1)
            right_peak_dist = min(peak, n - index)
            peak_sum = self.gauss_sum_formula(peak)
            left_peak_sum = peak_sum - self.gauss_sum_formula(peak - left_peak_dist)
            right_peak_sum = peak_sum - self.gauss_sum_formula(peak - right_peak_dist)
            peak_sum = left_peak_sum + right_peak_sum - peak
            ones = n - (left_peak_dist + right_peak_dist - 1)
            arr_sum = peak_sum + ones
            if arr_sum == maxSum:
                return peak
            if arr_sum < maxSum:
                l = peak + 1
            else:
                r = peak - 1

        return r
```

## Notes
- This solution passes but after submitting and passing I think it is probably possible to achieve higher peak values while sticking to prompt constraints with arrays that do not conform to the examples (i.e., allowing for negatives to take the place of non-slope `1`s in my below logic). Maybe such results would pass the test cases, maybe not, but either way below is how I thought about the problem and the resulting solution passes on LC as of the day of writing.
- With a bit of consideration we can see that the array containing the maximum `nums[index]` will have a single peak with maximized `nums[index]` as the peak value, and a decreasing slope of 1 on either side of the peak. All non-peak values, if any, would be equal to `1`. We can use summation sequence logic and basic intuition to figure out the distance of the slopes and thus the sum of the slope subarrays, as well as the sum of non-slope `1`s in the array, and thus the sum of an array with a given `peak`. We can binary search the range of possible `peak` values `[1, maxSum]`, and return the max `peak` value for which the resulting array sums to `<= maxSum`.