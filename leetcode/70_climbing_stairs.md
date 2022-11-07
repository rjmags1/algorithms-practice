# 70. Climbing Stairs - Easy

You are climbing a staircase. It takes `n` steps to reach the top.

Each time you can either climb `1` or `2` steps. In how many distinct ways can you climb to the top?

##### Example 1:

```
Input: n = 2
Output: 2
Explanation: There are two ways to climb to the top.
1. 1 step + 1 step
2. 2 steps
```

##### Example 2:

```
Input: n = 3
Output: 3
Explanation: There are three ways to climb to the top.
1. 1 step + 1 step + 1 step
2. 1 step + 2 steps
3. 2 steps + 1 step
```

##### Constraints:

- `1 <= n <= 45`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def climbStairs(self, n: int) -> int:
        if n < 3:
            return 2 if n == 2 else 1
        first, second = 1, 2
        for i in range(3, n):
            first, second = second, first + second
        return first + second
```

## Notes
- This is a basic bottom-up dp problem with recurrence relation `dp[i] = dp[i - 1] + dp[i - 2]`. Problems with recurrence relations like these can be solved in constant space because to calculate the answer to the current subproblem all we need to know is the answers to the previous two subproblems.