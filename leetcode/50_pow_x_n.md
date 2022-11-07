# 50. Pow(x, n) - Medium

Implement `pow(x, n)`, which calculates `x` raised to the power `n` (i.e., <code>x<sup>n</sup></code>).

##### Example 1:

```
Input: x = 2.00000, n = 10
Output: 1024.00000
```

##### Example 2:

```
Input: x = 2.10000, n = 3
Output: 9.26100
```

##### Example 3:

```
Input: x = 2.00000, n = -2
Output: 0.25000
Explanation: 2-2 = 1/22 = 1/4 = 0.25
```

##### Constraints:

- `-100.0 < x < 100.0`
- <code>-2<sup>31</sup> <= n <= 2<sup>31</sup>-1</code>
- `n` is an integer. 
- <code>-10<sup>4</sup> <= x<sup>n</sup> <= 10<sup>4</sup></code>

## Solution 1

```
# Time: O(log(n))
# Space: O(log(n))
class Solution:
    def myPow(self, x: float, n: int) -> float:
        @cache
        def calc(x, n):
            if n <= 1:
                return 1 if n == 0 else x
            evenpow = calc(x, n // 2) * calc(x, n // 2)
            return evenpow if n % 2 == 0 else evenpow * x
            
        negpow = n < 0
        calcd = calc(x, abs(n))
        return 1 / calcd if negpow else calcd
```

## Notes
- Instead of multiplying `x` by itself `n` times, we can save ourselves a ton of time by continuously calculating `x` raised to the power of successives halves of `n` using a top-down recursive strategy.
- Notice how we reduce edge cases by using the absolute value of `n` to init our recursion.

# Solution 2

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def myPow(self, x: float, n: int) -> float:
        negpow = n < 0
        n = abs(n)
        result, curr = 1, x
        while n > 0:
            if n & 1:
                result *= curr
            curr *= curr
            n >>= 1
        
        return 1 / result if negpow else result
```

## Notes
- This is the exact same logic as above, except implemented recursively. Used bitwise operators to be cool. As we loop, if `n` is odd, we multiply `result` by `curr` before squaring `curr`. This has the same effect as the `else` clause of the return statement in the `calc` function in Solution 1.