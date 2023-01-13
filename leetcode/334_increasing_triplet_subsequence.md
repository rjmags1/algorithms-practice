# 334. Increasing Triplet Subsequence - Medium

Given an integer array nums, return `true` if there exists a triple of indices `(i, j, k)` such that `i < j < k` and `nums[i] < nums[j] < nums[k]`. If no such indices exists, return `false`.

##### Example 1:

```
Input: nums = [1,2,3,4,5]
Output: true
Explanation: Any triplet where i < j < k is valid.
```

##### Example 2:

```
Input: nums = [5,4,3,2,1]
Output: false
Explanation: No triplet exists.
```

##### Example 3:

```
Input: nums = [2,1,5,0,4,6]
Output: true
Explanation: The triplet (3, 4, 5) is valid because nums[3] == 0 < nums[4] == 4 < nums[5] == 6.
```

##### Constraints:

- <code>1 <= nums.length <= 5 * 10<sup>5</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>

Follow-up: Could you implement a solution that runs in `O(n)` time complexity and `O(1)` space complexity?

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def increasingTriplet(self, nums: List[int]) -> bool:
        min1 = min2 = None
        for i, num in enumerate(nums):
            if min1 is None or num < nums[min1]:
                min1 = i
            elif num > nums[min1]:
                if min2 is None:
                    min2 = i
                elif num > nums[min2]:
                    return True
                elif num < nums[min2]:
                    min2 = i
                    
        return False
```

## Notes
- This solution is based on the <code>O(n<sup>2</sup>)</code> dynamic programming solution where we find the max increasing subsequence length for each prefix array. It turns out that the only information we need to know to determine if an increasing triplet exists in `nums` is the index of the lowest `i` we have seen so far and the index of the lowest `j` we have seen so far. We can update `i` whenever we encounter an element less than the current `i`, and we can update `j` whenever we find an element greater than the current `i`. As soon as we find a `k`, we can return `True` (`i` -> `min1`, `j` -> `min2` in the code). It does not matter if `i` and `j` point to elements that do not correspond to the same increasing triplet, all that matters is that if we have found a `j` it is guaranteed that it is the smallest possible second element in an increasing doublet that we have seen so far.