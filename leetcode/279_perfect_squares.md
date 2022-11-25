# 279. Perfect Squares - Medium

Given an integer `n`, return the least number of perfect square numbers that sum to `n`.

A perfect square is an integer that is the square of an integer; in other words, it is the product of some integer with itself. For example, `1`, `4`, `9`, and `16` are perfect squares while `3` and `11` are not.

##### Example 1:

```
Input: n = 12
Output: 3
Explanation: 12 = 4 + 4 + 4.
```

##### Example 2:

```
Input: n = 13
Output: 2
Explanation: 13 = 4 + 9.
```

##### Constraints:

- <code>1 <= n <= 10<sup>4</sup></code>

## Solution 1

```
# Time: O(n * sqrt(n))
# Space: O(n)
class Solution:
    def numSquares(self, n: int) -> int:
        @cache
        def rec(n):
            if n == 0:
                return 0
            
            highestfit = int(sqrt(n))
            result = inf
            for sq in range(highestfit, 0, -1):
                result = min(result, 1 + rec(n - sq * sq))
            return result
        
        return rec(n)
```

## Notes
- We want to be a little greedy with how we consider sums of squares. For a given `n`, we want to take the biggest chunk out of it as we can, and see if we can get a square sum this way. The biggest chunk we can take out of a given `n` is truncated `sqrt(n)`.
- We also use caching to avoid recalculating overlapping subproblems.
- This solution will fail sometimes on leetcode because we are using recursion with python, which can cause some slowdown due to continuous pushing and popping to the call stack. For top-down recursive caching approaches like this, we can usually convert to an iterative bottom up approach to avoid the call stack flurry action inherent to recursion.
- For complexity justification, consider when `n` is prime.

## Solution 2

```
# Time: O(n * sqrt(n))
# Space: O(n)
class Solution:
    def numSquares(self, n: int) -> int:
        dp = [inf] * (n + 1)
        dp[0] = 0
        for num in range(1, n + 1):
            highestfit = int(sqrt(num))
            for sq in range(highestfit, -1, -1):
                dp[num] = min(dp[num], 1 + dp[num - sq * sq])
        return dp[n]
```

## Notes
- Bottom-up implementation of solution 1. 

## Solution 3

```
# Time: O(n * sqrt(n))
# Space: O(n)
class Solution:
    def numSquares(self, n: int) -> int:
        q = deque([(n, 0)])
        squares = [sq * sq for sq in range(1, int(sqrt(n)) + 1)]
        while q:
            curr, length = q.popleft()
            for square in squares:
                if square > curr:
                    break
                if curr - square == 0:
                    return length + 1
                q.append((curr - square, length + 1))
```

## Notes
- Instead of recursing on every difference between some `n` and perfect squares less than it down to the point that `n` reaches `0`, it would be better to consider differences in a bfs fashion.