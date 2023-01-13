# 448. Find All Numbers Disappeared in an Array - Easy

Given an array `nums` of `n` integers where `nums[i]` is in the range `[1, n]`, return an array of all the integers in the range `[1, n]` that do not appear in `nums`.

##### Example 1:

```
Input: nums = [4,3,2,7,8,2,3,1]
Output: [5,6]
```

##### Example 2:

```
Input: nums = [1,1]
Output: [2]
```

##### Constraints:

- <code>n == nums.length</code>
- <code>1 <= n <= 10<sup>5</sup></code>
- <code>1 <= nums[i] <= n</code>

Follow-up: Could you do it without extra space and in `O(n)` runtime? You may assume the returned list does not count as extra space.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def findDisappearedNumbers(self, nums: List[int]) -> List[int]:
        for i, num in enumerate(nums):
            mapidx = abs(num) - 1
            if nums[mapidx] < 0:
                continue
            nums[mapidx] = -nums[mapidx]
        result = [i + 1 for i in range(len(nums)) if nums[i] > 0]
        for i, num in enumerate(nums):
            if num < 0:
                nums[i] = -nums[i]
        return result
```

## Notes
- Use indices as hash keys, only mark a number in `[1, n]` as seen once by multiplying its mapped index by `-1`.