# 592. Fraction Addition and Subtraction - Medium

Given a string `expression` representing an expression of fraction addition and subtraction, return the calculation result in string format.

The final result should be an irreducible fraction. If your final result is an integer, change it to the format of a fraction that has a denominator `1`. So in this case, `2` should be converted to `2/1`.

##### Example 1:

```
Input: expression = "-1/2+1/2"
Output: "0/1"
```

##### Example 2:

```
Input: expression = "-1/2+1/2+1/3"
Output: "1/3"
```

##### Example 3:

```
Input: expression = "1/3-1/2"
Output: "-1/6"
```

##### Constraints:

- The input string only contains `'0'` to `'9'`, `'/'`, `'+'` and `'-'`. So does the output.
- Each fraction (input and output) has the format `±numerator/denominator`. If the first input fraction or the output is positive, then `'+'` will be omitted.
- The input only contains valid irreducible fractions, where the numerator and denominator of each fraction will always be in the range `[1, 10]`. If the denominator is `1`, it means this fraction is actually an integer in a fraction format defined above.
- The number of given fractions will be in the range `[1, 10]`.
- The numerator and denominator of the final result are guaranteed to be valid and in the range of 32-bit int.

## Solution

```
from math import lcm, gcd

# Time: 
# Space: 
class Solution:
    def fractionAddition(self, expression: str) -> str:
        fractions, n = [], len(expression)
        for i, c in enumerate(expression):
            if c != '/':
                continue
            num = int(expression[i - 1])
            sign = -1 if i > 1 and expression[i - 2] == '-' else 1
            if i > 1 and expression[i - 2] == '1':
                num = 10
                sign = -1 if i > 2 and expression[i - 3] == '-' else 1
            den = int(expression[i + 1])
            if i < n - 2 and expression[i + 2] == '0':
                den = 10
            fractions.append((num, den, sign))
        den = lcm(*(f[1] for f in fractions))
        num = sum(f[0] * (den // f[1]) * f[2] for f in fractions)
        div = gcd(den, num)
        return f"{num // div}/{den // div}"
```

## Notes
- Parse the string to get exhaustive information about each fraction, being sure to handle present/absent signs as well as double digit numbers (`10`). The common denominator of all fractions in `expression` is the least common multiple of all denominators in `expression`. I use python's `math.lcm` here (note the `*` operator, akin to spread operator is JS/TS, needed because lcm doesn't take iterable as argument) to get the common denominator. The numerator of the unreduced final result is equivalent to the sum of all of the original numerators multiplied by the ratio of the common denominator to the original denominator. To reduce the final result, we need the greatest common denominator between the unreduced numerator and the common denominator, which I obtain here with python's `math.gcd`.
- Instead of using `math.lcm` and `math.gcd`, we could obtain the common denominator and gcd of the unreduced final numerator and common denominator using binary search.