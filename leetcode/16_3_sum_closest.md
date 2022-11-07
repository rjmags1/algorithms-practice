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
    def threeSumClosest(self, nums: List[int], target: int) -> int:
        nums.sort()
        n = len(nums)
        closest = sum(nums[:3])
        for i in range(n - 2):
            a = nums[i]
            if i > 0 and a == nums[i - 1]:
                continue
                
            j, k = i + 1, n - 1
            while j < k:
                b, c = nums[j], nums[k]
                curr = a + b + c
                if abs(target - curr) < abs(target - closest):
                    closest = curr
                
                if curr == target:
                    break
                while curr < target and j < k and nums[j] == b:
                    j += 1
                while curr > target and j < k and nums[k] == c:
                    k -= 1
            
        return closest
```

## Notes
- We can break when we find a triplet whose sum equals `target`, because the prompt is asking us for a single answer instead of all possible answers.