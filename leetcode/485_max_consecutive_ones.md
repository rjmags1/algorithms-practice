# 485. Max Consecutive Ones - Easy

Given a binary array `nums`, return the maximum number of consecutive `1`'s in the array.

##### Example 1:

```
Input: nums = [1,1,0,1,1,1]
Output: 3
Explanation: The first two digits or the last three digits are consecutive 1s. The maximum number of consecutive 1s is 3.
```

##### Example 2:

```
Input: nums = [1,0,1,1,0,1]
Output: 2
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- `nums[i]` is either `0` or `1`.

## Solution

```
from itertools import groupby

# Time: O(n)
# Space: O(n)
class Solution:
    def findMaxConsecutiveOnes(self, nums: List[int]) -> int:
        return max(len(list(g)) for k, g in groupby(nums) if k == 1) if 1 in nums else 0
```

## Notes
- Could trivially reduce to constant space with more lines.