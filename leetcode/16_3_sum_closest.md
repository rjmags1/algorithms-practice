# 16. 3Sum Closest - Medium

Given an integer array `nums` of length `n` and an integer `target`, find three integers in `nums` such that the sum is closest to `target`.

Return the sum of the three integers.

You may assume that each input would have exactly one solution.

##### Example 1:

```
Input: nums = [-1,2,1,-4], target = 1
Output: 2
Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
```

##### Example 2:

```
Input: nums = [0,0,0], target = 1
Output: 0
Explanation: The sum that is closest to the target is 0. (0 + 0 + 0 = 0).
```

##### Constraints:

- `3 <= nums.length <= 500`
- `-1000 <= nums[i] <= 1000`
- <code>-10<sup>4</sup> <= target <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n^2)
# Space: O(n) or O(log(n)) due to sorting
class Solution:
    def threeSumClosest(self, nums, target):
        nums.sort()
        
        closest = None
        for i in range(len(nums) - 2):
            j, k = i + 1, len(nums) - 1
            while j < k:
                sum = nums[i] + nums[j] + nums[k]
                if closest is None or abs(target - closest) > abs(target - sum):
                    closest = sum
                    
                if closest == target:
                    return target
                elif sum > target:
                    k -= 1
                else:
                    j += 1

        return closest
```

## Notes
- We can break when we find a triplet whose sum equals `target`, because the prompt is asking us for a single answer instead of all possible answers.