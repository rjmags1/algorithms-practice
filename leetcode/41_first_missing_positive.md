# 41. First Missing Positive - Hard

Given an unsorted integer array `nums`, return the smallest missing positive integer.

You must implement an algorithm that runs in `O(n)` time and uses constant extra space.

##### Example 1:

```
Input: nums = [1,2,0]
Output: 3
Explanation: The numbers in the range [1,2] are all in the array.
```

##### Example 2:

```
Input: nums = [3,4,-1,1]
Output: 2
Explanation: 1 is in the array but 2 is missing.
```

##### Example 3:

```
Input: nums = [7,8,9,11,12]
Output: 1
Explanation: The smallest positive integer 1 is missing.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def firstMissingPositive(self, nums: List[int]) -> int:
        n = len(nums)
        for i, num in enumerate(nums):
            if num < 1:
                nums[i] = n + 1
        for num in nums:
            mappedIdx = abs(num) - 1
            if mappedIdx > n - 1:
                continue
            mapped = nums[mappedIdx]
            if mapped > 0:
                nums[mappedIdx] *= -1
        for i, num in enumerate(nums):
            if num > 0:
                return i + 1
        return n + 1
```

## Notes
- The main strategy for this problem is using indices as hash keys for seen numbers in the range of relevant missing positive numbers `[1, n]`. These are the relevant numbers to look for in `nums` for this problem because if all of those numbers are missing, the answer is simply `n + 1`. We mark a number in the range, `x`, as not missing by doing `nums[x - 1] *= -1`, once. If we see `x` more than once, we skip the sign-change step because that could make it seem like we haven't seen `x` if `x` occurs an even number of times in `nums`.
- Before we can proceed with the main strategy, we need to do some preprocessing because our input can have non-positive numbers, which will ruin our proposed `O(1)` hashing strategy. The workaround for this in the above solution is to replace any non-positive numbers with `n + 1`, since this is beyond the range of possible answers that could occur in `nums` but is still positive, and so can be used in our proposed hashing strategy. 
- After the main iteration, we simply return the incremented index of the first positive number in `nums`, or `n + 1` if there wasn't one.