# 396. Rotate Function - Medium

You are given an integer array `nums` of length `n`.

Assume <code>arrk</code> to be an array obtained by rotating `nums` by `k` positions clock-wise. We define the rotation function `F` on `nums` as follow:

- `F(k) = 0 * arrk[0] + 1 * arrk[1] + ... + (n - 1) * arrk[n - 1]`.

Return the maximum value of `F(0), F(1), ..., F(n-1)`.

The test cases are generated so that the answer fits in a 32-bit integer.

##### Example 1:

```
Input: nums = [4,3,2,6]
Output: 26
Explanation:
F(0) = (0 * 4) + (1 * 3) + (2 * 2) + (3 * 6) = 0 + 3 + 4 + 18 = 25
F(1) = (0 * 6) + (1 * 4) + (2 * 3) + (3 * 2) = 0 + 4 + 6 + 6 = 16
F(2) = (0 * 2) + (1 * 6) + (2 * 4) + (3 * 3) = 0 + 6 + 8 + 9 = 23
F(3) = (0 * 3) + (1 * 2) + (2 * 6) + (3 * 4) = 0 + 2 + 12 + 12 = 26
So the maximum value of F(0), F(1), F(2), F(3) is F(3) = 26.
```

##### Example 2:

```
Input: nums = [100]
Output: 0
```

##### Constraints:

- `n == nums.length`
- <code>1 <= n <= 10<sup>5</sup></code>
- `-100 <= nums[i] <= 100`

## Solution

```
from collections import deque

# Time: O(n)
# Space: O(n)
class Solution:
    def maxRotateFunction(self, nums: List[int]) -> int:
        s, d, n = sum(nums), deque(nums), len(nums)
        result = seq = sum([i * num for i, num in enumerate(nums)])
        for _ in range(1, n):
            seq = seq + (s - d[-1]) - (d[-1] * (n - 1))
            result = max(result, seq)
            d.appendleft(d.pop())
        return result
```

## Notes
- Instead of manually calculating each rotation function value, we can see a transition function from `F(k)` to `F(k + 1)` to be `F(k + 1) = F(k) + (sum(nums) - prevrotatedlast) - prevrotatedlast * (n - 1)`. In other words, to get to the next `F(k)` we incremented all of the multipliers of the digits in the previous sequence, and handle the old last number (its multiple becomes `0`).
- Note this solution could be trivially reduced to constant space but the double ended queue is good for visualization/understanding.