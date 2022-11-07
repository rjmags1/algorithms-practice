# 75. Sort Colors - Medium

Given an array `nums` with `n` objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.

We will use the integers `0`, `1`, and `2` to represent the color red, white, and blue, respectively.

You must solve this problem without using the library's sort function.

##### Example 1:

```
Input: nums = [2,0,2,1,1,0]
Output: [0,0,1,1,2,2]
```

##### Example 2:

```
Input: nums = [2,0,1]
Output: [0,1,2]
```

##### Constraints:


- `n == nums.length`
- `1 <= n <= 300`
- `nums[i]` is either `0`, `1`, or `2`.


Follow-up: Could you come up with a one-pass algorithm using only constant extra space?

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def sortColors(self, nums: List[int]) -> None:
        n, p1 = len(nums), 0
        while p1 < n and nums[p1] == 0:
            p1 += 1
        p2 = n - 1
        while p2 > -1 and nums[p2] == 2:
            p2 -= 1
        
        i = p1
        while i <= p2:
            if nums[i] == 1:
                i += 1
                continue
            if nums[i] == 2:
                nums[i], nums[p2] = nums[p2], nums[i]
            if nums[i] == 0:
                nums[i], nums[p1] = nums[p1], nums[i]
            while nums[p1] == 0:
                p1 += 1
            while nums[p2] == 2:
                p2 -= 1
            i = max(i, p1)
```

## Notes
- Main thing here is if we make sure all `0`'s are at the front of the array and all `2`'s are at the back, all the `1`'s will end up in the middle. `p1` and `p2` always point to the next location into which we will swap the next encountered `0` or `1`, respectively. 