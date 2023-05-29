# 33. Search in Rotated Sorted Array - Medium

There is an integer array `nums` sorted in ascending order (with distinct values).

Prior to being passed to your function, `nums` is possibly rotated at an unknown pivot index `k` `(1 <= k < nums.length)` such that the resulting array is `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]` (0-indexed). For example, `[0,1,2,4,5,6,7]` might be rotated at pivot index 3 and become `[4,5,6,7,0,1,2]`.

Given the array `nums` after the possible rotation and an integer `target`, return the index of `target` if it is in `nums`, or `-1` if it is not in `nums`.

You must write an algorithm with `O(log n)` runtime complexity.

##### Example 1:

```
Input: nums = [4,5,6,7,0,1,2], target = 0
Output: 4
```

##### Example 2:

```
Input: nums = [4,5,6,7,0,1,2], target = 3
Output: -1
```

##### Example 3:

```
Input: nums = [1], target = 0
Output: -1
```

##### Constraints:

- `1 <= nums.length <= 5000`
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>
- All values of `nums` are unique.
- `nums` is an ascending array that is possibly rotated.
- <code>-10<sup>4</sup> <= target <= 10<sup>4</sup></code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        i, j = 0, len(nums) - 1
        while i <= j:
            mid = (i + j) // 2
            l, r, m = nums[i], nums[j], nums[mid]
            if m == target:
                return mid
            
            leftSorted = l <= m
            if leftSorted:
                if l <= target < m:
                    j = mid - 1
                else:
                    i = mid + 1
            else:
                if m < target <= r:
                    i = mid + 1
                else:
                    j = mid - 1
        
        return -1
```

## Notes
- Key to this problem is recognizing that at least one half of a given subarray is always going to be sorted when dealing with a rotated array.