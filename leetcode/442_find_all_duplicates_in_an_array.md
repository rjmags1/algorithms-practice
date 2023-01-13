# 442. Find All Duplicates in an Array - Medium

Given an integer array `nums` of length `n` where all the integers of `nums` are in the range `[1, n]` and each integer appears once or twice, return an array of all the integers that appears twice.

You must write an algorithm that runs in `O(n)` time and uses only constant extra space.

##### Example 1:

```
Input: nums = [4,3,2,7,8,2,3,1]
Output: [2,3]
```

##### Example 2:

```
Input: nums = [1,1,2]
Output: [1]
```

##### Example 3:

```
Input: nums = [1]
Output: []
```

##### Constraints:

- `n == nums.length`
- `1 <= nums[i] <= n`
- <code>1 <= n <= 10<sup>5</sup></code>
- Each element in `nums` appears once or twice.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def findDuplicates(self, nums: List[int]) -> List[int]:
        result = []
        for num in nums:
            num = abs(num)
            mapidx = num - 1
            if nums[mapidx] < 0:
                result.append(num)
            nums[mapidx] = -nums[mapidx]
            
        return result
```

## Notes
- Any number that appears twice, if we use indexes as hash keys, will have the element at its mapped index be negative the second time we encounter the number as we iterate.