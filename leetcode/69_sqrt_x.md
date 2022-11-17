# 69. Sqrt(x) - Easy

Given a non-negative integer `x`, return the square root of `x` rounded down to the nearest integer. The returned integer should be non-negative as well.

You must not use any built-in exponent function or operator.

For example, do not use `pow(x, 0.5)` in c++ or `x ** 0.5` in python.


##### Example 1:

```
Input: x = 4
Output: 2
Explanation: The square root of 4 is 2, so we return 2.
```

##### Example 2:

```
Input: x = 8
Output: 2
Explanation: The square root of 8 is 2.82842..., and since we round it down to the nearest integer, 2 is returned.
```

##### Constraints:

- <code>0 <= x <= 2<sup>31</sup> - 1</code>

## Solution 1

```
# Time: O(n)
# Space: O(1)
class Solution:
    def mySqrt(self, x: int) -> int:
        y = z = 0
        while z <= x:
            y += 1
            z = y * y
        return y - 1
```

## Notes
- Linearly search for result in the search space for square root of `x`.

## Solution 2

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def mySqrt(self, x: int) -> int:
        if x < 3:
            return 0 if x == 0 else 1
        
        l, r = 2, x // 2
        while l <= r:
            mid = (l + r) // 2
            sq = mid * mid
            if sq == x:
                return mid
            if sq > x:
                r = mid - 1
            else:
                l = mid + 1
        
        return r
```

## Notes
- Logarithmically search for result in search space for square root of `x`. Notice that the search space's upper limit is `x // 2`.
- Also notice how the iteration condition for binary search includes when `l == r`. This allows simple handling of edge case where the last possible value for `mid` is greater than or less than a non-integer square root value of `x`.