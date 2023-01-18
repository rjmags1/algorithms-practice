# 523. Continuous Subarray Sum - Medium

Given an integer array `nums` and an integer `k`, return `true` if `nums` has a good subarray or `false` otherwise.

A good subarray is a subarray where:

- its length is at least two, and
- the sum of the elements of the subarray is a multiple of `k`.

Note that:

- A subarray is a contiguous part of the array.
- An integer `x` is a multiple of `k` if there exists an integer `n` such that `x = n * k`. `0` is always a multiple of `k`.

##### Example 1:

```
Input: nums = [23,2,4,6,7], k = 6
Output: true
Explanation: [2, 4] is a continuous subarray of size 2 whose elements sum up to 6.
```

##### Example 2:

```
Input: nums = [23,2,6,4,7], k = 6
Output: true
Explanation: [23, 2, 6, 4, 7] is an continuous subarray of size 5 whose elements sum up to 42.
42 is a multiple of 6 because 42 = 7 * 6 and 7 is an integer.
```

##### Example 3:

```
Input: nums = [23,2,6,4,7], k = 13
Output: false
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>0 <= nums[i] <= 10<sup>9</sup></code>
- <code>0 <= sum(nums[i]) <= 2<sup>31</sup> - 1</code>
- <code>1 <= k <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(n)
# Space: O(min(n, k))
class Solution:
    def checkSubarraySum(self, nums: List[int], k: int) -> bool:
        remainders, s = {0: -1}, 0
        for i, num in enumerate(nums):
            s += num
            mod = s % k
            if mod in remainders:
                if remainders[mod] < i - 1:
                    return True
            else:
                remainders[mod] = i
        return False
```

## Notes
- A subarray ending at the current `i` must be 'good' if the remainder of the current subarray prefix ending at `i` equals the remainder of a smaller prefix ending at `j`, and `i - j > 1`. Note that to handle the case where a full prefix is a multiple of `k` we preload the `remainders` hash table with `0: -1`, which means the empty prefix subarray has a prefix sum of `0`.