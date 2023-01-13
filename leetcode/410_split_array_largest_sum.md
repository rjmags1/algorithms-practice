# 410. Split Array Largest Sum - Hard

Given an integer array `nums` and an integer `k`, split `nums` into `k` non-empty subarrays such that the largest sum of any subarray is minimized.

Return the minimized largest sum of the split.

A subarray is a contiguous part of the array.

##### Example 1:

```
Input: nums = [7,2,5,10,8], k = 2
Output: 18
Explanation: There are four ways to split nums into two subarrays.
The best way is to split it into [7,2,5] and [10,8], where the largest sum among the two subarrays is only 18.
```

##### Example 2:

```
Input: nums = [1,2,3,4,5], k = 2
Output: 9
Explanation: There are four ways to split nums into two subarrays.
The best way is to split it into [1,2,3] and [4,5], where the largest sum among the two subarrays is only 9.
```

##### Constraints:

- `1 <= nums.length <= 1000`
- `1 <= k <= min(50, nums.length)`
- <code>0 <= nums[i] <= 10<sup>6</sup></code>

## Solution

```
from functools import cache

# Time: O(n^2 * k)
# Space: O(nk)
class Solution:
    def splitArray(self, nums: List[int], k: int) -> int:
        n, maxint = len(nums), 2 ** 31 - 1
        @cache
        def rec(i, k):
            if k == 1:
                return sum(nums[i:])

            currsum, result = 0, maxint
            for j in range(i, n - k + 1):
                currsum += nums[j]
                subproblemresult = max(currsum, rec(j + 1, k - 1))
                result = min(result, subproblemresult)
                if currsum >= result:
                    break
            return result
        
        return rec(0, k)
```

## Notes
- This problem is an excellent candidate for dynamic programming because we can reuse answers to subproblems; the input constraints similarly indicate that a simple top down caching approach should suffice. However, in order to avoid TLE we must search prune, specifically by not recursing forward whenever the sum of the current subarray is larger than the current result. 
- The optimal solution to this problem is based on binary search; we search the possible maximum subarray sum space, `[max(nums), sum(nums)]`, for the smallest subarray sum `x` that will allow us to split the input array into `k` subarrays whose sums are no greater than `x`. This approach takes `O(nlog(sum(nums) - max(nums)))` time because for each iteration of binary search we check if the current `mid` is small enough such that we can form at least `k` subarrays whose sums are `>= mid`. If yes, we include `mid` in the search space for the next iteration and otherwise we search for `x` to the left of `mid`.