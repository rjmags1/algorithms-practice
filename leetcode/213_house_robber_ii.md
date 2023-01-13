# 213. House Robber II - Medium

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array `nums` representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

##### Example 1:

```
Input: nums = [2,3,2]
Output: 3
Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.
```

##### Example 2:

```
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.
```

##### Example 3:

```
Input: nums = [1,2,3]
Output: 3
```

##### Constraints:

- `1 <= nums.length <= 100`
- `0 <= nums[i] <= 1000`

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def rob(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 1:
            return nums[0]
        a, b = nums[:n - 1], nums[1:]
        def maxsubnoadj(nums):
            n = len(nums)
            if n < 3:
                return nums[0] if n == 1 else max(nums[0], nums[1])
            first, second = nums[0], nums[1]
            for i in range(2, n):
                num = nums[i]
                first, second = max(first, second), max(first + num, second)
            return second
        return max(maxsubnoadj(a), maxsubnoadj(b))
```

## Notes
- Note the space could easily be optimized to `O(1)` by modifying the `maxsubnoadj` function to work over a range of indices of the original input, as opposed to slicing into new functions.
- The trick to avoiding considering cycles in this question is simply considering the biggest possible subarrays that would not have adjacent start and end indices, and then returning the largest max nonadjacent subset sum of these two subarrays.
- In the `maxsubnoadj` function, `first` always holds the maximum nonadjacent subset sum at the start of the current iteration for `num`, and `second` always holds the maximum adjacent subset sum.