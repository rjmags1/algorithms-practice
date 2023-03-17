# 974. Subarray Sums Divisible by K - Medium

Given an integer array `nums` and an integer `k`, return the number of non-empty subarrays that have a sum divisible by `k`.

A subarray is a contiguous part of an array.

##### Example 1:

```
Input: nums = [4,5,0,-2,-3,1], k = 5
Output: 7
Explanation: There are 7 subarrays with a sum divisible by k = 5:
[4, 5, 0, -2, -3, 1], [5], [5, 0], [5, 0, -2, -3], [0], [0, -2, -3], [-2, -3]
```

##### Example 2:

```
Input: nums = [5], k = 9
Output: 0
```

##### Constraints:

- <code>1 <= nums.length <= 3 * 10<sup>4</sup></code>
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>
- <code>2 <= k <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n + k)
# Space: O(k)
class Solution:
    def subarraysDivByK(self, nums: List[int], k: int) -> int:
        remainders = [0] * k
        remainders[0] = 1
        result = s = 0
        for num in nums:
            s += num
            result += remainders[s % k]
            remainders[s % k] += 1
        return result
```

## Notes
- Whenever a prefix of `nums` has a prefix sum remainder equivalent to a prefix sum remainder previously seen when traversing the array, there is a subarray whose sum is divisible by `k`.