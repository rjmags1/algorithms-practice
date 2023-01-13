# 326. Power of Three - Easy

Given an integer `n`, return `true` if it is a power of three. Otherwise, return `false`.

An integer `n` is a power of three, if there exists an integer `x` such that <code>n == 3<sup>x</sup></code>.

##### Example 1:

```
Input: n = 27
Output: true
Explanation: 27 = 3 * 3 * 3
```

##### Example 2:

```
Input: n = 0
Output: false
```

##### Example 3:

```
Input: n = -1
Output: false
```

##### Constraints:

- <code>-2<sup>31</sup> <= n <= 2<sup>31</sup> - 1</code>

Follow-up: Could you solve it without loops/recursion?

## Solution 1

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def isPowerOfThree(self, n: int) -> bool:
        curr = 1
        while curr < n:
            curr *= 3
        return curr == n
```

## Notes
- Log is base 3

## Solution 2

```
# Time: O(1)
# Space: O(1)
class Solution:
    def isPowerOfThree(self, n: int) -> bool:
        return n > 0 and 1162261467 % n == 0
```

## Notes
- Since we are given 32-bit integer input constraint, we can deduce the largest power of three that can fit in a 32-bit integer to be truncated <code>3<sup>log<sub>3</sub>(2147483647)</sup></code>, which is `1162261467`, or <code>3<sup>19</sup></code>. __Since `3` is prime, we know the only divisors of a power of three are all the powers of three less than it.__ Thus all we need to do is see if the largest possible power of `3` is divisible by `n`.