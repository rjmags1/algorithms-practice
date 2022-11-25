# 276. Paint Fence - Medium

You are painting a fence of `n` posts with `k` different colors. You must paint the posts following these rules:

- Every post must be painted exactly one color.
- There cannot be three or more consecutive posts with the same color.

Given the two integers `n` and `k`, return the number of ways you can paint the fence.

##### Example 1:

```
Input: n = 3, k = 2
Output: 6
Explanation: All the possibilities are shown.
Note that painting all the posts red or all the posts green is invalid because there cannot be three posts in a row with the same color.
```

##### Example 2:

```
Input: n = 1, k = 1
Output: 1
```

##### Example 3:

```
Input: n = 7, k = 2
Output: 42
```

##### Constraints:

- <code>1 <= k <= 10<sup>5</sup></code>
- `1 <= n <= 50`
- The testcases are generated such that the answer is in the range <code>[0, 2<sup>31</sup> - 1]</code> for the given `n` and `k`.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def numWays(self, n: int, k: int) -> int:
        prev1, prev2 = k, k * k
        if n < 3:
            return prev1 if n == 1 else prev2
        for p in range(3, n + 1):
            ways = (k - 1) * (prev1 + prev2)
            prev1, prev2 = prev2, ways
        return prev2
```

## Notes
- This is one of those annoying dp problems where after a bit of unsuccessful attempts to intuitively derive a recurrence relation, it is best to draw out some examples (recursion tree with answers to subproblems) and then try to come up with a formula that matches works for all examples. 