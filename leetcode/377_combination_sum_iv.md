# 377. Combination Sum IV - Medium

Given an array of distinct integers `nums` and a target integer `target`, return the number of possible combinations that add up to `target`.

The test cases are generated so that the answer can fit in a 32-bit integer.

##### Example 1:

```
Input: nums = [1,2,3], target = 4
Output: 7
Explanation:
The possible combination ways are:
(1, 1, 1, 1)
(1, 1, 2)
(1, 2, 1)
(1, 3)
(2, 1, 1)
(2, 2)
(3, 1)
Note that different sequences are counted as different combinations.
```

##### Example 2:

```
Input: nums = [9], target = 3
Output: 0
```

##### Constraints:

- `1 <= nums.length <= 200`
- `1 <= nums[i] <= 1000`
- `1 <= target <= 1000`
- All the elements of `nums` are unique.

Follow-up: What if negative numbers are allowed in the given array? How does it change the problem? What limitation we need to add to the question to allow negative numbers?

## Solution

```
from functools import cache

# Time: O(mn) m = target, n = len(nums)
# Space: O(m)
class Solution:
    def combinationSum4(self, nums: List[int], target: int) -> int:
        n = len(nums)

        @cache
        def rec(rem):
            result = 0
            for num in nums:
                if num >= rem:
                    if num == rem:
                        result += 1
                    continue
                result += rec(rem - num)
            return result
        
        return rec(target)
```

## Notes
- Straightforward backtracking; need to pay attention to the fact the question wants us to consider permutations of elements (duplicates allowed) of `nums`. In terms of the followup, if negative numbers were allowed we would not be able to search prune when `num >= rem` because there could be negative numbers that offset a temporary excess of `rem > target`; however simply removing the search prune condition would lead to an infinite loop of recursive calls for cases with negative numbers. To avoid infinite solutions with negative numbers allowed in the input the question would need to stop allowing duplicate elements to show up in valid ordered subsets.