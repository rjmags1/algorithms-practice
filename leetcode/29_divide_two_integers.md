# 29. Divide Two Integers - Medium

Given two integers `dividend` and `divisor`, divide two integers without using multiplication, division, and mod operator.

The integer division should truncate toward zero, which means losing its fractional part. For example, `8.345` would be truncated to `8`, and `-2.7335` would be truncated to `-2`.

Return the quotient after dividing `dividend` by `divisor`.

Note: Assume we are dealing with an environment that could only store integers within the 32-bit signed integer range: <code>[−2<sup>31</sup>, 2<sup>31</sup> − 1]</code>. For this problem, if the quotient is strictly greater than <code>2<sup>31</sup> - 1</code>, then return <code>2<sup>31</sup> - 1</code>, and if the quotient is strictly less than <code>-2<sup>31</sup></code>, then return <code>-2<sup>31</sup></code>.

##### Example 1:

```
Input: dividend = 10, divisor = 3
Output: 3
Explanation: 10/3 = 3.33333.. which is truncated to 3.
```

##### Example 2:

```
Input: dividend = 7, divisor = -3
Output: -2
Explanation: 7/-3 = -2.33333.. which is truncated to -2.
```

##### Constraints:

- <code>-2<sup>31</sup> <= dividend, divisor <= 2<sup>31</sup> - 1</code>
- `divisor != 0`

## Solution 1

```
# Time: O(log(n))
# Space: O(log(n))
MAX_INT, MIN_INT = 2 ** 31 - 1, -2 ** 31
class Solution:
    def divide(self, dividend: int, divisor: int) -> int:
        if dividend == MIN_INT and divisor == -1:
            return MAX_INT
        
        neg = (dividend < 0 or divisor < 0) and not (dividend < 0 and divisor < 0)
        dividend, divisor = abs(dividend), abs(divisor)
        
        if divisor == 1:
            return -dividend if neg else dividend
        
        doubles = []
        curr, multiple = divisor, 1
        while curr <= dividend:
            doubles.append((curr, multiple))
            curr += curr
            multiple += multiple
        
        result, remaining = 0, dividend
        for i in range(len(doubles) - 1, -1, -1):
            amount, multiple = doubles[i]
            if remaining >= amount:
                remaining -= amount
                result += multiple
                if remaining < divisor:
                    break
                    
        return -result if neg else result
```

## Notes
- We could naively repeatedly subtract divisor from dividend to get our answer, but this is much less efficient than subtracting doubles of the divisor, which is the strategy implemented in the above solution.

## Solution 2

```
# Time: O(log(n))
# Space: O(1)
MAX_INT, MIN_INT = 2 ** 31 - 1, -2 ** 31
class Solution:
    def divide(self, dividend: int, divisor: int) -> int:
        if dividend == MIN_INT and divisor == -1:
            return MAX_INT
        
        neg = (dividend < 0 or divisor < 0) and not (dividend < 0 and divisor < 0)
        dividend, divisor = abs(dividend), abs(divisor)
        
        if divisor == 1:
            return -dividend if neg else dividend
        
        highestDouble, multiple = divisor, 1
        while highestDouble <= dividend:
            multiple <<= 1
            highestDouble <<= 1
        
        result, remaining = 0, dividend
        while highestDouble > 0:
            if remaining >= highestDouble:
                remaining -= highestDouble
                result += multiple
                if remaining < divisor:
                    break
            highestDouble >>= 1
            multiple >>= 1
                    
        return -result if neg else result
```

## Notes
- Instead of storing all of the doubles of `divisor`, we can use left bitshifting to generate the first double of `divisor` greater than `dividend`, and then right bitshift back down.