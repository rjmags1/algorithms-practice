# 343. Integer Break - Medium

Given an integer `n`, break it into the sum of `k` positive integers, where `k >= 2`, and maximize the product of those integers.

Return the maximum product you can get.

##### Example 1:

```
Input: n = 2
Output: 1
Explanation: 2 = 1 + 1, 1 × 1 = 1.
```

##### Example 2:

```
Input: n = 10
Output: 36
Explanation: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36.
```

##### Constraints:

- `2 <= n <= 58`

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def integerBreak(self, n: int) -> int:
        low = [0, 0, 1, 2, 4, 6, 9]
        if n < 7:
            return low[n]
        while n > 6:
            result *= 3
            n -= 3
        return result * low[n]
```

## Notes
- This is pattern recognition unless you use math that is not going to be expected in most interview settings. If we take a look at the first `15` or so numbers in `[2, n]`, we see that all the max products maximize the number of `3`s in them without including any `1`s in them. For `6` we have `3 * 3`, for `7` we would have `3 * 2 * 2`, for `8` we have `3 * 3 * 2`, for `9` we have `3 * 3 * 3`. Once we know the pattern we just translate to code.