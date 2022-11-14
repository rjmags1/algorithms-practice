# 198. House Robber - Medium

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array `nums` representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

##### Example 1:

```
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.
```

##### Example 2:

```
Input: nums = [2,7,9,3,1]
Output: 12
Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
Total amount you can rob = 2 + 9 + 1 = 12.
```

##### Constraints:

- `1 <= nums.length <= 100`
- `0 <= nums[i] <= 400`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def rob(self, nums: List[int]) -> int:
        n = len(nums)
        if n < 3:
            return nums[0] if n == 1 else max(nums[0], nums[1])
        
        first, second = nums[0], nums[1]
        for i in range(2, n):
            first, second = max(first, second), max(first + nums[i], second)
        
        return second
```

## Notes
- This is a rewording of max subset sum no adjacent. It is dp because we can use the results of previous subproblems to determine the max subset sum without adjacent elements for subarrays ending at a particular index, using the max sums for the subarrays ending one and two indices before it.
- For a subarry ending at any particular index, the max subset sum with no adjacent elements `second` is either the current element plus the max sum for subarray ending two indices before it (`first`), or just the max sum for the subarray ending at the index before it (excluding the current element, old `second`). We also need to update `first` to be the maximum of the old `first` (max subset sum no adjacent for subarray ending three indices before current index) and the old `second` because the max nonadjacent subarray sum for the next index isn't necessarily the old `second`. Consider an input such as `[2, 1, 1, 2]`.