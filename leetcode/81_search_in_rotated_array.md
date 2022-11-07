# 81. Search in Rotated Array - Medium

There is an integer array `nums` sorted in non-decreasing order (not necessarily with distinct values).

Before being passed to your function, `nums` is rotated at an unknown pivot index `k` (`0 <= k < nums.length`) such that the resulting array is `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]` (0-indexed). For example, `[0,1,2,4,4,4,5,6,6,7]` might be rotated at pivot index `5` and become `[4,5,6,6,7,0,1,2,4,4]`.

Given the array `nums` after the rotation and an integer `target`, return `true` if `target` is in `nums`, or `false` if it is not in `nums`.

You must decrease the overall operation steps as much as possible.

##### Example 1:

```
Input: nums = [2,5,6,0,0,1,2], target = 0
Output: true
```

##### Example 2:

```
Input: nums = [2,5,6,0,0,1,2], target = 3
Output: false
```

##### Constraints:


- `1 <= nums.length <= 5000`
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>
- `nums` is guaranteed to be rotated at some pivot.
- <code>-10<sup>4</sup> <= target <= 10<sup>4</sup></code>


Follow-up: This problem is similar to Search in Rotated Sorted Array, but `nums` may contain duplicates. Would this affect the runtime complexity? How and why?

## Solution

```
# Time: O(log(n)) avg, O(n) worst
# Space: O(log(n)) avg, O(n) worst
class Solution:
    def search(self, nums: List[int], target: int) -> bool:
        l, r = 0, len(nums) - 1
        while l <= r:
            m = (l + r) // 2
            left, mid, right = nums[l], nums[m], nums[r]
            if target == mid:
                return True
            
            if left < mid: 
                if left <= target < mid:
                    r = m - 1
                else:
                    l = m + 1
            elif mid < right:
                if mid < target <= right:
                    l = m + 1
                else:
                    r = m - 1
            else:
                return target in nums[l:r + 1]
            
        return False
```

## Notes
- The trickiest part about this problem is handling cases such as `[1, 0, 1, 1, 1, 1]`; this is the reason the acceptance rate on this question is `35%`. Compared to 33. Search in Sorted Array where we are guaranteed distinct elements in `nums`, in this question we are not able to say `mid == left` or `mid == right` means that the left search space or the right search spaces are sorted, respectively. In this case, the right search space is sorted and the left is not when `l = 0` and `r = 5`, but our input could easily be `[1, 1, 1, 1, 0, 1]` and the left search space would be sorted and the right would not. As a result, due to the potential presence of duplicate elements in our input, we can only perform binary search on search spaces where the first and last element are not equal to each other. Otherwise, we must stoop to linear searching.