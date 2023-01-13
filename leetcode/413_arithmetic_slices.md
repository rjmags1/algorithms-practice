# 413. Arithmetic Slices - Medium

An integer array is called arithmetic if it consists of at least three elements and if the difference between any two consecutive elements is the same.

- For example, `[1,3,5,7,9]`, `[7,7,7,7]`, and `[3,-1,-5,-9]` are arithmetic sequences.

Given an integer array `nums`, return the number of arithmetic subarrays of `nums`.

A subarray is a contiguous subsequence of the array.

##### Example 1:

```
Input: nums = [1,2,3,4]
Output: 3
Explanation: We have 3 arithmetic slices in nums: [1, 2, 3], [2, 3, 4] and [1,2,3,4] itself.
```

##### Example 2:

```
Input: nums = [1]
Output: 0
```

##### Constraints:

- `1 <= nums.length <= 5000`
- `-1000 <= nums[i] <= 1000`

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def numberOfArithmeticSlices(self, nums: List[int]) -> int:
        n = len(nums)
        dp, result = [-1] * n, 0
        for i in range(2, n):
            if nums[i] - nums[i - 1] == nums[i - 1] - nums[i - 2]:
                dp[i] = dp[i - 1] if dp[i - 1] != -1 else i - 2
                result += i - dp[i] - 1
        return result
```

## Notes
- Each time we find that the difference between the current and the previous element is the same as the difference between the previous element and the element before the previous element, as long as we know the index of the first element in the current arithmetic 'chain', we can always know the number of arithmetic subarrays that end at the current index. 
- Note this solution could be trivially optimized to constant space with a sliding window approach; this would involve adding `windowsize - 2` to `result` everytime we expand the window to `windowsize >= 3`.