# 540. Single Element in a Sorted Array - Medium

You are given a sorted array consisting of only integers where every element appears exactly twice, except for one element which appears exactly once.

Return the single element that appears only once.

Your solution must run in `O(log n)` time and `O(1)` space.

##### Example 1:

```
Input: nums = [1,1,2,3,3,4,4,8,8]
Output: 2
```

##### Example 2:

```
Input: nums = [3,3,7,7,10,11,11]
Output: 10
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>0 <= nums[i] <= 10<sup>5</sup></code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def singleNonDuplicate(self, nums: List[int]) -> int:
        n = len(nums)
        l, r = 0, n - 1
        def other(i):
            if i > 0 and nums[i - 1] == nums[i]:
                return i - 1
            return i + 1 if i < n - 1 and nums[i + 1] == nums[i] else None

        while l < r:
            mid = (l + r) // 2
            partner = other(mid)
            if partner is None:
                l = mid
                break
            right = max(mid, partner)
            if right & 1:
                l = mid + 1
            else:
                r = mid - 1
        return nums[l]
```

## Notes
- Modified binary search. We can always tell if the single number is before or after the current pair based on the indices of either of the numbers in the pair.