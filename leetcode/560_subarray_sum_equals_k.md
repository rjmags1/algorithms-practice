# 560. Subarray Sum Equals K - Medium

Given an array of integers `nums` and an integer `k`, return the total number of subarrays whose sum equals to `k`.

A subarray is a contiguous non-empty sequence of elements within an array.

##### Example 1:

```
Input: nums = [1,1,1], k = 2
Output: 2
```

##### Example 2:

```
Input: nums = [1,2,3], k = 3
Output: 2
```

##### Constraints:

- <code>1 <= nums.length <= 2 * 10<sup>4</sup></code>
- <code>-10<sup>7</sup> <= k <= 10<sup>7</sup></code>
- <code>-1000 <= nums[i] <= 1000</code>

## Solution

```
from collections import defaultdict

# Time: O(n)
# Space: O(n)
class Solution:
    def subarraySum(self, nums: List[int], k: int) -> int:
        sums = defaultdict(int)
        sums[0] += 1
        s = result = 0
        for num in nums:
            s += num
            if s - k in sums:
                result += sums[s - k]
            sums[s] += 1
        return result
```

## Notes
- Prefix sums