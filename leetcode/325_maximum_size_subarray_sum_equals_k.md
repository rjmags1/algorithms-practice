# 325. Maximum Size Subarray Sum Equals K - Medium

Given an integer array `nums` and an integer `k`, return the maximum length of a subarray that sums to `k`. If there is not one, return `0` instead.

##### Example 1:

```
Input: nums = [1,-1,5,-2,3], k = 3
Output: 4
Explanation: The subarray [1, -1, 5, -2] sums to 3 and is the longest.
```

##### Example 2:

```
Input: nums = [-2,-1,2,1], k = 1
Output: 2
Explanation: The subarray [-1, 2] sums to 1 and is the longest.
```

##### Constraints:

- <code>1 <= nums.length <= 2 * 10<sup>5</sup></code>
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>
- <code>-10<sup>9</sup> <= k <= 10<sup>9</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def maxSubArrayLen(self, nums: List[int], k: int) -> int:
        pre = {0: -1}
        curr = result = 0
        for i, num in enumerate(nums):
            curr += num
            diff = curr - k
            if diff in pre:
                result = max(result, i - pre[diff])
            if curr not in pre:
                pre[curr] = i
        return result
```

## Notes
- Combine concept of prefix sum with hashing. The difference between prefix sums yields the sum for subarrays that are not prefixes. If we store all prefix sums in a hash table as we iterate we can look up relevant diffs in constant time. Note how we only store the index of the earliest occurrence of a particular prefix sum in `pre`.