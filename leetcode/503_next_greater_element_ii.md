# 503. Next Greater Element II - Medium

Given a circular integer array `nums` (i.e., the next element of `nums[nums.length - 1]` is `nums[0]`), return the next greater number for every element in `nums`.

The next greater number of a number `x` is the first greater number to its traversing-order next in the array, which means you could search circularly to find its next greater number. If it doesn't exist, return `-1` for this number.

##### Example 1:

```
Input: nums = [1,2,1]
Output: [2,-1,2]
Explanation: The first 1's next greater number is 2; 
The number 2 can't find next greater number. 
The second 1's next greater number needs to search circularly, which is also 2.
```

##### Example 2:

```
Input: nums = [1,2,3,4,3]
Output: [2,3,4,-1,4]
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>4</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def nextGreaterElements(self, nums: List[int]) -> List[int]:
        n = len(nums)
        stack, result = [], [-1] * n
        for k in range(2 * n):
            i = k % n
            while stack and nums[stack[-1]] < nums[i]:
                result[stack.pop()] = nums[i]
            if result[i] == -1:
                stack.append(i)
        return result
```

## Notes
- Monotonic decreasing stack that holds elements for which we have not yet found a next greater element; traverse LTR in a circle because it will take at mostt `2` full iterations to find every next greater element for each element, if it exists (ie, the next greater element for the largest element in the array does not exist).