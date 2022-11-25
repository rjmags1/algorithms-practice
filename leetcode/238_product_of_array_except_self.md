# 238. Product of Array Except Self - Medium

Given an integer array `nums`, return an array `answer` such that `answer[i]` is equal to the product of all the elements of `nums` except `nums[i]`.

The product of any prefix or suffix of `nums` is guaranteed to fit in a 32-bit integer.

You must write an algorithm that runs in `O(n)` time and without using the division operation.

##### Example 1:

```
Input: nums = [1,2,3,4]
Output: [24,12,8,6]
```

##### Example 2:

```
Input: nums = [-1,1,0,-3,3]
Output: [0,0,9,0,0]
```

##### Constraints:

- <code>2 <= nums.length <= 10<sup>5</sup></code>
- <code>-30 <= nums[i] <= 30</code>
- The product of any prefix or suffix of `nums` is guaranteed to fit in a 32-bit integer.

Follow-up: Can you solve the problem in `O(1)` extra space complexity? (The output array does not count as extra space for space complexity analysis.)

## Solution

```
# Time: O(n)
# Space: O(1) (if we don't count result)
class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        n = len(nums)
        result = [1] * n
        for i in range(1, n):
            result[i] = result[i - 1] * nums[i - 1]
        right = nums[-1]
        for i in reversed(range(n - 1)):
            result[i] = result[i] * right
            right *= nums[i]
        return result
```

## Notes
- This is basic dp. The product of numbers to the left of the current number is the number to the left of the current number times the product of numbers to the left of the number to the left of the current number. Same for the product of numbers to the right of the current number. If for each number, we compute the product of all numbers to the left and right of it, we can compute the product of all numbers except self for each number without using the division operator.
- Not using an auxiliary array as the follow-up question requests is fairly trivial, because if we store the left products in the `result`, as we compute right products we only need the current right product if we fill in `result` as we compute right products RTL.