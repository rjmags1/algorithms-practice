# 263. Ugly Number - Easy

An ugly number is a positive integer whose prime factors are limited to `2`, `3`, and `5`.

Given an integer `n`, return `true` if `n` is an ugly number.

##### Example 1:

```
Input: n = 6
Output: true
Explanation: 6 = 2 × 3
```

##### Example 2:

```
Input: n = 1
Output: true
Explanation: 1 has no prime factors, therefore all of its prime factors are limited to 2, 3, and 5.
```

##### Example 3:

```
Input: n = 14
Output: false
Explanation: 14 is not ugly since it includes the prime factor 7.
```

##### Constraints:

- <code>-2<sup>31</sup> <= n <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def isUgly(self, n: int) -> bool:
        if n < 6:
            return n > 0
        while n > 1:
            if n % 2 == 0:
                n //= 2
            elif n % 3 == 0:
                n //= 3
            elif n % 5 == 0:
                n //= 5
            else:
                return False
        return True
```

## Notes
- Attempt to strip out all prime factors one by one until there are no prime factors left or there are no more ugly prime factors left. Note how numbers cannot be factored down past a product of prime factors. In other words, all composite factors can be factored down to prime factors.