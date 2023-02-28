# 600. Non-negative Integers without Consecutive Ones - Hard

Given a positive integer `n`, return the number of the integers in the range `[0, n]` whose binary representations do not contain consecutive ones.

##### Example 1:

```
Input: n = 5
Output: 5
Explanation:
Here are the non-negative integers <= 5 with their corresponding binary representations:
0 : 0
1 : 1
2 : 10
3 : 11
4 : 100
5 : 101
Among them, only integer 3 disobeys the rule (two consecutive ones) and the other 5 satisfy the rule. 
```

##### Example 2:

```
Input: n = 1
Output: 2
```

##### Example 3:

```
Input: n = 2
Output: 3
```

##### Constraints:

- <code>1 <= n <= 10<sup>9</sup></code>

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def findIntegers(self, n: int) -> int:
        dp = [0] * 32
        dp[0], dp[1] = 1, 2
        for i in range(2, 32):
            dp[i] = dp[i - 1] + dp[i - 2]
        result = prev = 0
        bit, i = 1 << 31, 31
        while bit:
            if n & bit:
                result += dp[i]
                if prev:
                    return result
                prev = 1
            else:
                prev = 0
            i -= 1
            bit >>= 1
        return result + 1
```

## Notes
- This solution seems easy but is deceptively tricky. If the prompt were to simply find the number of integers with a certain number of bits that do not have consecutive bits, we could simply use a fibonacci dp relationship. The application of fibonacci and dp stems from the idea that the number of integers with a certain number of bits with non-consecutive 1-bits depends on if we put a one or a zero in the current bit position. If we put a zero, we are not restricted by whatever was in the previous bit position (to the right), and so the number of possibilities for putting a zero at the current bit position is `dp[i - 1]`, the total number of possibilities (i.e., a one or a zero) for the previous bit position. If we put a one, we can only consider possibilities where the previous bit position is not a one, which is equivalent to `dp[i - 2]`, the number of possibilities for a zero in the previous position. 
- In the code, `dp[i]` represents the number of non-consecutive one bit integers less than `1 << i`. Hence, to find the number of non-consecutive one bit integers less than `n`, we need to accumulate all `dp[i]` for `n & (1 << i) != 0`, with the caveat that for consecutive one bits in `n` we stop prematurely.