# 507. Perfect Number - Easy

A perfect number is a positive integer that is equal to the sum of its positive divisors, excluding the number itself. A divisor of an integer `x` is an integer that can divide `x` evenly.

Given an integer `n`, return `true` if `n` is a perfect number, otherwise return `false`.

##### Example 1:

```
Input: num = 28
Output: true
Explanation: 28 = 1 + 2 + 4 + 7 + 14
1, 2, 4, 7, and 14 are all divisors of 28.
```

##### Example 2:

```
Input: num = 7
Output: false
```

##### Constraints:

- <code>1 <= num <= 10<sup>8</sup></code>

## Solution

```
# Time: O(sqrt(n))
# Space: O(1)
class Solution:
    def checkPerfectNumber(self, num: int) -> bool:
        return num > 1 and sum(x + num // x for x in range(2, int(math.sqrt(num)) + 1) if num % x == 0) + 1 == num
```

## Notes
- Use a generator to get constant space.