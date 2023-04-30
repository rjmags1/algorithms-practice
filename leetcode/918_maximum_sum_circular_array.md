# 918. Maximum Sum Circular Array - Medium

Given a circular integer array `nums` of length `n`, return the maximum possible sum of a non-empty subarray of `nums`.

A circular array means the end of the array connects to the beginning of the array. Formally, the next element of `nums[i]` is `nums[(i + 1) % n]` and the previous element of `nums[i]` is `nums[(i - 1 + n) % n]`.

A subarray may only include each element of the fixed buffer `nums` at most once. Formally, for a subarray `nums[i], nums[i + 1], ..., nums[j]`, there does not exist `i <= k1, k2 <= j` with `k1 % n == k2 % n`.

##### Example 1:

```
Input: nums = [1,-2,3,-2]
Output: 3
Explanation: Subarray [3] has maximum sum 3.
```

##### Example 2:

```
Input: nums = [5,-3,5]
Output: 10
Explanation: Subarray [5,5] has maximum sum 5 + 5 = 10.
```

##### Example 3:

```
Input: nums = [-3,-2,-3]
Output: -2
Explanation: Subarray [-2] has maximum sum -2.
```

##### Constraints:

- <code>n == nums.length</code>
- <code>1 <= n <= 3 * 10<sup>4</sup></code>
- <code>-3 * 10<sup>4</sup> <= nums[i] <= 3 * 10<sup>4</sup></code>

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def maxSubarraySumCircular(self, nums: List[int]) -> int:
        n = len(nums)
        maxpre, maxsuff = [0] * n, [0] * n
        currpre = currsuff = 0
        for i in range(n):
            currpre += nums[i]
            currsuff += nums[n - i - 1]
            maxpre[i] = currpre if i == 0 else max(currpre, maxpre[i - 1])
            maxsuff[n - i - 1] = currsuff if i == 0 else max(currsuff, maxsuff[n - i])
        result = kadane = nums[0]
        for i in range(1, n):
            if i < n - 1:
                result = max(maxpre[i - 1] + maxsuff[i + 1], result)
            if kadane + nums[i] < nums[i]:
                kadane = nums[i]
            else:
                kadane += nums[i]
            result = max(result, kadane)
        return result
```

## Notes
- If we view this problem as finding the max sum of a non-circular subarray (kadane's) and the max sum of a prefix and suffix before and after a particular index, we can solve it easily. The tricky part is realizing how the circular array issue translates into these two subproblems.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def maxSubarraySumCircular(self, nums: List[int]) -> int:
        maxkadane = minkadane = nums[0]
        s = currmax = currmin = nums[0]
        for i in range(1, len(nums)):
            currmax = nums[i] if nums[i] > nums[i] + currmax else nums[i] + currmax
            currmin = nums[i] if nums[i] < nums[i] + currmin else nums[i] + currmin
            maxkadane, minkadane = max(maxkadane, currmax), min(minkadane, currmin)
            s += nums[i]
        result = maxkadane
        if s != minkadane:
            result = max(result, s - minkadane)
        return result
```

## Notes
- We can improve upon space by realizing that the max sum of a prefix and suffix not including a particular index is the same as finding the minimum non-circular subarray sum and subtracting it from the sum of all elements in the array. This can be determined with the typical kadane approach. Be careful of edge case where the minimum subarray sum is the sum of all elements! 