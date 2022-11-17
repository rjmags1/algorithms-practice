# 162. Find Peak Element - Medium

A peak element is an element that is strictly greater than its neighbors.

Given a 0-indexed integer array `nums`, find a peak element, and return its index. If the array contains multiple peaks, return the index to any of the peaks.

You may imagine that `nums[-1] = nums[n] = -∞`. In other words, an element is always considered to be strictly greater than a neighbor that is outside the array.

You must write an algorithm that runs in `O(log n)` time.

##### Example 1:

```
Input: nums = [1,2,3,1]
Output: 2
Explanation: 3 is a peak element and your function should return the index number 2.
```

##### Example 2:

```
Input: nums = [1,2,1,3,5,6,4]
Output: 5
Explanation: Your function can return either index number 1 where the peak element is 2, or index number 5 where the peak element is 6.
```

##### Constraints:

- `1 <= nums.length <= 1000`
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>
- `nums[i] != nums[i + 1]` for all valid `i`.

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def findPeakElement(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 1:
            return 0
            
        def isPeak(i):
            if i == 0:
                return nums[i] > nums[i + 1]
            if i == n - 1:
                return nums[i - 1] < nums[i]
            return nums[i - 1] < nums[i] > nums[i + 1]
        
        def upslope(i):
            if i == 0:
                return nums[i] < nums[i + 1]
            return nums[i - 1] < nums[i] < nums[i + 1]
        
        l, r = 0, len(nums) - 1
        while l <= r:
            mid = (l + r) // 2
            if isPeak(mid):
                return mid
            if upslope(mid):
                l = mid + 1
            else:
                r = mid - 1
```

## Notes
- This problem can be confusing because the prompt hints at binary search but does not guarantee a sorted array. However, we can still apply the principles of binary search (splitting the search space in half on each iteration) with an alternative splitting condition. Once you notice the constraint about non-identical adjacent elements, the idea becomes clear. Namely, if the current `mid` is not a peak, it must be part of an upslope or downslope. If it is part of an upslope (i.e., `[..., 1, 2, 3, ...]` with `mid` pointing to `2` would be an upslope), a peak must be to the right of `mid`. Similarly, if `mid` is part of a downslope, a peak must be to the left of `mid`.